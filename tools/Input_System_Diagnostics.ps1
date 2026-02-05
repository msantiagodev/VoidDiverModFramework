$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"
$bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly

# 1. Check SplashScene for CodeHash check
Write-Host "=== De.Scenes.dll - SplashScene (Code Hash / ACTk Init) ==="
try {
    $scenesAsm = [System.Reflection.Assembly]::LoadFrom("$managedDir\De.Scenes.dll")
    $splashType = $scenesAsm.GetType("SplashScene")
    if ($splashType) {
        Write-Host "SplashScene found"
        foreach ($m in $splashType.GetMethods($bf)) {
            $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
            Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
        }
        foreach ($f in $splashType.GetFields($bf)) {
            $val = ""
            if ($f.IsStatic -and $f.IsLiteral) {
                try { $val = " = $($f.GetRawConstantValue())" } catch {}
            }
            Write-Host "  Field: [$($f.FieldType.FullName)] $($f.Name)$val"
        }
    }
    # Check all nested types
    foreach ($t in $scenesAsm.GetTypes()) {
        if ($t.FullName -match "SplashScene" -and $t.FullName -ne "SplashScene") {
            Write-Host "`n  Nested: $($t.FullName)"
            foreach ($f in $t.GetFields($bf)) {
                Write-Host "    Field: [$($f.FieldType.Name)] $($f.Name)"
            }
        }
    }
} catch { Write-Host "Error: $_" }

# 2. Find all types that reference ACTk detectors
Write-Host "`n=== Types Referencing ACTk Detectors ==="
$detectorPatterns = "InjectionDetector|SpeedHackDetector|WallHackDetector|TimeCheatingDetector|ObscuredCheatingDetector|CodeHashGenerator|GenuineValidator"
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            # Check fields
            foreach ($f in $t.GetFields($bf)) {
                if ($f.FieldType.FullName -and $f.FieldType.FullName -match $detectorPatterns) {
                    Write-Host "  $($dll.Name) > $($t.FullName).$($f.Name) : $($f.FieldType.Name)"
                }
            }
            # Check method return types and parameters
            foreach ($m in $t.GetMethods($bf)) {
                foreach ($p in $m.GetParameters()) {
                    if ($p.ParameterType.FullName -and $p.ParameterType.FullName -match $detectorPatterns) {
                        Write-Host "  $($dll.Name) > $($t.FullName).$($m.Name) uses $($p.ParameterType.Name)"
                    }
                }
                if ($m.ReturnType.FullName -and $m.ReturnType.FullName -match $detectorPatterns) {
                    Write-Host "  $($dll.Name) > $($t.FullName).$($m.Name) returns $($m.ReturnType.Name)"
                }
            }
        }
    } catch {}
}

# 3. Check for SRDebugger initialization - find StompyRobot types
Write-Host "`n=== SRDebugger / StompyRobot Framework ==="
try {
    $srfAsm = [System.Reflection.Assembly]::LoadFrom("$managedDir\StompyRobot.SRF.dll")
    Write-Host "SRF DLL version: $($srfAsm.GetName().Version)"
    $srfTypes = $srfAsm.GetTypes() | Where-Object { $_.IsPublic }
    foreach ($t in $srfTypes | Select-Object -First 30) {
        Write-Host "  $($t.FullName)"
    }
} catch { Write-Host "Error loading SRF: $_" }

# Check for SRDebugger DLLs
$srDebugDlls = Get-ChildItem "$managedDir\*.dll" | Where-Object { $_.Name -match "SRDebug" }
Write-Host "`nSRDebugger DLLs:"
foreach ($d in $srDebugDlls) { Write-Host "  $($d.Name) ($($d.Length) bytes)" }

# 4. Find how SROptions is instantiated/injected
Write-Host "`n=== SROptions Injection / DI Registration ==="
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            foreach ($f in $t.GetFields($bf)) {
                if ($f.FieldType.Name -eq "SROptions" -or ($f.FieldType.FullName -and $f.FieldType.FullName -match "SROption")) {
                    Write-Host "  $($dll.Name) > $($t.FullName).$($f.Name) : $($f.FieldType.Name)"
                }
            }
            foreach ($m in $t.GetMethods($bf)) {
                $mBody = $null
                try { $mBody = $m.GetMethodBody() } catch {}
                if ($m.Name -match "SROption|SRDebug|Cheat|Debug") {
                    $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
                    Write-Host "  $($dll.Name) > $($t.FullName).$($m.Name)($params)"
                }
            }
        }
    } catch {}
}

# 5. Check for build config / debug flags
Write-Host "`n=== Build Flags / Debug Mode Detection ==="
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            foreach ($f in $t.GetFields($bf)) {
                if ($f.IsStatic -and $f.IsLiteral -and $f.Name -match "DEBUG|CHEAT|RELEASE|BUILD|ENABLE|DISABLE|DEV") {
                    try {
                        $val = $f.GetRawConstantValue()
                        Write-Host "  $($dll.Name) > $($t.FullName).$($f.Name) = $val"
                    } catch {}
                }
            }
        }
    } catch {}
}

# 6. Check for conditional compilation / preprocessor checks
Write-Host "`n=== ECheatType Enum Values ==="
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            if ($t.Name -eq "ECheatType") {
                foreach ($name in [System.Enum]::GetNames($t)) {
                    Write-Host "  $name = $([int][System.Enum]::Parse($t, $name))"
                }
            }
        }
    } catch {}
}
