# VOID DIVER Security Analysis & Modding Framework

Security research and modding documentation for **VOID DIVER: Escape from the Abyss Demo**.

I put this together after spending a weekend poking at the demo's internals. If you're into game security research or just want to understand how Unity games protect (or don't protect) their assets, this might be useful.

---

## Heads Up

**This is demo-only research.** The full game will almost certainly ship with stronger protection. Demos typically have relaxed security since there's not much to protect - the full release will be a different story.

Everything here is educational. I own the game, I'm analyzing it on my own machine, and I'm sharing what I learned. Use this responsibly.

---

## The Short Version

| Layer | What They Did | How Well It Works |
|-------|---------------|-------------------|
| Asset Encryption | Single-byte XOR | Breaks in seconds |
| Anti-Cheat | ACTk included but dormant | Not enforcing anything |
| Code Protection | None | Fully decompilable |
| File Integrity | None | Modified files load fine |

For a demo, this is expected. Nobody's going to invest in serious protection for free content.

---

## How The Game Is Structured

First thing I noticed: `Assembly-CSharp.dll` is basically empty (7KB). That's unusual for Unity games - normally that's where all the game code lives.

Turns out the devs split their code into separate assemblies:

```
VOID DIVER_Data/Managed/
├── Assembly-CSharp.dll      → Empty stub, ignore this
├── De.Base.dll              → Core types, enums, user data (1.5MB)
├── De.InGame.dll            → Combat, AI, gameplay logic (1.1MB)
├── De.Lua.dll               → Lua script runner
├── De.Scenes.dll            → Scene management
├── NemoLib.dll              → Their custom framework
├── MoonSharp.Interpreter.dll → Lua 5.2 interpreter
└── CodeStage.AntiCheat.*.dll → Anti-cheat (sleeping)
```

This is actually a decent organizational choice from a development standpoint. From a security standpoint, it just means you need to look in different places - not a real barrier.

---

## Asset Encryption Deep Dive

The game encrypts Lua scripts and data tables. When I first saw the `.bytes` files in `StreamingAssets`, I expected at least AES or something reasonable. Nope.

### What They Used: Single-Byte XOR

Every byte in the file gets XOR'd with a single key byte. That's it.

**Lua Scripts**
- Location: `StreamingAssets/LuaEncrypted/*.bytes`
- Key: `0xD2`

**Data Tables (CSV)**
- Location: `StreamingAssets/TableEncrypted/*.bytes`
- Key: `0xEA`

### Breaking It

You don't even need to find the key in the binary. Known plaintext attack works instantly:

```powershell
# Lua files often start with "function" or "--"
# Tables always start with "Id,"
# XOR the first encrypted byte with the known first plaintext byte = key

$encrypted = [System.IO.File]::ReadAllBytes("Monster.bytes")
$key = $encrypted[0] -bxor [byte][char]'I'  # Tables start with "Id,"
# $key = 0xEA, done
```

Full decryption is just a loop:

```powershell
for ($i = 0; $i -lt $bytes.Length; $i++) {
    $bytes[$i] = $bytes[$i] -bxor $key
}
```

### Why This Doesn't Really Protect Anything

1. **Single-byte XOR is crypto 101** - First thing you learn to break
2. **Keys are static** - Same key for every file, embedded as constants in `De.Base.dll`
3. **No MAC or integrity check** - I can modify decrypted files, re-encrypt them, and the game loads them without complaint
4. **Predictable plaintext** - Lua files start with known patterns, CSVs have standard headers

I'm not criticizing the devs here - this is fine for a demo. It stops casual users from opening files in Notepad, which is probably all they intended.

---

## Anti-Cheat Analysis

The game includes CodeStage Anti-Cheat Toolkit (ACTk), which is actually a solid product when configured properly. Key word: *when configured properly*.

### What's Installed

```
CodeStage.AntiCheat.Detectors.Runtime.dll
CodeStage.AntiCheat.ObscuredTypes.Runtime.dll
CodeStage.AntiCheat.Genuine.Runtime.dll
CodeStage.AntiCheat.Storage.Runtime.dll
```

### What's Actually Running

| Detector | What It Should Catch | Demo Reality |
|----------|---------------------|--------------|
| SpeedHackDetector | Cheat Engine speedhack | Callbacks not connected |
| InjectionDetector | DLL injection (like BepInEx) | Not blocking anything |
| WallHackDetector | Shader/rendering manipulation | Not implemented |
| ObscuredCheatingDetector | Memory value tampering | Not triggering |
| GenuineValidator | File modifications | Not enforcing |

I loaded BepInEx, patched methods with Harmony, changed values in memory - zero response from ACTk. The DLLs are there, but nobody wired up the detection callbacks.

### Why BepInEx Works

Unity Doorstop (BepInEx's loader) exploits the game's boot sequence:

```
1. OS loads VOID DIVER.exe
2. Game tries to load winhttp.dll (Windows network library)
3. Doorstop's fake winhttp.dll loads first (DLL search order hijack)
4. Doorstop initializes Mono runtime early
5. BepInEx preloader runs, patches target methods
6. Original game assemblies load (with patches already in place)
7. ACTk finally initializes... but its methods are already hooked
8. Game runs, ACTk thinks everything is fine
```

By the time ACTk wakes up, the battle is already lost.

### ObscuredTypes

ACTk provides encrypted primitives (`ObscuredInt`, `ObscuredFloat`, etc.) that make Cheat Engine-style memory scanning harder. The `User` class in `De.Base.dll` uses some of these, but inconsistently. Many gameplay values are still plain types.

---

## Lua Scripting System

The game uses MoonSharp (Lua 5.2 for .NET) for quests, dialogs, and NPC behavior. This is actually a nice architecture choice - it lets designers script content without touching C#.

### How It Works

The game's `LuaRunner` (in `De.Lua.dll`) loads encrypted `.bytes` files, decrypts them, and executes them in a MoonSharp sandbox. A `LuaApi` object gets injected as a global, exposing game functions:

```lua
-- NPC dialog
LuaApi:ShowRadioText(ESpeaker.Npc, npcId, "Default", "Hello!")
LuaApi:ShowBubbleText(ESpeaker.Player, -1, "Hi there")

-- Quest management
local state = LuaApi:GetQuestState()
LuaApi:SetQuestState(ECampaignQuestState.Completed)

-- Rewards
LuaApi:GiveEquipment(100001, 1)  -- Give item ID 100001

-- Async operations (coroutine-based)
await(LuaApi:WaitDelayAsync(1000))  -- Wait 1 second
await(LuaApi:OpenDialogAsync(0))
```

### The Security Implication

Since I can decrypt scripts, modify them, and re-encrypt with the known key, I can inject arbitrary Lua that the game will execute. Want to give yourself items on quest completion? Modify the quest script. Want NPCs to say something different? Edit their dialog Lua.

The `Source_Assets/lua/` folder in this repo contains the decrypted scripts for reference.

---

## Tools Included

PowerShell scripts I wrote during analysis:

| Script | What It Does |
|--------|--------------|
| `Script_Resource_Loader.ps1` | Basic Lua/Table decryption with preview |
| `Asset_Bundle_Manager.ps1` | Batch decryption, auto key derivation |
| `IL_Instruction_Set.ps1` | Extracts IL bytecode from ACTk methods |
| `Environment_Capability_Query.ps1` | Enumerates game config, ACTk status, debug flags |
| `Native_Interop_Layer.ps1` | Analyzes DI framework, bootstrap sequence |
| `Lua_Integration_Test.ps1` | Validates MoonSharp can parse the decrypted Lua |

Nothing fancy - just what I needed to understand the game's internals.

---

## What The Full Release Will Probably Have

Based on patterns I've seen in other Unity games:

**Likely**
- AES encryption or at least rolling XOR keys
- ACTk detectors actually enabled
- Server-side validation for progression/unlocks

**Possible**
- IL2CPP build (no .NET assemblies to decompile)
- Code obfuscation (Dotfuscator, ConfuserEx)
- Custom asset packing

**Less Likely But Possible**
- Kernel-level anti-cheat (EAC, BattlEye)
- Always-online requirement

---

## Related Projects

**[VoidDiverModMenu](https://github.com/msantiagodev/VoidDiverModMenu)** - The actual mod I built using this research. Radar overlay, damage multipliers, god mode, the usual stuff.

---

## Data Reference

The `Source_Assets/` folder contains:
- `lua/` - Decrypted Lua scripts (quests, dialogs, common functions)
- `tables/` - Decrypted CSV data (items, monsters, NPCs, skills, etc.)

Useful if you're modding or just curious about game data.

---

## License

MIT - Documentation and tools. Game assets belong to their respective owners.

---

*- Moises Santiago*
