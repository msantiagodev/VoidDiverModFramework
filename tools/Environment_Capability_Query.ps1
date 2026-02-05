$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"
$bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly

# 1. Check AppManager - likely controls dev/release mode
Write-Host "=== AppManager (Dev Mode Controller) ==="
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $types = $asm.GetTypes() | Where-Object { $_.Name -match "AppManager|AppSetting|GameSetting|Environment|Config" -and $_.Name -notmatch "Display|Enum" }
        foreach ($t in $types) {
            Write-Host "`n--- $($dll.Name) > $($t.FullName) (Base: $($t.BaseType))"
            foreach ($f in $t.GetFields($bf)) {
                $val = ""
                if ($f.IsStatic -and $f.IsLiteral) {
                    try { $val = " = $($f.GetRawConstantValue())" } catch {}
                }
                Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name)$val (Static=$($f.IsStatic))"
            }
            foreach ($p in $t.GetProperties()) {
                Write-Host "  Prop: [$($p.PropertyType.Name)] $($p.Name)"
            }
            foreach ($m in $t.GetMethods($bf)) {
                $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
                Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
            }
        }
    } catch {}
}

# 2. Check EEnvironment enum and its usage
Write-Host "`n=== EEnvironment Enum ==="
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $envType = $asm.GetTypes() | Where-Object { $_.Name -eq "EEnvironment" }
        if ($envType) {
            foreach ($name in [System.Enum]::GetNames($envType)) {
                Write-Host "  $name = $([int][System.Enum]::Parse($envType, $name))"
            }
        }
    } catch {}
}

# 3. Check for SRDebugger initialization code patterns
Write-Host "`n=== SRDebugger Init Patterns ==="
foreach ($dll in Get-ChildItem "$managedDir\*.dll" | Where-Object { $_.Name -match "SRDebug|StompyRobot" }) {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            if ($t.FullName -match "Init|Setup|Boot|Entry|Settings|Debug|Options") {
                Write-Host "`n--- $($t.FullName)"
                foreach ($m in $t.GetMethods($bf)) {
                    $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
                    Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
                }
                foreach ($f in $t.GetFields($bf)) {
                    $val = ""
                    if ($f.IsStatic -and $f.IsLiteral) {
                        try { $val = " = $($f.GetRawConstantValue())" } catch {}
                    }
                    Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name)$val (Static=$($f.IsStatic))"
                }
            }
        }
    } catch {}
}

# 4. Check for ACTk.Examples.Genuine
Write-Host "`n=== ACTk Genuine Check DLL ==="
try {
    $genuineAsm = [System.Reflection.Assembly]::LoadFrom("$managedDir\ACTk.Examples.Genuine.Runtime.dll")
    foreach ($t in $genuineAsm.GetTypes()) {
        Write-Host "`n--- $($t.FullName) (Base: $($t.BaseType))"
        foreach ($m in $t.GetMethods($bf)) {
            $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
            Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
        }
        foreach ($f in $t.GetFields($bf)) {
            $val = ""
            if ($f.IsStatic -and $f.IsLiteral) {
                try { $val = " = $($f.GetRawConstantValue())" } catch {}
            }
            Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name)$val (Static=$($f.IsStatic))"
        }
    }
} catch { Write-Host "Error: $_" }

# 5. Check AppSetting JSON
Write-Host "`n=== AppSetting JSON Files ==="
$appSettingDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\StreamingAssets\AppSetting"
Get-ChildItem "$appSettingDir\*" -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "`n--- $($_.Name):"
    Get-Content $_.FullName | ForEach-Object { Write-Host "  $_" }
}

# 6. Check User class for ObscuredTypes usage
Write-Host "`n=== User Class (ACTk ObscuredTypes) ==="
foreach ($dll in Get-ChildItem "$managedDir\De.Base.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $userType = $asm.GetType("User")
        if ($userType) {
            Write-Host "User class found"
            foreach ($f in $userType.GetFields($bf)) {
                $val = ""
                if ($f.IsStatic -and $f.IsLiteral) {
                    try { $val = " = $($f.GetRawConstantValue())" } catch {}
                }
                Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name)$val (Static=$($f.IsStatic))"
            }
            foreach ($p in $userType.GetProperties()) {
                Write-Host "  Prop: [$($p.PropertyType.Name)] $($p.Name)"
            }
            foreach ($m in $userType.GetMethods($bf)) {
                $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
                Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
            }
        }
    } catch {}
}

# 7. Check boot.config for debug flags
Write-Host "`n=== boot.config ==="
$bootConfig = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\boot.config"
if (Test-Path $bootConfig) {
    Get-Content $bootConfig | ForEach-Object { Write-Host "  $_" }
}
