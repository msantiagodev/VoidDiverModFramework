$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"
$pattern = "Encrypt|Decrypt|Crypto|Cipher|AES|Xor|Security"

foreach ($dll in Get-ChildItem "$managedDir\*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $types = $asm.GetTypes() | Where-Object { $_.FullName -match $pattern -and $_.FullName -notmatch "^System\." }
        if ($types) {
            Write-Host "`n=== DLL: $($dll.Name) ==="
            foreach ($t in $types) {
                Write-Host "  Type: $($t.FullName) (Base: $($t.BaseType))"
                $bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly
                foreach ($m in $t.GetMethods($bf)) {
                    $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
                    Write-Host "    Method: $($m.ReturnType.Name) $($m.Name)($params)"
                }
                foreach ($f in $t.GetFields($bf)) {
                    $val = ""
                    if ($f.IsStatic -and $f.IsLiteral) {
                        try { $val = " = $($f.GetRawConstantValue())" } catch {}
                    }
                    Write-Host "    Field: [$($f.FieldType.Name)] $($f.Name)$val (Static=$($f.IsStatic))"
                }
            }
        }
    } catch {}
}
