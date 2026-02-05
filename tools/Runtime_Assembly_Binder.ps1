param([string]$DllPath, [string]$Filter = "")

$asm = [System.Reflection.Assembly]::LoadFrom($DllPath)
$types = $asm.GetTypes()
if ($Filter) {
    $types = $types | Where-Object { $_.FullName -match $Filter }
}

$bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly

foreach ($t in $types) {
    Write-Host "`n=== Type: $($t.FullName) (Base: $($t.BaseType))"

    # Enum values
    if ($t.IsEnum) {
        $names = [System.Enum]::GetNames($t)
        foreach ($n in $names) { Write-Host "  EnumVal: $n = $([int][System.Enum]::Parse($t, $n))" }
        continue
    }

    # Fields
    foreach ($f in $t.GetFields($bf)) {
        $val = ""
        if ($f.IsStatic -and $f.IsLiteral) {
            try { $val = " = $($f.GetRawConstantValue())" } catch {}
        }
        Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name)$val (Static=$($f.IsStatic))"
    }

    # Properties
    foreach ($p in $t.GetProperties()) {
        Write-Host "  Prop: [$($p.PropertyType.Name)] $($p.Name)"
    }

    # Methods
    foreach ($m in $t.GetMethods($bf)) {
        $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
        Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
    }
}
