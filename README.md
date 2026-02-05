# VOID DIVER Security Analysis & Modding Framework

**By Moises Santiago** | Cybersecurity Researcher | Game Hacking Hobbyist

Hey there! I'm Moises, and I spend my day job doing cybersecurity work - pentesting, vulnerability research, the usual. But when I clock out, I like to unwind by poking at games. There's something satisfying about reverse engineering a game's protection and understanding how it all fits together.

This repo documents my findings from digging into **VOID DIVER: Escape from the Abyss Demo**. I figured I'd share what I learned in case other security enthusiasts or modders find it useful.

---

## Before We Go Any Further...

### This Is Demo-Only Research

Look, I want to be crystal clear here: **everything in this repo applies to the free demo only**.

The full game will almost certainly have different protection. Game devs aren't dumb - they ship demos with minimal security because, well, it's a demo. The full release will likely have:

- Proper encryption (not single-byte XOR, lol)
- Active anti-cheat that actually does something
- Server-side validation
- Maybe even IL2CPP compilation

So if you're reading this after the full game drops and wondering why nothing works - that's why.

### The Usual Legal Stuff

This is educational security research. I own the game, I'm analyzing software on my own machine, and I'm sharing knowledge - not exploits for malicious use. If you use this info to do something stupid, that's on you.

---

## What I Found (TL;DR)

Here's the quick rundown for those who don't want to read my rambling:

| Protection | Implementation | My Assessment |
|------------|----------------|---------------|
| Asset Encryption | Single-byte XOR | Laughably weak |
| Anti-Cheat | ACTk present but inactive | Paper tiger |
| Code Obfuscation | None | Wide open |
| Integrity Checks | None observed | Non-existent |

Basically, the demo is completely unprotected. Which makes sense - it's a demo. But it was still fun to tear apart.

---

## The Game's Architecture

First thing I noticed when I opened the Managed folder: `Assembly-CSharp.dll` is only 7KB. That's a stub. The actual game code lives in custom DLLs:

```
VOID DIVER_Data/Managed/
  Assembly-CSharp.dll     ← Empty decoy (7KB)
  De.Base.dll             ← The real stuff (1.5MB)
  De.InGame.dll           ← Combat, AI, game logic (1.1MB)
  De.Lua.dll              ← Lua scripting engine
  De.Scenes.dll           ← Scene management
  NemoLib.dll             ← Custom framework
  MoonSharp.Interpreter.dll ← Lua 5.2 interpreter
  CodeStage.AntiCheat.*.dll ← ACTk (dormant)
```

Smart move by the devs - most script kiddies would open Assembly-CSharp, see nothing, and give up. But anyone who's done this before knows to check file sizes.

---

## The "Encryption" (Air Quotes Intentional)

Okay, so the game encrypts its Lua scripts and data tables. Cool. Let's see what we're working with...

### Lua Scripts

**Location**: `StreamingAssets/LuaEncrypted/*.bytes`

I grabbed a file, threw it in a hex editor, and immediately recognized the pattern. Single-byte XOR. Classic.

**Key**: `0xD2`

That's it. That's the encryption. Every byte XOR'd with `0xD2`.

```powershell
# This is literally all it takes to decrypt
$bytes = [System.IO.File]::ReadAllBytes("encrypted.bytes")
for ($i = 0; $i -lt $bytes.Length; $i++) {
    $bytes[$i] = $bytes[$i] -bxor 0xD2
}
# Congrats, you have plaintext Lua
```

### Data Tables

**Location**: `StreamingAssets/TableEncrypted/*.bytes`

Same deal, different key. But here's the fun part - I didn't even need to find the key in the binary. I just knew the CSV files start with "Id," so:

```powershell
$firstByte = $encryptedBytes[0]
$key = $firstByte -bxor [byte][char]'I'  # Known plaintext attack, baby
```

Boom. Key derived in one line.

### Why This Is Basically Useless Protection

1. **Single-byte XOR is a joke** - Any crypto 101 student can break it
2. **Keys are static** - Same key for every file, forever
3. **No integrity checks** - I can modify files and the game happily loads them
4. **Known plaintext everywhere** - Lua files start with `function` or `--`, CSVs start with `Id,`

I'm not dunking on the devs here - this is fine for a demo. Just don't expect this in the full release.

---

## The Anti-Cheat Situation

The game includes CodeStage Anti-Cheat Toolkit (ACTk). I see these DLLs:

```
CodeStage.AntiCheat.Detectors.Runtime.dll
CodeStage.AntiCheat.ObscuredTypes.Runtime.dll
CodeStage.AntiCheat.Genuine.dll
```

