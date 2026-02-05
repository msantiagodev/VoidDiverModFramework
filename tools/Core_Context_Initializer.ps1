$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"
$bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly

# Find AntiCheatManager
Write-Host "=== AntiCheatManager ==="
foreach ($dll in Get-ChildItem "$managedDir\*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $acm = $asm.GetTypes() | Where-Object { $_.Name -eq "AntiCheatManager" }
        if ($acm) {
            foreach ($t in $acm) {
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
        }
    } catch {}
}

# Also check for types that reference AntiCheatManager
Write-Host "`n=== Types Referencing AntiCheatManager ==="
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll","$managedDir\Global.dll","$managedDir\NemoLib.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            foreach ($f in $t.GetFields($bf)) {
                if ($f.FieldType.Name -eq "AntiCheatManager") {
                    Write-Host "  $($dll.Name) > $($t.FullName).$($f.Name)"
                }
            }
        }
    } catch {}
}

# Check RootLifetimeScope Configure method IL for SROptions registration
Write-Host "`n=== RootLifetimeScope.Configure IL (checking for SROptions registration) ==="
try {
    $globalAsm = [System.Reflection.Assembly]::LoadFrom("$managedDir\Global.dll")
    $rootScope = $globalAsm.GetType("RootLifetimeScope")
    $configMethod = $rootScope.GetMethod("Configure", $bf)
    if ($configMethod) {
        $body = $configMethod.GetMethodBody()
        if ($body) {
            $il = $body.GetILAsByteArray()
            Write-Host "  IL size: $($il.Length) bytes"
            # Check local variables
            foreach ($local in $body.LocalVariables) {
                Write-Host "  Local[$($local.LocalIndex)]: $($local.LocalType.Name)"
            }
        }
    }
} catch { Write-Host "Error: $_" }

# Check what RootLifetimeScope Configure references via metadata tokens
Write-Host "`n=== Binary search in Global.dll for type references ==="
$globalBytes = [System.IO.File]::ReadAllBytes("$managedDir\Global.dll")
$globalText = [System.Text.Encoding]::UTF8.GetString($globalBytes)
foreach ($pattern in @("SROption", "SRDebug", "AntiCheat", "Cheat", "Debug")) {
    if ($globalText -match $pattern) {
        Write-Host "  Global.dll contains '$pattern'"
    }
}

# Check how NativeBase is used - it's the base for SROptions
Write-Host "`n=== NativeBase Subclasses (non-SROptions) ==="
foreach ($dll in Get-ChildItem "$managedDir\*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            if ($t.BaseType -and $t.BaseType.Name -eq "NativeBase" -and $t.Name -ne "SROptions") {
                Write-Host "  $($dll.Name) > $($t.FullName)"
            }
        }
    } catch {}
}
