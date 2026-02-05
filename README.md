# VOID DIVER Security Analysis & Modding Framework

Security research documentation for **VOID DIVER: Escape from the Abyss Demo**.

This repository documents the game's asset protection, encryption schemes, anti-cheat measures, and resource extraction methods for educational and modding purposes.

---

## CRITICAL DISCLAIMERS

### Demo Version Only

**This documentation applies ONLY to the VOID DIVER Demo.**

The full game release will likely have:
- Different/stronger encryption keys
- Additional obfuscation layers
- Server-side validation
- Enhanced anti-tamper measures
- Runtime integrity checks

**Do not expect any of these techniques to work on the full release.**

### Security Will Change

The demo uses minimal protection suitable for a free demo. The full release will almost certainly implement:

| Demo (Current) | Full Release (Expected) |
|----------------|------------------------|
| Single-byte XOR encryption | Multi-key or AES encryption |
| Static encryption keys | Dynamic/derived keys |
| Client-side validation only | Server-side validation |
| Minimal anti-cheat | Full ACTk integration |
| No code obfuscation | IL obfuscation possible |

### Legal Notice

This documentation is for **educational purposes only**. Reverse engineering may violate terms of service. Use responsibly and only on software you own.

---

## Game Architecture Overview

### File Structure

```
VOID DIVER Escape from the Abyss Demo/
  VOID DIVER.exe                    -- Unity player (IL2CPP: No, Mono: Yes)
  VOID DIVER_Data/
    Managed/                        -- .NET assemblies
      Assembly-CSharp.dll           -- Stub only (7KB) - NOT main game code
      De.Base.dll                   -- Core types, User data (1.5MB)
      De.InGame.dll                 -- Game logic, combat, AI (1.1MB)
      De.Lua.dll                    -- Lua runner, LuaApi
      De.Scenes.dll                 -- Scene management
      NemoLib.dll                   -- Framework utilities
      MoonSharp.Interpreter.dll     -- Lua 5.2 interpreter
      CodeStage.AntiCheat.*.dll     -- ACTk anti-cheat libraries
      VContainer.dll                -- Dependency injection
    StreamingAssets/
      LuaEncrypted/                 -- XOR-encrypted Lua scripts (.bytes)
      TableEncrypted/               -- XOR-encrypted CSV data (.bytes)
      AppSetting/                   -- Configuration JSON files
    boot.config                     -- Unity boot configuration
```

### Key Observation

The game does **NOT** use `Assembly-CSharp.dll` for game logic. Instead, all code is in custom assemblies (`De.*.dll`). This is an intentional separation that makes the codebase harder to find for casual modders.

---

## Asset Encryption Analysis

### Encryption Scheme: Single-Byte XOR

The demo uses trivial XOR encryption for script and data assets.

#### Lua Scripts
- **Location**: `StreamingAssets/LuaEncrypted/*.bytes`
- **Key**: `0xD2` (or `0xF4` after XOR transformation with `0x26`)
- **Algorithm**: `decrypted[i] = encrypted[i] XOR 0xD2`

#### Data Tables (CSV)
- **Location**: `StreamingAssets/TableEncrypted/*.bytes`
- **Key**: `0xEA` (derivable from known plaintext)
- **Algorithm**: `decrypted[i] = encrypted[i] XOR key`

### Why This Is Weak

1. **Single-byte XOR is trivially breakable**
   - Known plaintext attack: If you know the file starts with "Id," (CSV header), XOR first byte with 'I' (0x49) to get key
   - Frequency analysis works on larger files

2. **Static keys embedded in code**
   - Keys are constants in `De.Base.dll`
   - No key derivation or rotation

3. **No integrity verification**
   - Modified files are loaded without validation
   - No checksums or signatures

### Decryption Script

