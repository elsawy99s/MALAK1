$ErrorActionPreference = 'Stop'

$secureKey = Read-Host 'أدخلي مفتاح OpenAI الجديد (الإدخال مخفي)' -AsSecureString
if (-not $secureKey -or $secureKey.Length -eq 0) {
    throw 'لم يتم إدخال مفتاح OpenAI.'
}

$env:OPENAI_API_KEY = (New-Object System.Net.NetworkCredential('', $secureKey)).Password
$secureKey.Dispose()

try {
    & (Join-Path $PSScriptRoot 'server.ps1')
}
finally {
    Remove-Item Env:OPENAI_API_KEY -ErrorAction SilentlyContinue
}
