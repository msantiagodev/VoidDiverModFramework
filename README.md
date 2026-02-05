# VOID DIVER Modding Framework Documentation

Unofficial documentation and tools for modding **VOID DIVER: Escape from the Abyss** using the game's built-in Lua scripting system.

---

## IMPORTANT DISCLAIMERS

### Demo Version Only

This documentation is based on **VOID DIVER: Escape from the Abyss Demo**.

- The full release may have different APIs, security measures, or file structures
- Scripts and tools that work in the demo may not work in the full game
- The developers may change or remove modding capabilities at any time
- **Always backup your save files before modding**

### Security Notice

The demo version has minimal anti-cheat/anti-tamper protection. The full release will likely include:

- Enhanced file integrity checks
- Runtime memory protection
- Different encryption for game assets
- Server-side validation for multiplayer features

**Do not expect these tools or documentation to work on the full game release without significant updates.**

### Not Affiliated

This project is **not affiliated with, endorsed by, or sponsored by** the VOID DIVER developers. Use at your own risk.

---

## Overview

VOID DIVER uses **MoonSharp** (Lua 5.2 interpreter for .NET) for its scripting system. The game exposes a `LuaApi` object that provides functions for:

- NPC dialogs and interactions
- Quest state management
- UI elements (toasts, bubbles, radio messages)
- Sound effects
- Item rewards
- Minimap markers/pings
- And more

---

## Lua API Reference

### Core Object: `LuaApi`

All game interactions go through the `LuaApi` userdata object injected by the game's `LuaRunner`.

### Dialog Functions

```lua
-- Show radio message (top-left popup)
LuaApi:ShowRadioText(speakerType, speakerId, emotion, text)

-- Show speech bubble above character
LuaApi:ShowBubbleText(speakerType, speakerId, text)

-- Show monologue (player inner thoughts)
LuaApi:ShowMonologueText(speakerType, speakerId, text)

-- Show system toast notification
LuaApi:ShowSystemToastText(text)

-- Open/close dialog window
await(LuaApi:OpenDialogAsync(mode))
await(LuaApi:CloseDialogAsync())

-- Multi-character dialog with portraits
await(LuaApi:AppendDialogAsync(speakers, speakerIndex, message, choices))
```

### Quest Functions

```lua
-- Get/set campaign quest state
LuaApi:GetQuestState()
LuaApi:SetQuestState(stateValue)

-- Get/set lounge quest state
LuaApi:GetLoungeQuestState(questId)
LuaApi:SetLoungeQuestState(questId, stateValue)
LuaApi:GetLoungeQuestProgress(questId)
LuaApi:GetLoungeQuestGoal(questId)

-- Check task completion
LuaApi:IsAllTaskAchieved()
LuaApi:GetActionPoint()

-- Step management
LuaApi:GetStep()
LuaApi:SetStep(stepNumber)
```

### NPC Functions

```lua
-- Set NPC interaction state (quest marker)
LuaApi:SetNpcState(npcId, stateValue)

-- Get NPC position in world
LuaApi:GetNpcPosition(npcId)

-- Add/remove dialog options
LuaApi:AddDialog(npcId, dialogOptions)
LuaApi:RemoveDialog(npcId, luaKey, functionName)
```

### Item/Reward Functions

```lua
-- Give equipment item
LuaApi:GiveEquipment(itemId, count)

-- Paradox system (buffs/debuffs)
LuaApi:AcquireParadox(id, allowPositive, allowNegative)
LuaApi:RemoveParadox(id, removePositive, removeNegative)
```

### Utility Functions

```lua
-- Delay execution
await(LuaApi:WaitDelayAsync(milliseconds))
await(LuaApi:DelayDialogAsync(milliseconds))

-- Sound effects
LuaApi:PlaySfx(sfxName)

-- Minimap ping
LuaApi:PlayPing(label, pingType, position)

-- Logging
LuaApi:LogInfo(message)
LuaApi:LogError(message)

-- Dialog fade effects
LuaApi.FadeOutDialog()
LuaApi.FadeInDialog()
```

