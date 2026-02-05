$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"
$bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly

# 1. Full dump of StompyRobot.SRF.dll - ALL types
Write-Host "=== StompyRobot.SRF.dll - ALL TYPES ==="
try {
    $srfAsm = [System.Reflection.Assembly]::LoadFrom("$managedDir\StompyRobot.SRF.dll")
    foreach ($t in $srfAsm.GetTypes()) {
        Write-Host "  $($t.FullName) (Base: $($t.BaseType))"
    }
} catch { Write-Host "Error: $_" }

# 2. Find SRDebug namespace types across ALL DLLs
Write-Host "`n=== SRDebug Namespace Types Across All DLLs ==="
foreach ($dll in Get-ChildItem "$managedDir\*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $types = $asm.GetTypes() | Where-Object { $_.Namespace -and ($_.Namespace -match "SRDebug|SRF\.Service|StompyRobot") }
        if ($types) {
            Write-Host "`n--- $($dll.Name) ---"
            foreach ($t in $types) {
                Write-Host "  $($t.FullName)"
            }
        }
    } catch {}
}

# 3. Search for SRDebugger initialization MonoBehaviours
Write-Host "`n=== SRDebugger MonoBehaviours (Init Components) ==="
foreach ($dll in Get-ChildItem "$managedDir\*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            if ($t.BaseType -and $t.BaseType.Name -match "MonoBehaviour" -and $t.FullName -match "SRDebug|SROption|DebugPanel|DebugConsole") {
                Write-Host "`n--- $($dll.Name) > $($t.FullName)"
                foreach ($m in $t.GetMethods($bf)) {
                    $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
                    Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
                }
                foreach ($f in $t.GetFields($bf)) {
                    Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name)"
                }
            }
        }
    } catch {}
}

# 4. Find RuntimeInitializeOnLoad methods (auto-init)
Write-Host "`n=== RuntimeInitializeOnLoad Methods ==="
foreach ($dll in Get-ChildItem "$managedDir\*.dll" | Where-Object { $_.Name -match "SRF|SRDebug|De\." }) {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            foreach ($m in $t.GetMethods($bf)) {
                $attrs = $m.GetCustomAttributes($true)
                foreach ($a in $attrs) {
                    if ($a.GetType().Name -match "RuntimeInitializeOnLoadMethod") {
                        Write-Host "  $($dll.Name) > $($t.FullName).$($m.Name) [RuntimeInitializeOnLoadMethod]"
                    }
                }
            }
            # Also check class-level attributes
            $classAttrs = $t.GetCustomAttributes($true)
            foreach ($a in $classAttrs) {
                if ($a.GetType().Name -match "RuntimeInitializeOnLoad|InitializeOnLoad") {
                    Write-Host "  $($dll.Name) > $($t.FullName) [CLASS: $($a.GetType().Name)]"
                }
            }
        }
    } catch {}
}

# 5. Check ScriptingAssemblies.json for SRDebugger entries
Write-Host "`n=== ScriptingAssemblies.json (SRDebug references) ==="
$scriptAsm = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\ScriptingAssemblies.json"
$content = Get-Content $scriptAsm -Raw
$lines = $content -split "`n"
foreach ($line in $lines) {
    if ($line -match "SRDebug|SRF|StompyRobot|Cheat") {
        Write-Host "  $($line.Trim())"
    }
}

# 6. Check RuntimeInitializeOnLoads.json
Write-Host "`n=== RuntimeInitializeOnLoads.json ==="
$riol = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\RuntimeInitializeOnLoads.json"
if (Test-Path $riol) {
    $riolContent = Get-Content $riol -Raw
    # Search for SRDebug/SRF entries
    $riolLines = $riolContent -split "`n"
    foreach ($line in $riolLines) {
        if ($line -match "SRDebug|SRF|StompyRobot|SROption|Cheat|Debug") {
            Write-Host "  $($line.Trim())"
        }
    }
    if (-not ($riolContent -match "SRDebug|SRF|StompyRobot")) {
        Write-Host "  (No SRDebug/SRF entries found in RuntimeInitializeOnLoads.json)"
        Write-Host "  Full content length: $($riolContent.Length) chars"
    }
}
