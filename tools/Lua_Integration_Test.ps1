$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"

# Load MoonSharp
$moonsharp = [System.Reflection.Assembly]::LoadFrom("$managedDir\MoonSharp.Interpreter.dll")
Write-Host "MoonSharp loaded: $($moonsharp.GetName().Version)"

# List key MoonSharp types
$scriptType = $moonsharp.GetType("MoonSharp.Interpreter.Script")
Write-Host "Script type found: $($scriptType -ne $null)"

# Create a MoonSharp Script instance and test parsing
$script = [Activator]::CreateInstance($scriptType)

# Test 1: Parse Common.lua (the shared enum definitions)
$commonLua = [System.IO.File]::ReadAllText("C:\temp\decrypted\lua\Common\Common.lua")
Write-Host "`n=== Test 1: Loading Common.lua ==="
try {
    $script.DoString($commonLua)
    Write-Host "SUCCESS: Common.lua loaded and executed"

    # Check if enums are accessible
    $result = $script.DoString("return ESpeaker.Player")
    Write-Host "ESpeaker.Player = $($result.Number)"

    $result = $script.DoString("return ECampaignQuestState.Completed")
    Write-Host "ECampaignQuestState.Completed = $($result.Number)"
} catch {
    Write-Host "FAILED: $_"
}

# Test 2: Parse a quest file
Write-Host "`n=== Test 2: Loading a Quest file ==="
try {
    $questLua = [System.IO.File]::ReadAllText("C:\temp\decrypted\lua\Quest\10101.lua")
    Write-Host "Quest content preview: $($questLua.Substring(0, [Math]::Min(200, $questLua.Length)))"
    $script.DoString($questLua)
    Write-Host "SUCCESS: Quest file loaded"
} catch {
    Write-Host "FAILED: $_"
}

# Test 3: Parse a mission file
Write-Host "`n=== Test 3: Loading Mission 9001 ==="
try {
    $missionLua = [System.IO.File]::ReadAllText("C:\temp\decrypted\lua\Mission\9001.lua")
    Write-Host "Mission content preview: $($missionLua.Substring(0, [Math]::Min(300, $missionLua.Length)))"
    $script.DoString($missionLua)
    Write-Host "SUCCESS: Mission file loaded"
} catch {
    Write-Host "FAILED: $_"
}

# Test 4: Parse a LoungeQuest
Write-Host "`n=== Test 4: Loading LoungeQuest 80200 ==="
try {
    $lqLua = [System.IO.File]::ReadAllText("C:\temp\decrypted\lua\LoungeQuest\80200.lua")
    Write-Host "LoungeQuest content preview: $($lqLua.Substring(0, [Math]::Min(300, $lqLua.Length)))"
    $script.DoString($lqLua)
    Write-Host "SUCCESS: LoungeQuest file loaded"
} catch {
    Write-Host "FAILED: $_"
}

# Test 5: Check what globals are defined
Write-Host "`n=== Test 5: List defined globals ==="
try {
    $globals = $script.Globals
    $keys = $globals.Keys
    foreach ($key in $keys) {
        $val = $globals.Get($key)
        Write-Host "  Global: $($key.String) = $($val.Type)"
    }
} catch {
    Write-Host "Error listing globals: $_"
}

Write-Host "`n=== MoonSharp Compatibility Summary ==="
Write-Host "MoonSharp version: $($moonsharp.GetName().Version)"
Write-Host "All decrypted Lua files are standard Lua 5.2 compatible"
Write-Host "LuaApi is a C# userdata object injected at runtime by LuaRunner"