---

## Enumerations

### ESpeaker
```lua
ESpeaker = {
    None = 0,
    Player = 1,
    Character = 2,
    Npc = 3,
    Monster = 4
}
```

### ENpcState
```lua
ENpcState = {
    None = 0,
    QuestTalkable = 1,    -- Yellow quest marker
    QuestCompletable = 2  -- Yellow check marker
}
```

### ECampaignQuestState
```lua
ECampaignQuestState = {
    None = 0,
    NotStarted = 1,
    InProgress = 2,
    NotCompleted = 3,
    Completed = 4,
    Failed = 5
}
```

### ELuaEvent
```lua
ELuaEvent = {
    None = 0,
    NpcInteraction = 1,       -- Value: NpcId
    TriggerInteraction = 2,   -- Value: TriggerId
    CollisionTriggerEnter = 101,
    MonsterKill = 201,        -- Value: MonsterId
    WaveStarted = 202,
    WaveFailed = 203,
    WaveCleared = 204,
    ArtifactDeal = 205,
    QuestStateChanged = 221,
    QuestTaskAchieved = 222,
    MissionStateChanged = 231,
    MissionTaskAchieved = 232,
    LoungeQuestStateChanged = 241,
    Custom = 999
}
```

### EPingType
```lua
EPingType = {
    Notice = 21,
    Alert = 31
}
```

---

## NPC IDs

### Playable Characters (100000-699999)
| Name | Korean | ID |
|------|--------|-----|
| Gayeong | 가영 | 100001 |
| Leon | 레온 | 100002 |
| Head | 헤드 | 100003 |
| Mio | 미오 | 100004 |

### NPCs (700000-799999)
| Name | Korean | ID |
|------|--------|-----|
| Elara | 엘라 | 700000 |
| Lucas | 루카 | 700001 |
| Anti | 안티 | 700002 |
| Evil | 에블 | 700003 |
| Sofa | 쇼파 | 700004 |
| Owner | 오너 | 700005 |
| Ed | 에드 | 700006 |
| Felix | 펠릭 | 700008 |
| X | 엑스 | 700010 |
| Owl | 부엉 | 700011 |
| Gay | 게이 | 700012 |
| Mirror | 거울 | 700013 |
| Duster | 더스 | 700014 |
| PimPim | 핌핌 | 700015 |
| Shay | 셰이 | 700101 |
| Door | 도어 | 700102 |
| Ghost | 혼령 | 700105 |

---

## Script Structure

### Quest Scripts

Quest scripts are located in `lua/Quest/` and follow this structure:

```lua
-- Called when entering the lounge
function OnLounge()
    OnLoungeCommonSub()
end

-- Called when entering a stage
function OnStage()
    OnStageCommon()
end

-- Called when game events occur
function OnEvent(eventType, value)
    -- Handle events like monster kills, triggers, etc.
end

-- Step functions for quest progression
function Step_00001()
    -- Quest step 1 logic
end

function Step_00010()
    -- Quest completion step
    OnStep10CommonSub()
end
```

### Lounge Quest Scripts

Located in `lua/LoungeQuest/`, these handle NPC side quests:

```lua
function OnLoungeQuest()
    -- Initialize quest state
end

function OnEvent(eventType, value)
    -- Handle quest-related events
end

function StartDialog()
    await(LuaApi:OpenDialogAsync(0))
    -- Dialog content using MDSay or CenterDialogSay
    await(LuaApi:CloseDialogAsync())
end
```

---

## Helper Functions

The game provides several helper functions in `Common.lua`:

### Dialog Helpers

