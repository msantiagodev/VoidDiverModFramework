$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"
$bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly

# Get AntiCheatManager methods IL
try {
    $nemoAsm = [System.Reflection.Assembly]::LoadFrom("$managedDir\NemoLib.dll")
    $acm = $nemoAsm.GetType("AntiCheatManager")

    foreach ($methodName in @("Awake", "Start", "OnSpeedHackDetected")) {
        $m = $acm.GetMethod($methodName, $bf)
        if ($m) {
            Write-Host "=== $methodName ==="
            $body = $m.GetMethodBody()
            if ($body) {
                $il = $body.GetILAsByteArray()
                Write-Host "  IL size: $($il.Length) bytes"
                Write-Host "  IL hex: $([BitConverter]::ToString($il))"
                foreach ($local in $body.LocalVariables) {
                    Write-Host "  Local[$($local.LocalIndex)]: $($local.LocalType.FullName)"
                }
            }
        }
    }

    # Check binary content for method references
    Write-Host "`n=== NemoLib.dll Binary Search for Detector References ==="
    $nemoBytes = [System.IO.File]::ReadAllBytes("$managedDir\NemoLib.dll")
    $nemoText = [System.Text.Encoding]::UTF8.GetString($nemoBytes)
    foreach ($pat in @("SpeedHackDetector", "InjectionDetector", "WallHackDetector", "TimeCheatingDetector", "ObscuredCheatingDetector", "StartDetection", "OnSpeedHack", "OnCheatDetected")) {
        if ($nemoText -match $pat) {
            Write-Host "  Contains: '$pat'"
        } else {
            Write-Host "  Missing: '$pat'"
        }
    }
} catch { Write-Host "Error: $_" }

# Also check Global.dll for detector references
Write-Host "`n=== Global.dll Binary Search for Detector References ==="
$globalBytes = [System.IO.File]::ReadAllBytes("$managedDir\Global.dll")
$globalText = [System.Text.Encoding]::UTF8.GetString($globalBytes)
foreach ($pat in @("SpeedHackDetector", "InjectionDetector", "WallHackDetector", "AntiCheatManager", "SROptions", "SRDebug", "CheckCodeHash")) {
    if ($globalText -match $pat) {
        Write-Host "  Contains: '$pat'"
    } else {
        Write-Host "  Missing: '$pat'"
    }
}

# Check De.Scenes.dll for full SplashScene reference set
Write-Host "`n=== De.Scenes.dll Binary Strings ==="
$scenesBytes = [System.IO.File]::ReadAllBytes("$managedDir\De.Scenes.dll")
$scenesText = [System.Text.Encoding]::UTF8.GetString($scenesBytes)
foreach ($pat in @("CheckCodeHash", "HashGenerator", "GenuineValidator", "Textures.asset", "SRDebug", "SROption", "AntiCheat")) {
    if ($scenesText -match $pat) {
        Write-Host "  Contains: '$pat'"
    } else {
        Write-Host "  Missing: '$pat'"
    }
}
