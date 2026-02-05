# VOID DIVER Security Analysis & Modding Framework

Security research and modding documentation for **VOID DIVER: Escape from the Abyss Demo**.

---

## Important Notes

**This applies to the demo only.** The full release will have different (and likely stronger) protection. Don't expect these findings to transfer.

This is educational security research on software I own. Use this information responsibly.

---

## Summary

| Protection | Implementation | Status |
|------------|----------------|--------|
| Asset Encryption | Single-byte XOR | Weak |
| Anti-Cheat | ACTk present but inactive | Not enforcing |
| Code Obfuscation | None | Open |
| Integrity Checks | None | Absent |

The demo has minimal protection - expected for a free demo.

---

## Game Architecture

The game doesn't use `Assembly-CSharp.dll` for logic (it's a 7KB stub). The actual code is in:

```
VOID DIVER_Data/Managed/
  De.Base.dll             -- Core types, user data (1.5MB)
  De.InGame.dll           -- Game logic, combat, AI (1.1MB)
  De.Lua.dll              -- Lua scripting
  De.Scenes.dll           -- Scene management
  NemoLib.dll             -- Framework utilities
  MoonSharp.Interpreter.dll -- Lua 5.2 interpreter
  CodeStage.AntiCheat.*.dll -- ACTk (inactive)
```

---

## Asset Encryption

### Lua Scripts

**Location**: `StreamingAssets/LuaEncrypted/*.bytes`
**Method**: Single-byte XOR
**Key**: `0xD2`

```powershell
$bytes = [System.IO.File]::ReadAllBytes("file.bytes")
for ($i = 0; $i -lt $bytes.Length; $i++) {
    $bytes[$i] = $bytes[$i] -bxor 0xD2
}
```

### Data Tables

**Location**: `StreamingAssets/TableEncrypted/*.bytes`
**Method**: Single-byte XOR
**Key**: Derivable from known plaintext (files start with "Id,")

```powershell
$key = $encryptedBytes[0] -bxor [byte][char]'I'
```

### Why It's Weak

- Single-byte XOR breaks with basic frequency analysis
- Static keys hardcoded in `De.Base.dll`
- No integrity verification - modified files load fine
- Known plaintext everywhere (Lua starts with `function`, CSV starts with `Id,`)

---

## Anti-Cheat Analysis

The game ships with CodeStage Anti-Cheat Toolkit (ACTk):

```
CodeStage.AntiCheat.Detectors.Runtime.dll
CodeStage.AntiCheat.ObscuredTypes.Runtime.dll
CodeStage.AntiCheat.Genuine.dll
```

### Detector Status

| Detector | Purpose | Demo Status |
|----------|---------|-------------|
| SpeedHackDetector | Time manipulation | Not initialized |
| InjectionDetector | DLL injection | Not blocking |
| WallHackDetector | Rendering exploits | Not implemented |
| ObscuredCheatingDetector | Memory editing | Not triggering |

BepInEx loads via Unity Doorstop before ACTk initializes, so patches are in place before any detection runs.

### ObscuredTypes

ACTk's memory-protected types (`ObscuredInt`, `ObscuredFloat`, etc.) are partially used in the `User` class but not comprehensively.

---

## Lua Scripting

The game uses MoonSharp for quest/dialog scripting. A `LuaApi` object exposes game functions:

```lua
LuaApi:ShowRadioText(speakerType, speakerId, emotion, text)
LuaApi:GetQuestState()
LuaApi:SetQuestState(state)
LuaApi:GiveEquipment(itemId, count)
```

Since Lua files use known XOR encryption, script modification is straightforward.

---

## Included Tools

| Script | Purpose |
|--------|---------|
| `Script_Resource_Loader.ps1` | Decrypt Lua and Table files |
| `Asset_Bundle_Manager.ps1` | Batch decryption with key derivation |
| `IL_Instruction_Set.ps1` | Dump AntiCheatManager bytecode |
| `Environment_Capability_Query.ps1` | Enumerate game config and ACTk state |
| `Native_Interop_Layer.ps1` | Analyze bootstrap and DI framework |
| `Lua_Integration_Test.ps1` | Test MoonSharp parsing |

---

## Expected Full Release Changes

- Stronger encryption (AES or multi-byte with IV)
- Active ACTk detectors
- Server-side validation
- Possible IL2CPP build or code obfuscation

---

## Related

- [VoidDiverModMenu](https://github.com/msantiagodev/VoidDiverModMenu) - Working mod for the demo

---

## License

MIT - Documentation and tools only. Game assets belong to their respective owners.

---

*- Moises Santiago*
