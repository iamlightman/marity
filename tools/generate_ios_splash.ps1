Add-Type -AssemblyName System.Drawing

$workspace = Split-Path -Parent $PSScriptRoot
$destDir = Join-Path $workspace "ios/App/App/Assets.xcassets/Splash.imageset"
[System.IO.Directory]::CreateDirectory($destDir) | Out-Null

Write-Host ">>> Generating iOS Splash Screen for Marity Trade in: $destDir"

# Master Splash (1284 x 2778 px for iPhone 3x)
$splashBmp = New-Object System.Drawing.Bitmap(1284, 2778)
$g = [System.Drawing.Graphics]::FromImage($splashBmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Deep Onyx luxury background
$bgBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))
$g.FillRectangle($bgBrush, 0, 0, 1284, 2778)
$bgBrush.Dispose()

# Load logo
$srcLogoPath = Join-Path $workspace "assets/marity_logo.png"
$srcImg = [System.Drawing.Image]::FromFile($srcLogoPath)

# Proportional centered logo
$logoW = 560
$logoH = [int]($srcImg.Height * ($logoW / $srcImg.Width))
$logoX = (1284 - $logoW) / 2
$logoY = (2778 - $logoH) / 2 - 60
$g.DrawImage($srcImg, $logoX, $logoY, $logoW, $logoH)
$srcImg.Dispose()

# Wordmark subtitle below logo
$subFont = New-Object System.Drawing.Font("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
$subBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#E5C378"))
$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = [System.Drawing.StringAlignment]::Center
$g.DrawString("LUXURY FRAGRANCES", $subFont, $subBrush, 642, ($logoY + $logoH + 30), $sf)
$subFont.Dispose(); $subBrush.Dispose()
$g.Dispose()

# Save 3x (1284 x 2778)
$p3x = Join-Path $destDir "splash@3x.png"
$splashBmp.Save($p3x, [System.Drawing.Imaging.ImageFormat]::Png)

# 2x (828 x 1792)
$bmp2x = New-Object System.Drawing.Bitmap(828, 1792)
$g2 = [System.Drawing.Graphics]::FromImage($bmp2x)
$g2.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g2.DrawImage($splashBmp, 0, 0, 828, 1792)
$g2.Dispose()
$p2x = Join-Path $destDir "splash@2x.png"
$bmp2x.Save($p2x, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp2x.Dispose()

# 1x (414 x 896)
$bmp1x = New-Object System.Drawing.Bitmap(414, 896)
$g1 = [System.Drawing.Graphics]::FromImage($bmp1x)
$g1.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g1.DrawImage($splashBmp, 0, 0, 414, 896)
$g1.Dispose()
$p1x = Join-Path $destDir "splash.png"
$bmp1x.Save($p1x, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp1x.Dispose()

$splashBmp.Dispose()

# Write Contents.json for Splash.imageset
$contentsJson = @'
{
  "images": [
    {
      "idiom": "universal",
      "scale": "1x",
      "filename": "splash.png"
    },
    {
      "idiom": "universal",
      "scale": "2x",
      "filename": "splash@2x.png"
    },
    {
      "idiom": "universal",
      "scale": "3x",
      "filename": "splash@3x.png"
    }
  ],
  "info": {
    "author": "xcode",
    "version": 1
  }
}
'@

$contentsPath = Join-Path $destDir "Contents.json"
[System.IO.File]::WriteAllText($contentsPath, $contentsJson)
Write-Host ">>> Splash.imageset generated successfully!"
