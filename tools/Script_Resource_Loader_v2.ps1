$luaDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\StreamingAssets\LuaEncrypted"
$tableDir = "C:\Program Files (x86)\Steam\steamapps\common\VOID DIVER Escape from the Abyss Demo\VOID DIVER_Data\StreamingAssets\TableEncrypted"
$outDir = "C:\temp\decrypted"

# Try different key values
# Original key from Const.Encrypt.LUA_KEY was 0xD2, but output was shifted by 0x26
# So try 0xD2 XOR 0x26 = 0xF4
$keyCandidates = @(0xF4, 0xD2, 0x26)

$testFile = Get-ChildItem -Path $luaDir -Recurse -Filter "*.bytes" | Select-Object -First 1
$bytes = [System.IO.File]::ReadAllBytes($testFile.FullName)

Write-Host "Testing file: $($testFile.Name) ($($bytes.Length) bytes)"
Write-Host "First 16 encrypted bytes: $([BitConverter]::ToString($bytes, 0, [Math]::Min(16, $bytes.Length)))"
Write-Host ""

foreach ($key in $keyCandidates) {
    $decrypted = New-Object byte[] $bytes.Length
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        $decrypted[$i] = $bytes[$i] -bxor $key
    }
    $text = [System.Text.Encoding]::UTF8.GetString($decrypted)
    $preview = $text.Substring(0, [Math]::Min(200, $text.Length))
    Write-Host "Key 0x$($key.ToString('X2')): $preview"
    Write-Host ""
}

# Also try: key might not be simple XOR. Let me check if the LoadEncryptLuaScript
# does something more complex. First, read the raw bytes and see what the first byte
# decrypts to with known text patterns.
# If first line is "local QUESTID" then 'l' = 0x6C
$firstByte = $bytes[0]
$expectedLua = [byte][char]'l'
$actualKey = $firstByte -bxor $expectedLua
Write-Host "If first char is 'l': key = 0x$($actualKey.ToString('X2')) ($actualKey)"

# Check Common.lua which should start with some standard Lua
$commonFile = Get-ChildItem -Path "$luaDir\Common" -Filter "*.bytes" | Select-Object -First 1
if ($commonFile) {
    $commonBytes = [System.IO.File]::ReadAllBytes($commonFile.FullName)
    Write-Host "`nCommon file: $($commonFile.Name)"
    Write-Host "First 16 encrypted bytes: $([BitConverter]::ToString($commonBytes, 0, [Math]::Min(16, $commonBytes.Length)))"

    # Common.lua likely starts with an enum/table definition or comment
    # If it starts with "--" (Lua comment): '-' = 0x2D
    $key1 = $commonBytes[0] -bxor [byte][char]'-'
    $key2 = $commonBytes[0] -bxor [byte][char]'E'  # from the garbled output starts with 'e' lowercase, maybe 'E' = enum?
    Write-Host "If first char is '-': key = 0x$($key1.ToString('X2'))"
    Write-Host "If first char is 'E': key = 0x$($key2.ToString('X2'))"

    # The garbled output showed "eIKKIH" for what should be "Common" (based on Common.lua)
    # Actually, looking at the output pattern, it seems alphabetic with case shifts
    # Let me check: 'C' XOR 0xD2 = ? and 'e' XOR encrypted_byte = ?
    # First 6 bytes of garbled: e I K K I H
    # If this is: C o m m o n (the word "Common")
    # C=0x43, e=0x65... that doesn't work with simple XOR since 0x43 XOR 0x65 = 0x26
    # o=0x6F, I=0x49... 0x6F XOR 0x49 = 0x26
    # So the garbled output differs from expected by consistent 0x26

    # Try XOR with 0xF4
    $decrypted = New-Object byte[] $commonBytes.Length
    for ($i = 0; $i -lt $commonBytes.Length; $i++) {
        $decrypted[$i] = $commonBytes[$i] -bxor 0xF4
    }
    $text = [System.Text.Encoding]::UTF8.GetString($decrypted)
    Write-Host "`nCommon.lua with key 0xF4:"
    $lines = $text -split "`n"
    for ($j = 0; $j -lt [Math]::Min(30, $lines.Count); $j++) {
        Write-Host $lines[$j]
    }
}
