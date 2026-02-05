$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"
$bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly

# 1. NemoLib NativeBase and related types
Write-Host "=== NemoLib.dll - NativeBase and DI Framework ==="
try {
    $nemoAsm = [System.Reflection.Assembly]::LoadFrom("$managedDir\NemoLib.dll")

    # NativeBase
    $nb = $nemoAsm.GetType("NativeBase")
    if ($nb) {
        Write-Host "`nNativeBase:"
        Write-Host "  Base: $($nb.BaseType)"
        Write-Host "  Interfaces: $(($nb.GetInterfaces() | ForEach-Object { $_.Name }) -join ', ')"
        foreach ($m in $nb.GetMethods($bf)) {
            $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
            Write-Host "  Method: $($m.ReturnType.Name) $($m.Name)($params)"
        }
        foreach ($f in $nb.GetFields($bf)) {
            Write-Host "  Field: [$($f.FieldType.Name)] $($f.Name)"
        }
    }

    # MonoBase
    $mb = $nemoAsm.GetType("MonoBase")
    if ($mb) {
        Write-Host "`nMonoBase:"
        Write-Host "  Base: $($mb.BaseType)"
    }

    # Search for LifetimeScope or DI-related types
    $diTypes = $nemoAsm.GetTypes() | Where-Object { $_.FullName -match "Scope|Inject|Container|Register|Install|Boot|Entry" }
    if ($diTypes) {
        Write-Host "`nDI-related types in NemoLib:"
        foreach ($t in $diTypes) { Write-Host "  $($t.FullName) (Base: $($t.BaseType))" }
    }
} catch { Write-Host "Error: $_" }

# 2. Search ALL DLLs for LifetimeScope subclasses
Write-Host "`n=== All LifetimeScope Subclasses ==="
foreach ($dll in Get-ChildItem "$managedDir\*.dll") {
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dll.FullName)
        foreach ($t in $asm.GetTypes()) {
            $base = $t.BaseType
            $depth = 0
            while ($base -ne $null -and $depth -lt 10) {
                if ($base.FullName -and $base.FullName -match "LifetimeScope") {
                    Write-Host "  $($dll.Name) > $($t.FullName)"
                    foreach ($m in $t.GetMethods($bf)) {
                        if ($m.Name -match "Configure|Install|Register|Build") {
                            $params = ($m.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $($_.Name)" }) -join ", "
                            Write-Host "    Method: $($m.Name)($params)"
                        }
                    }
                    foreach ($f in $t.GetFields($bf)) {
                        Write-Host "    Field: [$($f.FieldType.Name)] $($f.Name)"
                    }
                    break
                }
                $base = $base.BaseType
                $depth++
            }
        }
    } catch {}
}

# 3. Check Global.dll - might contain bootstrap/entry point
Write-Host "`n=== Global.dll ==="
try {
    $globalAsm = [System.Reflection.Assembly]::LoadFrom("$managedDir\Global.dll")
    foreach ($t in $globalAsm.GetTypes()) {
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
            Write-Host "    Field: [$($f.FieldType.Name)] $($f.Name)$val"
        }
    }
} catch { Write-Host "Error: $_" }

# 4. Check Assembly-CSharp for any bootstrap
Write-Host "`n=== Assembly-CSharp.dll ==="
try {
    $asmCSharp = [System.Reflection.Assembly]::LoadFrom("$managedDir\Assembly-CSharp.dll")
    foreach ($t in $asmCSharp.GetTypes()) {
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
            Write-Host "    Field: [$($f.FieldType.Name)] $($f.Name)$val"
        }
    }
} catch { Write-Host "Error: $_" }

# 5. Search for "SROptions" string reference in binary of key DLLs
Write-Host "`n=== Binary Search for 'SROptions' String ==="
foreach ($dllName in @("De.Base.dll", "De.Scenes.dll", "De.InGame.dll", "NemoLib.dll", "Global.dll", "Assembly-CSharp.dll")) {
    $dllPath = "$managedDir\$dllName"
    if (Test-Path $dllPath) {
        $bytes = [System.IO.File]::ReadAllBytes($dllPath)
        $text = [System.Text.Encoding]::UTF8.GetString($bytes)
        if ($text -match "SROption") {
            Write-Host "  $dllName : CONTAINS 'SROption' reference"
        }
        if ($text -match "SRDebug") {
            Write-Host "  $dllName : CONTAINS 'SRDebug' reference"
        }
    }
}

# 6. Check for BepInEx or mod loader presence
Write-Host "`n=== Mod Loaders / BepInEx Check ==="
$gameRoot = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo"
$bepinex = Test-Path "$gameRoot\BepInEx"
$doorstop = Test-Path "$gameRoot\winhttp.dll"
$doorstopCfg = Test-Path "$gameRoot\.doorstop_version"
Write-Host "  BepInEx folder: $bepinex"
Write-Host "  winhttp.dll (doorstop): $doorstop"
Write-Host "  .doorstop_version: $doorstopCfg"
