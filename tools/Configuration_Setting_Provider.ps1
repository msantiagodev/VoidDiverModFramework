$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"

# Load dependencies first
$depOrder = @(
    "UnityEngine.CoreModule.dll",
    "Unity.TextMeshPro.dll",
    "MoonSharp.Interpreter.dll",
    "De.Base.dll",
    "De.Const.dll",
    "De.Lua.dll"
)
foreach ($dep in $depOrder) {
    $path = Join-Path $managedDir $dep
    if (Test-Path $path) {
        try { [System.Reflection.Assembly]::LoadFrom($path) | Out-Null } catch {}
    }
}

# Get the Const+Encrypt type
$constAsm = [System.Reflection.Assembly]::LoadFrom((Join-Path $managedDir "De.Const.dll"))
$encryptType = $constAsm.GetType("Const+Encrypt")

if ($encryptType) {
    Write-Host "Found Const+Encrypt type"
    $bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::DeclaredOnly

    # List all members
    foreach ($m in $encryptType.GetMembers($bf)) {
        Write-Host "  Member: $($m.MemberType) $($m.Name)"
    }

    # Try to get property values (they are static properties returning Byte)
    foreach ($propName in @("LUA_KEY", "TABLE_KEY", "USER_DATA_KEY")) {
        $prop = $encryptType.GetProperty($propName, $bf)
        if ($prop) {
            try {
                $val = $prop.GetValue($null)
                Write-Host "  $propName = $val (0x$($val.ToString('X2')))"
            } catch {
                Write-Host "  $propName - Cannot get value directly: $_"
                # Try reading the getter IL
                $getter = $prop.GetGetMethod($true)
                if ($getter) {
                    $body = $getter.GetMethodBody()
                    if ($body) {
                        $il = $body.GetILAsByteArray()
                        Write-Host "  $propName getter IL bytes: $([BitConverter]::ToString($il))"
                    }
                }
            }
        } else {
            Write-Host "  $propName property not found"
        }
    }

    # Also check fields
    foreach ($f in $encryptType.GetFields($bf)) {
        $val = ""
        if ($f.IsStatic) {
            try {
                $v = $f.GetValue($null)
                if ($v -is [array]) {
                    $val = " = [" + ($v -join ", ") + "]"
                } else {
                    $val = " = $v"
                }
            } catch { $val = " (cannot read)" }
        }
        Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name)$val"
    }
} else {
    Write-Host "Const+Encrypt type not found!"
    # List all types to find it
    foreach ($t in $constAsm.GetTypes()) {
        Write-Host "  Available type: $($t.FullName)"
    }
}
