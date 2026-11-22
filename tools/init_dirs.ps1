Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$workspace = Split-Path -Parent $scriptDir

$outDir69 = Join-Path $workspace "MARITY_TRADE_APP_STORE\iPhone_6.9"
$outDir63 = Join-Path $workspace "MARITY_TRADE_APP_STORE\iPhone_6.3"

[System.IO.Directory]::CreateDirectory($outDir69) | Out-Null
[System.IO.Directory]::CreateDirectory($outDir63) | Out-Null

Write-Output "Directories initialized:"
Write-Output "  6.9: $outDir69"
Write-Output "  6.3: $outDir63"