```powershell
# Decrypt Lua files
$LUA_KEY = [byte]0xD2

foreach ($file in Get-ChildItem "LuaEncrypted" -Recurse -Filter "*.bytes") {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $decrypted = New-Object byte[] $bytes.Length
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        $decrypted[$i] = $bytes[$i] -bxor $LUA_KEY
    }
    # Save as .lua
    $outPath = $file.FullName -replace '\.bytes$', '.lua'
    [System.IO.File]::WriteAllBytes($outPath, $decrypted)
}
```

```powershell
# Decrypt Table files (derive key from known plaintext)
$firstByte = [System.IO.File]::ReadAllBytes("TableEncrypted/Monster.bytes")[0]
$TABLE_KEY = $firstByte -bxor [byte][char]'I'  # Tables start with "Id,"

foreach ($file in Get-ChildItem "TableEncrypted" -Filter "*.bytes") {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $decrypted = New-Object byte[] $bytes.Length
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        $decrypted[$i] = $bytes[$i] -bxor $TABLE_KEY
    }
    $outPath = $file.FullName -replace '\.bytes$', '.csv'
    [System.IO.File]::WriteAllBytes($outPath, $decrypted)
}
```

---

## Anti-Cheat Analysis

### ACTk (Anti-Cheat Toolkit)

The game includes CodeStage Anti-Cheat Toolkit libraries:

```
CodeStage.AntiCheat.Common.Runtime.dll
CodeStage.AntiCheat.Detectors.Runtime.dll
CodeStage.AntiCheat.ObscuredTypes.Runtime.dll
CodeStage.AntiCheat.Storage.Runtime.dll
CodeStage.AntiCheat.Genuine.dll
ACTk.Examples.Genuine.Runtime.dll
```

### Detectors Present (Demo Status)

| Detector | Purpose | Demo Status |
|----------|---------|-------------|
| SpeedHackDetector | Detect time manipulation | Minimal/Inactive |
| InjectionDetector | Detect DLL injection | Not blocking BepInEx |
| WallHackDetector | Detect rendering exploits | Not implemented |
| ObscuredCheatingDetector | Detect memory editing | Present but weak |

### ObscuredTypes

ACTk provides "obscured" versions of primitive types that encrypt values in memory:

- `ObscuredInt` - Encrypted integer
- `ObscuredFloat` - Encrypted float
- `ObscuredString` - Encrypted string
- `ObscuredBool` - Encrypted boolean

**Demo Implementation**: The `User` class in `De.Base.dll` uses some ObscuredTypes, but not comprehensively. Many values remain as plain types.

### Why Demo Anti-Cheat Is Weak

1. **BepInEx loads before ACTk initializes**
   - Doorstop proxy DLL (winhttp.dll) preloads
   - Mods can patch detector methods before they run

2. **No server-side validation**
   - Single-player demo has no server checks
   - All validation is client-side

3. **Detectors appear to be disabled or minimal**
   - No observed blocking of common mod techniques
   - Harmony patches work without triggering detection

---

## Resource Dumping

### Unity Asset Extraction

Unity assets are stored in:
- `VOID DIVER_Data/resources.assets`
- `VOID DIVER_Data/sharedassets*.assets`
- `VOID DIVER_Data/StreamingAssets/`

