$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"
$gameRoot = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo"
$bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly

# 1. Confirm: Is there a full SRDebugger DLL?
Write-Host "=== Searching for SRDebugger DLLs ==="
$found = Get-ChildItem "$managedDir\*.dll" | Where-Object { $_.Name -match "SRDebug" }
if ($found) { $found | ForEach-Object { Write-Host "  FOUND: $($_.Name)" } }
else { Write-Host "  NO SRDebugger DLL found. Only StompyRobot.SRF.dll (framework)" }

# Check if SRDebugger types exist in ANY DLL
Write-Host "`n=== Searching for SRDebugger Core Types ==="
$targetTypes = "SRDebugger|DebugPanelRoot|DebugTab|OptionsTab|ProfilerTab|ConsoleTab|BugReportTab|InfoTab|DebugSheet"
foreach ($dll in Get-ChildItem "$managedDir\*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $types = $asm.GetTypes() | Where-Object { $_.FullName -match $targetTypes }
        if ($types) {
            Write-Host "  $($dll.Name):"
            foreach ($t in $types) { Write-Host "    $($t.FullName)" }
        }
    } catch {}
}

# 2. Check asset bundles for SRDebugger prefabs
Write-Host "`n=== Checking Asset Bundle Names for SRDebugger ==="
$aaDir = "$gameRoot\VOID DIVER_Data\StreamingAssets\aa\StandaloneWindows64"
if (Test-Path $aaDir) {
    Get-ChildItem "$aaDir\*" | Where-Object { $_.Name -match "srdebug|debug_panel|cheat" -or $_.Name -match "debug" } | ForEach-Object {
        Write-Host "  $($_.Name) ($($_.Length) bytes)"
    }
}

# 3. Check Resources folder for SRDebugger
Write-Host "`n=== Resources Folder ==="
$resDir = "$gameRoot\VOID DIVER_Data\Resources"
if (Test-Path $resDir) {
    Get-ChildItem "$resDir\*" -Recurse | ForEach-Object {
        Write-Host "  $($_.Name) ($($_.Length) bytes)"
    }
}

# 4. VContainer LifetimeScope - how SROptions gets registered
Write-Host "`n=== VContainer LifetimeScopes ==="
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            $base = $t.BaseType
            while ($base -ne $null) {
                if ($base.Name -eq "LifetimeScope") {
                    Write-Host "`n--- $($dll.Name) > $($t.FullName) (LifetimeScope)"
                    foreach ($m in $t.GetMethods($bf)) {
                        $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
                        Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
                    }
                    foreach ($f in $t.GetFields($bf)) {
                        Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name)"
                    }
                    break
                }
                $base = $base.BaseType
            }
        }
    } catch {}
}

# 5. ACTk ContainerHolder - initialization path
Write-Host "`n=== ACTk ContainerHolder (Runtime Init) ==="
try {
    $actkAsm = [System.Reflection.Assembly]::LoadFrom("$managedDir\ACTk.Runtime.dll")
    $containerType = $actkAsm.GetType("CodeStage.AntiCheat.Common.ContainerHolder")
    if ($containerType) {
        Write-Host "ContainerHolder found"
        foreach ($m in $containerType.GetMethods($bf)) {
            $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
            Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
        }
        foreach ($f in $containerType.GetFields($bf)) {
            Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name)"
        }
    }
    # ACTk class
    $actkClass = $actkAsm.GetType("CodeStage.AntiCheat.Common.ACTk")
    if ($actkClass) {
        Write-Host "`nACTk class:"
        foreach ($m in $actkClass.GetMethods($bf)) {
            $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
            Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
        }
        foreach ($f in $actkClass.GetFields($bf)) {
            $val = ""
            if ($f.IsStatic) {
                try { $val = " = $($f.GetValue($null))" } catch { $val = " (unreadable)" }
            }
            Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name)$val"
        }
    }
} catch { Write-Host "Error: $_" }

# 6. Check if there's a way to invoke SROptions without SRDebugger UI
Write-Host "`n=== NativeBase (SROptions Base Class) ==="
foreach ($dll in Get-ChildItem "$managedDir\*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $nativeBase = $asm.GetType("NativeBase")
        if ($nativeBase) {
            Write-Host "  Found in $($dll.Name)"
            Write-Host "  Base: $($nativeBase.BaseType)"
            foreach ($m in $nativeBase.GetMethods($bf)) {
                $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
                Write-Host "    Method: $($m.ReturnType.Name) $($m.Name)($params)"
            }
            foreach ($f in $nativeBase.GetFields($bf)) {
                Write-Host "    Field: [$($f.FieldType.Name)] $($f.Name)"
            }
            break
        }
    } catch {}
}

# 7. Check for InputManager or KeyBinding that might trigger debug
Write-Host "`n=== InputManager Debug Bindings ==="
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            if ($t.Name -match "InputManager|InputAction|KeyBind") {
                Write-Host "`n--- $($dll.Name) > $($t.FullName)"
                foreach ($f in $t.GetFields($bf)) {
                    if ($f.Name -match "debug|cheat|console|dev|sr") {
                        Write-Host "  Field: $($f.Name) : $($f.FieldType.Name)"
                    }
                }
                foreach ($m in $t.GetMethods($bf)) {
                    if ($m.Name -match "Debug|Cheat|Console|Dev") {
                        Write-Host "  Method: $($m.Name)()"
                    }
                }
            }
        }
    } catch {}
}

# 8. Check ECheatType usage - which types reference it
Write-Host "`n=== ECheatType Usage ==="
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            foreach ($f in $t.GetFields($bf)) {
                if ($f.FieldType.Name -eq "ECheatType") {
                    Write-Host "  $($dll.Name) > $($t.FullName).$($f.Name)"
                }
            }
            foreach ($m in $t.GetMethods($bf)) {
                foreach ($p in $m.GetParameters()) {
                    if ($p.ParameterType.Name -eq "ECheatType") {
                        $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
                        Write-Host "  $($dll.Name) > $($t.FullName).$($m.Name)($params)"
                    }
                }
            }
        }
    } catch {}
}