Looks scary, right? Let me show you what's actually happening:

### Detectors: Present But Sleeping

| Detector | What It Should Do | What It Actually Does |
|----------|-------------------|----------------------|
| SpeedHackDetector | Catch time manipulation | Nothing (not initialized) |
| InjectionDetector | Block DLL injection | Nothing (BepInEx works fine) |
| WallHackDetector | Detect rendering hacks | Not even implemented |
| ObscuredCheatingDetector | Catch memory edits | Exists but doesn't trigger |

I loaded BepInEx, injected Harmony patches, modified game values in memory - not a peep from ACTk. The callbacks just aren't hooked up.

### ObscuredTypes: Partial Implementation

ACTk provides encrypted variable types (`ObscuredInt`, `ObscuredFloat`, etc.) that make memory editing harder. The `User` class uses some of these, but it's inconsistent. Plenty of plain `int` and `float` values sitting there unprotected.

### Why BepInEx Just Works

Here's the trick: Unity Doorstop (which BepInEx uses) loads **before** any game code runs:

```
1. Game launches
2. winhttp.dll proxy intercepts (Doorstop)
3. BepInEx loads and patches everything
4. Game assemblies finally load
5. ACTk initializes... but methods are already patched
6. Game runs, thinking everything is fine
```

By the time ACTk wakes up, it's too late. Its detection methods have been neutered.

---

## Lua Scripting Deep Dive

The game uses MoonSharp (Lua 5.2 for .NET) for its quest and dialog systems. Here's what I found interesting:

### The LuaApi Object

The game injects a `LuaApi` userdata object that exposes game functions to Lua:

```lua
-- Dialog stuff
LuaApi:ShowRadioText(speakerType, speakerId, emotion, text)
LuaApi:ShowBubbleText(speakerType, speakerId, text)
LuaApi:OpenDialogAsync(mode)

-- Quest stuff
LuaApi:GetQuestState()
LuaApi:SetQuestState(state)

-- Items
LuaApi:GiveEquipment(itemId, count)

-- And a bunch more...
```

### Script Injection Is Trivial

Since I can decrypt, modify, and re-encrypt Lua files with the known XOR key, I can inject arbitrary Lua code that the game will happily execute. Fun for modding, terrifying from a security perspective.

---

## Tools I Wrote

The `tools/` folder has PowerShell scripts I used during analysis:

| Script | What It Does |
|--------|--------------|
| `Script_Resource_Loader.ps1` | Decrypts Lua and Table files |
| `Asset_Bundle_Manager.ps1` | Batch decryption with key derivation |
| `IL_Instruction_Set.ps1` | Dumps AntiCheatManager IL bytecode |
| `Environment_Capability_Query.ps1` | Enumerates game config and ACTk state |
| `Native_Interop_Layer.ps1` | Analyzes bootstrap and DI framework |
| `Lua_Integration_Test.ps1` | Tests MoonSharp parsing compatibility |

Nothing fancy - just quick scripts I threw together while poking around.

---

## What I Expect in the Full Release

Based on my experience with other Unity games, here's my prediction for the full release:

### Likely Changes

- **Real encryption** - AES or at least multi-byte XOR with IV
- **Active ACTk** - Detectors actually connected and triggering
- **Server validation** - For multiplayer/leaderboards
- **Code obfuscation** - Maybe Dotfuscator or similar

### Possible Changes

- **IL2CPP build** - No more .NET assemblies to decompile
- **Custom packer** - Encrypted asset bundles
- **Kernel anti-cheat** - EasyAntiCheat, BattlEye, etc.

### Unlikely But Possible

- **VMProtect/Themida** - Heavy-duty protection (rare for indie games)
- **Always-online DRM** - Hope not, but you never know

---

## My Other VOID DIVER Project

If you're interested in the actual mod I built using this research:

**[VoidDiverModMenu](https://github.com/msantiagodev/VoidDiverModMenu)** - BepInEx mod with radar overlay, god mode, damage multipliers, and other fun stuff for the demo.

---

## Final Thoughts

This was a fun weekend project. The demo's security is essentially non-existent, which made it great for learning and experimentation. I'm curious to see what the full release looks like - hopefully the devs step up their protection game.

If you're getting into game security research, VOID DIVER's demo is actually a decent starting point. The architecture is clean, the protection is minimal, and there's enough complexity in the Lua scripting to keep things interesting.

Happy hacking (responsibly),

**- Moises Santiago**

---

## License

MIT License - This is documentation and tools only. Game assets belong to their respective owners. Don't be a jerk with this info.
