$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"

# Find SRDebugger DLLs
$srDlls = Get-ChildItem "$managedDir\*" -Filter "*.dll" | Where-Object { $_.Name -match "SRDebug|StompyRobot" }
Write-Host "SRDebugger DLLs found:"
foreach ($d in $srDlls) { Write-Host "  $($d.Name) ($($d.Length) bytes)" }

# Also check Assembly-CSharp for SRDebugger references
$bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly

# Check for SRDebugger in all De.* DLLs
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $types = $asm.GetTypes() | Where-Object { $_.FullName -match "SROption|SRDebug|Debug|Cheat|Console" }
        if ($types) {
            Write-Host "`n=== $($dll.Name) ==="
            foreach ($t in $types) {
                Write-Host "  Type: $($t.FullName) (Base: $($t.BaseType))"
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

# Check for ACTk usage in De.* DLLs
Write-Host "`n=== ACTk Usage in Game Code ==="
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $refs = $asm.GetReferencedAssemblies() | Where-Object { $_.Name -match "ACTk" }
        if ($refs) {
            Write-Host "$($dll.Name) references ACTk"
            # Find types that use ACTk
            $types = $asm.GetTypes()
            foreach ($t in $types) {
                foreach ($f in $t.GetFields($bf)) {
                    if ($f.FieldType.FullName -and $f.FieldType.FullName -match "CodeStage|Obscured") {
                        Write-Host "  $($t.FullName).$($f.Name) : $($f.FieldType.FullName)"
                    }
                }
                foreach ($m in $t.GetMethods($bf)) {
                    $retType = $m.ReturnType
                    if ($retType.FullName -and $retType.FullName -match "CodeStage|Obscured") {
                        Write-Host "  $($t.FullName).$($m.Name)() returns $($retType.FullName)"
                    }
                }
            }
        }
    } catch {}
}
