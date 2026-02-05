$luaDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\StreamingAssets\LuaEncrypted"
$tableDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\StreamingAssets\TableEncrypted"
$outDir = "C:\temp\decrypted"

$LUA_KEY = [byte]0xD2
$TABLE_KEY = [byte]0xEA

# Create output dirs
New-Item -ItemType Directory -Force -Path "$outDir\lua" | Out-Null
New-Item -ItemType Directory -Force -Path "$outDir\tables" | Out-Null

# Decrypt a few Lua files
$luaFiles = Get-ChildItem -Path $luaDir -Recurse -Filter "*.bytes" | Select-Object -First 5
foreach ($file in $luaFiles) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $decrypted = New-Object byte[] $bytes.Length
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        $decrypted[$i] = $bytes[$i] -bxor $LUA_KEY
    }
    $relativePath = $file.FullName.Substring($luaDir.Length + 1) -replace '\.bytes$', '.lua'
    $outPath = Join-Path "$outDir\lua" $relativePath
    $outFolder = Split-Path $outPath -Parent
    New-Item -ItemType Directory -Force -Path $outFolder | Out-Null
    [System.IO.File]::WriteAllBytes($outPath, $decrypted)

    # Show first 40 lines of decrypted content
    $text = [System.Text.Encoding]::UTF8.GetString($decrypted)
    Write-Host "`n=== $relativePath ==="
    $lines = $text -split "`n"
    $linesToShow = [Math]::Min(40, $lines.Count)
    for ($j = 0; $j -lt $linesToShow; $j++) {
        Write-Host $lines[$j]
    }
    if ($lines.Count -gt 40) {
        Write-Host "... ($($lines.Count) total lines)"
    }
}

# Decrypt a few table files
$tableFiles = Get-ChildItem -Path $tableDir -Filter "*.bytes" | Select-Object -First 3
foreach ($file in $tableFiles) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $decrypted = New-Object byte[] $bytes.Length
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        $decrypted[$i] = $bytes[$i] -bxor $TABLE_KEY
    }
    $outPath = Join-Path "$outDir\tables" ($file.Name -replace '\.bytes$', '.txt')
    [System.IO.File]::WriteAllBytes($outPath, $decrypted)

    $text = [System.Text.Encoding]::UTF8.GetString($decrypted)
    Write-Host "`n=== TABLE: $($file.Name) ==="
    $lines = $text -split "`n"
    $linesToShow = [Math]::Min(20, $lines.Count)
    for ($j = 0; $j -lt $linesToShow; $j++) {
        Write-Host $lines[$j]
    }
    if ($lines.Count -gt 20) {
        Write-Host "... ($($lines.Count) total lines)"
    }
}
