# Search for encryption-related string constants and byte arrays in key DLLs
$managedDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\Managed"
$targetDlls = @("De.Base.dll", "De.Lua.dll", "De.InGame.dll", "De.Const.dll", "Assembly-CSharp.dll")

$bf = [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::DeclaredOnly

foreach ($dllName in $targetDlls) {
    $dllPath = Join-Path $managedDir $dllName
    if (-not (Test-Path $dllPath)) { continue }
    try {
        $asm = [System.Reflection.Assembly]::LoadFrom($dllPath)
        Write-Host "`n=== Scanning $dllName for string constants ==="
        foreach ($t in $asm.GetTypes()) {
            foreach ($f in $t.GetFields($bf)) {
                if ($f.IsStatic -and $f.IsLiteral -and $f.FieldType.Name -eq "String") {
                    try {
                        $val = $f.GetRawConstantValue()
                        # Look for potential keys, passwords, encryption-related strings
                        if ($val -and ($val.Length -ge 8 -and $val.Length -le 64) -and $val -match "[A-Za-z0-9+/=]{8,}") {
                            Write-Host "  $($t.FullName).$($f.Name) = '$val'"
                        }
                    } catch {}
                }
            }
        }
    } catch {
        Write-Host "  Error loading $dllName : $_"
    }
}
