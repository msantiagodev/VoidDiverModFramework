$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"
$bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly

# Search ALL DLLs for SRDebugger/SROptions/SRDebug references
Write-Host "=== Search All DLLs for SRDebugger Types ==="
foreach ($dll in Get-ChildItem "$managedDir\*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $types = $asm.GetTypes() | Where-Object { $_.FullName -match "SRDebug|SROption" -and $_.FullName -notmatch "SRDebugUtil" }
        if ($types) {
            Write-Host "`n=== $($dll.Name) ==="
            foreach ($t in $types) {
                Write-Host "  $($t.FullName) (Base: $($t.BaseType))"
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

# Check for VContainer registration (the game uses VContainer DI)
Write-Host "`n=== VContainer DI Registration for SROptions ==="
foreach ($dll in Get-ChildItem "$managedDir\De.*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        $types = $asm.GetTypes() | Where-Object { $_.FullName -match "Installer|Scope|LifetimeScope|Register|Boot" }
        foreach ($t in $types) {
            Write-Host "`n--- $($dll.Name) > $($t.FullName)"
            foreach ($m in $t.GetMethods($bf)) {
                $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
                Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
            }
            foreach ($f in $t.GetFields($bf)) {
                Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name) (Static=$($f.IsStatic))"
            }
        }
    } catch {}
}

# Check for the GenuineValidatorExample's StringKey value
Write-Host "`n=== GenuineValidator StringKey (Code Hash Key) ==="
try {
    $genuineAsm = [System.Reflection.Assembly]::LoadFrom("$managedDir\ACTk.Examples.Genuine.Runtime.dll")
    $validatorType = $genuineAsm.GetType("CodeStage.AntiCheat.Examples.Genuine.GenuineValidatorExample")
    if ($validatorType) {
        $keyField = $validatorType.GetField("StringKey", $bf)
        if ($keyField) {
            try {
                $keyVal = $keyField.GetValue($null)
                if ($keyVal -is [char[]]) {
                    $keyStr = [string]::new($keyVal)
                    Write-Host "StringKey: '$keyStr' (length: $($keyVal.Length))"
                    Write-Host "Hex: $([BitConverter]::ToString([System.Text.Encoding]::UTF8.GetBytes($keyStr)))"
                }
            } catch { Write-Host "Cannot read: $_" }
        }
        $sepField = $validatorType.GetField("Separator", $bf)
        if ($sepField) {
            try {
                $sepVal = $sepField.GetValue($null)
                Write-Host "Separator: '$sepVal'"
            } catch {}
        }
        $fileField = $validatorType.GetField("FileName", $bf)
        if ($fileField) {
            try {
                $fileVal = $fileField.GetValue($null)
                Write-Host "FileName: '$fileVal'"
            } catch {}
        }
    }
} catch { Write-Host "Error: $_" }

# Check for Conditional compilation attributes
Write-Host "`n=== Conditional Attributes on SROptions ==="
try {
    $cheatAsm = [System.Reflection.Assembly]::LoadFrom("$managedDir\De.Cheat.dll")
    $srType = $cheatAsm.GetType("SROptions")
    if ($srType) {
        $attrs = $srType.GetCustomAttributes($true)
        foreach ($a in $attrs) {
            Write-Host "  Attribute: $($a.GetType().FullName)"
            foreach ($p in $a.GetType().GetProperties()) {
                try {
                    $v = $p.GetValue($a)
                    Write-Host "    $($p.Name) = $v"
                } catch {}
            }
        }
        # Check methods for conditional attributes
        foreach ($m in $srType.GetMethods($bf)) {
            $mAttrs = $m.GetCustomAttributes($true)
            $attrNames = ($mAttrs | ForEach-Object { $_.GetType().Name }) -join ", "
            if ($attrNames -and $attrNames -notmatch "CompilerGenerated") {
                Write-Host "  $($m.Name) -> [$attrNames]"
            }
        }
    }
} catch { Write-Host "Error: $_" }
