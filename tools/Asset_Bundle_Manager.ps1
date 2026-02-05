$luaDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\StreamingAssets\LuaEncrypted"
$tableDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\StreamingAssets\TableEncrypted"
$outDir = "C:\temp\decrypted"

# The raw key from Const is XOR'd with 0x26 to get the real key
# LUA_KEY: 0xD2 XOR 0x26 = 0xF4
# TABLE_KEY: 0xEA XOR 0x26 = 0xCC
# USER_DATA_KEY: 0xBE XOR 0x26 = 0x98
$LUA_KEY = [byte]0xF4
$TABLE_KEY_CANDIDATE1 = [byte]0xCC  # 0xEA XOR 0x26
$TABLE_KEY_CANDIDATE2 = [byte]0xEA

# Test table key first
$testTable = Get-ChildItem -Path $tableDir -Filter "*.bytes" | Select-Object -First 1
$tableBytes = [System.IO.File]::ReadAllBytes($testTable.FullName)
Write-Host "Testing table file: $($testTable.Name)"

foreach ($key in @(0xCC, 0xEA, 0xF4)) {
    $decrypted = New-Object byte[] ([Math]::Min(200, $tableBytes.Length))
    for ($i = 0; $i -lt $decrypted.Length; $i++) {
        $decrypted[$i] = $tableBytes[$i] -bxor $key
    }
    $text = [System.Text.Encoding]::UTF8.GetString($decrypted)
    $preview = $text.Substring(0, [Math]::Min(100, $text.Length))
    Write-Host "Table key 0x$($key.ToString('X2')): $preview"
}

# Determine correct table key - if first column is "Id", 'I'=0x49
$realTableKey = $tableBytes[0] -bxor [byte][char]'I'
Write-Host "`nDerived table key: 0x$($realTableKey.ToString('X2'))"

# Full decryption
Write-Host "`n=== Decrypting all Lua files ==="
New-Item -ItemType Directory -Force -Path "$outDir\lua" | Out-Null

$luaCount = 0
foreach ($file in (Get-ChildItem -Path $luaDir -Recurse -Filter "*.bytes")) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $decrypted = New-Object byte[] $bytes.Length
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        $decrypted[$i] = $bytes[$i] -bxor $LUA_KEY
    }
    $relativePath = $file.FullName.Substring($luaDir.Length + 1) -replace '\.bytes$', '.lua'
    $outPath = Join-Path "$outDir\lua" $relativePath
    New-Item -ItemType Directory -Force -Path (Split-Path $outPath -Parent) | Out-Null
    [System.IO.File]::WriteAllBytes($outPath, $decrypted)
    $luaCount++
}
Write-Host "Decrypted $luaCount Lua files"

Write-Host "`n=== Decrypting all Table files ==="
New-Item -ItemType Directory -Force -Path "$outDir\tables" | Out-Null

$tableCount = 0
foreach ($file in (Get-ChildItem -Path $tableDir -Filter "*.bytes")) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $decrypted = New-Object byte[] $bytes.Length
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        $decrypted[$i] = $bytes[$i] -bxor $realTableKey
    }
    $outName = $file.Name -replace '\.bytes$', '.csv'
    $outPath = Join-Path "$outDir\tables" $outName
    [System.IO.File]::WriteAllBytes($outPath, $decrypted)
    $tableCount++
}
Write-Host "Decrypted $tableCount table files"

# Show sample outputs
Write-Host "`n=== Sample Lua: Common.lua (first 50 lines) ==="
$commonContent = Get-Content "$outDir\lua\Common\Common.lua" -TotalCount 50
$commonContent | ForEach-Object { Write-Host $_ }

Write-Host "`n=== Sample Lua: Quest file ==="
$questFile = Get-ChildItem -Path "$outDir\lua\Quest" -Filter "*.lua" | Select-Object -First 1
if ($questFile) {
    $questContent = Get-Content $questFile.FullName -TotalCount 30
    $questContent | ForEach-Object { Write-Host $_ }
}

Write-Host "`n=== Sample Table: first table file ==="
$firstTable = Get-ChildItem -Path "$outDir\tables" -Filter "*.csv" | Select-Object -First 1
if ($firstTable) {
    Write-Host "File: $($firstTable.Name)"
    $tableContent = Get-Content $firstTable.FullName -TotalCount 10
    $tableContent | ForEach-Object { Write-Host $_ }
}

Write-Host "`n=== Decrypted file listing ==="
Write-Host "Lua files:"
Get-ChildItem -Path "$outDir\lua" -Recurse -Filter "*.lua" | ForEach-Object { Write-Host "  $($_.FullName.Substring("$outDir\lua\".Length)) ($($_.Length) bytes)" }
Write-Host "`nTable files:"
Get-ChildItem -Path "$outDir\tables" -Filter "*.csv" | ForEach-Object { Write-Host "  $($_.Name) ($($_.Length) bytes)" }
