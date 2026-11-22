Add-Type -AssemblyName System.Drawing

$workspace = Split-Path -Parent $PSScriptRoot
$destRoot = Join-Path $workspace "tools/android_assets"
[System.IO.Directory]::CreateDirectory($destRoot) | Out-Null

Write-Host ">>> Generating Android App Icons for Marity Trade in: $destRoot"

$srcLogoPath = Join-Path $workspace "assets/marity_logo_icon.png"
if (-not (Test-Path $srcLogoPath)) {
    $srcLogoPath = Join-Path $workspace "assets/marity_logo.png"
}
$srcImg = [System.Drawing.Image]::FromFile($srcLogoPath)

# 1. Google Play Store 512x512 Icon
$playBmp = New-Object System.Drawing.Bitmap(512, 512)
$pg = [System.Drawing.Graphics]::FromImage($playBmp)
$pg.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$pg.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$pg.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

$bgBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))
$pg.FillRectangle($bgBrush, 0, 0, 512, 512)
$bgBrush.Dispose()

$pg.DrawImage($srcImg, 96, 96, 320, 320)
$pg.Dispose()

$playPath = Join-Path $destRoot "play_store_icon.png"
$playBmp.Save($playPath, [System.Drawing.Imaging.ImageFormat]::Png)
$playBmp.Dispose()
Write-Host "  ✓ Saved Google Play Store 512x512 Icon: play_store_icon.png"

# 2. Standard Mipmap Sizes for Launcher & Round Icons
$mipmapDensities = @(
    @{ name = "mipmap-mdpi"; size = 48; fgSize = 108 },
    @{ name = "mipmap-hdpi"; size = 72; fgSize = 162 },
    @{ name = "mipmap-xhdpi"; size = 96; fgSize = 216 },
    @{ name = "mipmap-xxhdpi"; size = 144; fgSize = 324 },
    @{ name = "mipmap-xxxhdpi"; size = 192; fgSize = 432 }
)

foreach ($d in $mipmapDensities) {
    $dirPath = Join-Path $destRoot $d.name
    [System.IO.Directory]::CreateDirectory($dirPath) | Out-Null
    
    $s = $d.size
    
    # Square / Legacy ic_launcher.png
    $bmpSquare = New-Object System.Drawing.Bitmap($s, $s)
    $g = [System.Drawing.Graphics]::FromImage($bmpSquare)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.Clear([System.Drawing.ColorTranslator]::FromHtml("#11151F"))
    $padding = [int]($s * 0.16)
    $logoDim = $s - ($padding * 2)
    $g.DrawImage($srcImg, $padding, $padding, $logoDim, $logoDim)
    $g.Dispose()
    $bmpSquare.Save((Join-Path $dirPath "ic_launcher.png"), [System.Drawing.Imaging.ImageFormat]::Png)
    $bmpSquare.Dispose()

    # Round ic_launcher_round.png
    $bmpRound = New-Object System.Drawing.Bitmap($s, $s)
    $gr = [System.Drawing.Graphics]::FromImage($bmpRound)
    $gr.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gr.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    
    $circlePath = New-Object System.Drawing.Drawing2D.GraphicsPath
    $circlePath.AddEllipse(0, 0, $s, $s)
    $gr.SetClip($circlePath)
    $gr.Clear([System.Drawing.ColorTranslator]::FromHtml("#11151F"))
    $gr.DrawImage($srcImg, $padding, $padding, $logoDim, $logoDim)
    $gr.Dispose()
    $circlePath.Dispose()
    $bmpRound.Save((Join-Path $dirPath "ic_launcher_round.png"), [System.Drawing.Imaging.ImageFormat]::Png)
    $bmpRound.Dispose()

    # Adaptive Foreground ic_launcher_foreground.png (108dp standard)
    $fgS = $d.fgSize
    $bmpFg = New-Object System.Drawing.Bitmap($fgS, $fgS)
    $gfg = [System.Drawing.Graphics]::FromImage($bmpFg)
    $gfg.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gfg.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $gfg.Clear([System.Drawing.Color]::Transparent)
    
    # Safe zone for adaptive icon: center 66dp of 108dp
    $safeDim = [int]($fgS * 0.58)
    $safeOffset = ($fgS - $safeDim) / 2
    $gfg.DrawImage($srcImg, $safeOffset, $safeOffset, $safeDim, $safeDim)
    $gfg.Dispose()
    $bmpFg.Save((Join-Path $dirPath "ic_launcher_foreground.png"), [System.Drawing.Imaging.ImageFormat]::Png)
    $bmpFg.Dispose()
    
    Write-Host "  ✓ Generated mipmap density: $($d.name)"
}

# 3. Android Splash Drawable
$drawableDir = Join-Path $destRoot "drawable"
[System.IO.Directory]::CreateDirectory($drawableDir) | Out-Null

$splashBmp = New-Object System.Drawing.Bitmap(1080, 1920)
$sg = [System.Drawing.Graphics]::FromImage($splashBmp)
$sg.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$sg.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$sg.Clear([System.Drawing.ColorTranslator]::FromHtml("#11151F"))

$logoW = 460
$logoH = [int]($srcImg.Height * ($logoW / $srcImg.Width))
$logoX = (1080 - $logoW) / 2
$logoY = (1920 - $logoH) / 2 - 40
$sg.DrawImage($srcImg, $logoX, $logoY, $logoW, $logoH)

$subFont = New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$subBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#E5C378"))
$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = [System.Drawing.StringAlignment]::Center
$sg.DrawString("LUXURY FRAGRANCES", $subFont, $subBrush, 540, ($logoY + $logoH + 28), $sf)
$subFont.Dispose(); $subBrush.Dispose(); $sg.Dispose()

$splashBmp.Save((Join-Path $drawableDir "splash.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$splashBmp.Dispose()
Write-Host "  ✓ Generated Android Splash screen: drawable/splash.png"

# 4. Adaptive Icon Background Color Resource
$valuesDir = Join-Path $destRoot "values"
[System.IO.Directory]::CreateDirectory($valuesDir) | Out-Null
$colorsXml = @'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="colorPrimary">#11151F</color>
    <color name="colorPrimaryDark">#0B0E14</color>
    <color name="colorAccent">#E5C378</color>
    <color name="ic_launcher_background">#11151F</color>
</resources>
'@
[System.IO.File]::WriteAllText((Join-Path $valuesDir "colors.xml"), $colorsXml)
Write-Host "  ✓ Generated Android Color Resource: values/colors.xml"

$srcImg.Dispose()
Write-Host ">>> Android assets successfully generated!"