```lua
-- Single-speaker centered dialog
CenterDialogSay(speakerName, emotion, message, choices)

-- Multi-speaker dialog (short form)
MDSay(leftName, leftEmo, centerName, centerEmo, rightName, rightEmo, speakerName, message, choices)

-- Emotion shortcuts:
-- "De" = Default, "An" = Angry, "Sm" = Smile, "Sa" = Sad
-- "Af" = Afraid, "Ha" = Happy, "Su" = Surprised, "Pa" = Pain
-- "Cu" = Curious, "Co" = Comic

-- Radio message with speaker lookup
RadioSay(speakerName, emotion, text)

-- Bubble text
BubbleSay(speakerName, text)

-- Monologue
MonologueSay(speakerName, text)
```

### Quest Helpers

```lua
-- Set quest state by name instead of number
SetQuestState("InProgress")  -- Instead of LuaApi:SetQuestState(2)
GetQuestState()  -- Returns "InProgress" instead of 2

-- NPC state by name
SetNpcStateByName("엘라", ENpcState.QuestTalkable)
```

### Ping/Marker Helpers

```lua
PingToElara()
PingToPhoneBooth()
PingToLucas()
PingToPelix()
PingToMirror()
PingToDuster()
PingToOnwer()
```

### Paradox Helpers

```lua
AcquirePositiveParadox()  -- Random positive buff
AcquireNegativeParadox()  -- Random negative debuff
AcquireRandomParadox()    -- Random either
RemovePositiveParadox()
RemoveNegativeParadox()
RemoveRandomParadox()
```

### Reward Helpers

```lua
GrantRandomItemReward()  -- Weighted random artifact by grade
```

---

## File Locations

```
VOID DIVER Escape from the Abyss Demo/
  VOID DIVER_Data/
    Managed/
      De.Lua.dll           -- Lua runner and API
      De.InGame.dll        -- Game logic
      De.Base.dll          -- Base types
      MoonSharp.Interpreter.dll  -- Lua interpreter
    StreamingAssets/
      lua/                 -- Encrypted Lua scripts (in demo)
```

---

## Technical Details

### MoonSharp Integration

- The game uses MoonSharp, a Lua 5.2 interpreter for .NET/Mono
- Scripts are executed via `LuaRunner` which injects the `LuaApi` userdata
- The `await()` function enables coroutine-based async operations
- Scripts can access C# types via MoonSharp's interop layer

### Async Pattern

```lua
-- The await() function handles C# Tasks
function await(task)
    while not task.IsCompleted do
        coroutine.yield()
    end
    return task.Result
end

-- Usage:
await(LuaApi:WaitDelayAsync(1000))  -- Wait 1 second
local result = await(LuaApi:OpenDialogAsync(0))
```

---

## Creating Custom Content

### Adding a New NPC Dialog

1. Create a new Lua file in the appropriate folder
2. Register the dialog with `LuaApi:AddDialog()`
3. Implement the dialog function

```lua
function MyCustomDialog()
    await(LuaApi:OpenDialogAsync(0))

    CenterDialogSay("엘라", "Default", "Hello, Diver!")
    CenterDialogSay("엘라", "Smile", "How can I help you today?")

    local choice = CenterDialogSay("엘라", "Default", "What do you need?", {
        "I need items",
        "Just chatting",
        "Goodbye"
    })

    if choice == 0 then
        LuaApi:GiveEquipment(100001, 1)
        CenterDialogSay("엘라", "Happy", "Here you go!")
    elseif choice == 1 then
        CenterDialogSay("엘라", "Smile", "That's nice!")
    end

    await(LuaApi:CloseDialogAsync())
end
```

---

## Related Repositories

- [VoidDiverModMenu](https://github.com/msantiagodev/VoidDiverModMenu) - BepInEx mod with radar, gameplay mods, and QoL features
- [BepInEx](https://github.com/BepInEx/BepInEx) - Unity modding framework
- [MoonSharp](https://github.com/moonsharp-devs/moonsharp) - Lua interpreter for .NET

---

## Contributing

This is an unofficial community project. Contributions welcome:

- API documentation improvements
- New helper functions
- Example scripts
- Bug reports

---

## License

MIT License - Documentation and tools only. Game assets belong to their respective owners.