**Tools for extraction:**
- [AssetStudio](https://github.com/Perfare/AssetStudio) - GUI asset browser
- [AssetRipper](https://github.com/AssetRipper/AssetRipper) - Full project extraction
- [UABE](https://github.com/SeriousCache/UABE) - Asset Bundle Extractor

### Extractable Assets

| Asset Type | Location | Format |
|------------|----------|--------|
| Lua Scripts | LuaEncrypted/ | XOR-encrypted .bytes |
| Data Tables | TableEncrypted/ | XOR-encrypted .bytes |
| Textures | *.assets | Unity Texture2D |
| Models | *.assets | Unity Mesh |
| Audio | *.assets | Unity AudioClip |
| Prefabs | *.assets | Unity Prefab |

### Assembly Dumping

For analyzing game code:

1. **dnSpy** - Decompile and debug .NET assemblies
2. **ILSpy** - Alternative decompiler
3. **dotPeek** - JetBrains decompiler

Key assemblies to analyze:
- `De.InGame.dll` - Combat, AI, game logic
- `De.Base.dll` - Core types, user data, enums
- `De.Lua.dll` - Lua API implementation

---

## Runtime Injection Points

### BepInEx Entry

BepInEx uses Unity Doorstop to inject before game code runs:

```
Game Launch
    ↓
winhttp.dll (doorstop proxy) intercepts
    ↓
Mono runtime initialized early
    ↓
BepInEx.Preloader runs
    ↓
BepInEx.dll loaded
    ↓
Plugins in BepInEx/plugins/ loaded
    ↓
Game assemblies load (De.*.dll)
    ↓
ACTk initializes (too late to block mods)
    ↓
Game runs with patches applied
```

### Harmony Patching

HarmonyX can intercept any .NET method:

```csharp
// Prefix: Run before original, can skip original
[HarmonyPrefix]
static bool MyPrefix(ref int damage) {
    damage *= 10;  // Modify parameter
    return true;   // false = skip original
}

// Postfix: Run after original, can modify return
[HarmonyPostfix]
static void MyPostfix(ref float __result) {
    __result *= 2f;  // Double the return value
}
```

### Reflection Access

Game types accessible via reflection:

```csharp
var assembly = AppDomain.CurrentDomain.GetAssemblies()
    .First(a => a.GetName().Name == "De.InGame");
var controllerType = assembly.GetTypes()
    .First(t => t.Name == "CharacterController");
```

---

## Lua Runtime Analysis

### MoonSharp Integration

The game uses MoonSharp (Lua 5.2 for .NET):

- Scripts loaded via `De.Lua.dll` → `LuaRunner`
- `LuaApi` object injected as global userdata
- Coroutine-based async via `await()` helper

### LuaApi Surface

The `LuaApi` object exposes these categories:

| Category | Functions |
|----------|-----------|
| Dialog | ShowRadioText, ShowBubbleText, OpenDialogAsync, AppendDialogAsync |
| Quest | GetQuestState, SetQuestState, IsAllTaskAchieved |
| NPC | SetNpcState, GetNpcPosition, AddDialog, RemoveDialog |
| Items | GiveEquipment, AcquireParadox, RemoveParadox |
| UI | ShowSystemToastText, PlayPing |
| Audio | PlaySfx |
| Utility | WaitDelayAsync, LogInfo, LogError |

### Script Injection Possibility

Since Lua scripts are XOR-encrypted with a known key:

1. Decrypt existing script
2. Modify Lua code
3. Re-encrypt with same key
4. Replace original file

**Note**: This works in the demo. Full release may add integrity checks.

---

## Data Table Structure

### Decrypted CSV Format

Tables use pipe-delimited CSV with headers:

```csv
Id|Name|Hp|Attack|Defense|...
200001|Zombie|100|10|5|...
200002|Ghost|80|15|3|...
```

### Key Tables

| Table | Contents |
|-------|----------|
| Monster.csv | Enemy stats, IDs, behavior |
| Equipment.csv | Item stats, grades, effects |
| Skill.csv | Skill definitions, costs, damage |
| Npc.csv | NPC IDs, names, positions |
| Character.csv | Playable character stats |
| Buff.csv | Status effect definitions |
| DropReward.csv | Loot tables |

---

## Expected Full Release Security

Based on industry standards, expect:

### Encryption
- AES-256 or similar for assets
- Per-file or derived keys
- Possible IL2CPP build (no .NET assemblies)

### Anti-Cheat
- Active detectors enabled
- Memory scanning
- Process integrity checks
- Possible kernel-level driver (EasyAntiCheat, etc.)

### Server Validation
- Online requirement for some features
- Server-authoritative game state
- Anti-cheat telemetry

### Code Protection
- IL obfuscation (Dotfuscator, ConfuserEx)
- String encryption
- Control flow obfuscation

---

## Tools Reference

| Tool | Purpose | Link |
|------|---------|------|
| dnSpy | .NET decompiler/debugger | [GitHub](https://github.com/dnSpy/dnSpy) |
| ILSpy | .NET decompiler | [GitHub](https://github.com/icsharpcode/ILSpy) |
| AssetStudio | Unity asset extraction | [GitHub](https://github.com/Perfare/AssetStudio) |
| BepInEx | Unity modding framework | [GitHub](https://github.com/BepInEx/BepInEx) |
| HarmonyX | Runtime patching | [GitHub](https://github.com/BepInEx/HarmonyX) |

---

## Analysis Scripts Documentation

The `tools/` folder contains PowerShell scripts for analyzing and extracting game data.

### Core Decryption Scripts

#### Script_Resource_Loader.ps1
**Purpose**: Decrypt Lua and Table assets

```
Functionality:
- Decrypts LuaEncrypted/*.bytes using XOR key 0xD2
- Decrypts TableEncrypted/*.bytes using XOR key 0xEA
- Outputs plaintext .lua and .csv files to C:\temp\decrypted\
- Displays preview of decrypted content
```

#### Asset_Bundle_Manager.ps1
**Purpose**: Full asset decryption with key derivation

```
Functionality:
- Tests multiple XOR keys to find correct one
- Derives table key from known plaintext ("Id," header)
- Batch decrypts all Lua and Table files
- Displays file listing and content samples
```

### Security Analysis Scripts

#### IL_Instruction_Set.ps1
**Purpose**: Analyze anti-cheat method bytecode

```
Functionality:
- Loads NemoLib.dll via reflection
- Extracts IL bytecode from AntiCheatManager methods
- Searches for detector references in binary:
  - SpeedHackDetector
  - InjectionDetector
  - WallHackDetector
  - TimeCheatingDetector
- Checks Global.dll and De.Scenes.dll for ACTk references
```

#### Environment_Capability_Query.ps1
**Purpose**: Enumerate game configuration and anti-cheat state

```
Functionality:
- Scans De.*.dll for AppManager, GameSetting, Config types
- Enumerates EEnvironment modes (Dev/Release)
- Checks SRDebugger initialization patterns
- Analyzes ACTk.Examples.Genuine.Runtime.dll
- Reads AppSetting JSON configuration
- Checks User class for ObscuredTypes usage
- Reads boot.config for debug flags
```

#### Native_Interop_Layer.ps1
**Purpose**: Analyze game bootstrap and DI framework

```
Functionality:
- Analyzes NemoLib.dll NativeBase/MonoBase classes
- Finds all VContainer LifetimeScope subclasses
- Examines Global.dll and Assembly-CSharp.dll structure
- Binary searches for SROptions/SRDebug strings
- Checks for BepInEx/Doorstop installation presence
```

### Diagnostic Scripts

#### Diagnostics_Binder.ps1
**Purpose**: Runtime debugging setup

#### Diagnostics_Init_Trace.ps1
**Purpose**: Trace game initialization sequence

#### Diagnostics_Overlay_Core.ps1 / Diagnostics_Overlay_Main.ps1
**Purpose**: Debug overlay rendering analysis

#### Input_System_Diagnostics.ps1
**Purpose**: Analyze Unity New Input System integration

### Utility Scripts

#### Lua_Integration_Test.ps1
**Purpose**: Test MoonSharp Lua parsing

```
Functionality:
- Loads MoonSharp.Interpreter.dll
- Creates Script instance and parses Common.lua
- Verifies enum definitions (ESpeaker, ECampaignQuestState)
- Tests Quest and Mission Lua file parsing
- Lists all defined global variables
```

#### Configuration_Setting_Provider.ps1
**Purpose**: Extract game configuration values

#### Localization_Key_Mapper.ps1
**Purpose**: Map localization string keys

#### Core_Context_Initializer.ps1
**Purpose**: Analyze VContainer dependency injection setup

---

## Demo Security System Deep Dive

### Layer 1: Asset Encryption

**Implementation**: Single-byte XOR cipher

```
┌─────────────────────────────────────────────────────┐
│                Asset Loading Flow                    │
├─────────────────────────────────────────────────────┤
│  .bytes file (encrypted)                            │
│       ↓                                             │
│  Read raw bytes                                     │
│       ↓                                             │
│  XOR each byte with static key                      │
│       ↓                                             │
│  Parse as Lua/CSV                                   │
└─────────────────────────────────────────────────────┘

Keys stored in De.Base.dll as constants:
  - LUA_KEY    = 0xD2
  - TABLE_KEY  = 0xEA
  - USER_KEY   = 0xBE (for save data)
```

**Weakness**: No key rotation, no IV, no MAC. Identical plaintexts produce identical ciphertexts.

### Layer 2: Anti-Cheat Toolkit (ACTk)

**Components Present**:

```
CodeStage.AntiCheat.*.dll
├── Detectors.Runtime.dll
│   ├── SpeedHackDetector      [INACTIVE in demo]
│   ├── InjectionDetector      [INACTIVE in demo]
│   ├── WallHackDetector       [NOT IMPLEMENTED]
│   └── ObscuredCheatingDetector [PRESENT but bypassed]
│
├── ObscuredTypes.Runtime.dll
│   ├── ObscuredInt            [PARTIAL USE]
│   ├── ObscuredFloat          [PARTIAL USE]
│   ├── ObscuredString         [MINIMAL USE]
│   └── ObscuredBool           [MINIMAL USE]
│
├── Genuine.dll
│   └── GenuineValidator       [NOT ENFORCING]
│
└── Storage.Runtime.dll
    └── ObscuredPrefs          [FOR SAVE DATA]
```

**Demo Behavior**: Detectors are compiled in but callbacks are not connected or are set to permissive mode.

### Layer 3: Code Distribution

**Intentional Obscurity**:

```
Typical Unity Game:
  Assembly-CSharp.dll  ← All game code here

VOID DIVER Demo:
  Assembly-CSharp.dll  ← Empty stub (7KB)
  De.Base.dll          ← Core types (1.5MB)
  De.InGame.dll        ← Game logic (1.1MB)
  De.Lua.dll           ← Scripting
  De.Scenes.dll        ← Scenes
  NemoLib.dll          ← Framework
```

**Effect**: Casual modders looking at Assembly-CSharp find nothing useful.

### Layer 4: Save Data Protection

**Implementation**: XOR + ObscuredPrefs

```
User save data flow:
  1. Serialize user object to JSON
  2. XOR encrypt with USER_KEY (0xBE)
  3. Store via Unity PlayerPrefs or ObscuredPrefs

Location: %APPDATA%\..\LocalLow\[Company]\[Game]\
```

### Layer 5: Runtime Checks (Disabled)

**Would-be protections** that exist in code but don't trigger:

| Check | Code Location | Demo Status |
|-------|---------------|-------------|
| Speed hack detection | NemoLib.AntiCheatManager | Not calling callback |
| Memory tampering | ACTk.ObscuredCheatingDetector | Not initialized |
| DLL injection | ACTk.InjectionDetector | Not blocking |
| File integrity | ACTk.GenuineValidator | Not enforcing |

### Why BepInEx Works

```
Normal Game Boot:
  1. Unity loads
  2. Assemblies load
  3. ACTk initializes detectors
  4. Game runs (protected)

With BepInEx (Doorstop):
  1. Unity loads
  2. winhttp.dll proxy intercepts ← INJECTION POINT
  3. BepInEx preloader runs
  4. Mods load and patch ACTk methods
  5. Assemblies load (patches already in place)
  6. ACTk initializes (but methods are patched)
  7. Game runs (patches active)
```

**Key insight**: Doorstop loads before any game code, allowing mods to neuter anti-cheat before it activates.

---

## Related Repositories

- [VoidDiverModMenu](https://github.com/msantiagodev/VoidDiverModMenu) - Working mod for the demo

---

## License

MIT License - Documentation only. Game assets belong to their respective owners.
