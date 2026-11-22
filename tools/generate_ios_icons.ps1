Add-Type -AssemblyName System.Drawing

$workspace = Split-Path -Parent $PSScriptRoot
$destDir = Join-Path $workspace "ios/App/App/Assets.xcassets/AppIcon.appiconset"
[System.IO.Directory]::CreateDirectory($destDir) | Out-Null

Write-Host ">>> Generating iOS App Icons for Marity Trade in: $destDir"

# Master 1024x1024 Icon
$masterBmp = New-Object System.Drawing.Bitmap(1024, 1024)
$g = [System.Drawing.Graphics]::FromImage($masterBmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

# Luxury Onyx Background (Apple requires 0% transparency)
$bgBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))
$g.FillRectangle($bgBrush, 0, 0, 1024, 1024)
$bgBrush.Dispose()

# Subtle platinum & gold radial vignette
$gradBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.PointF(0, 0)),
    (New-Object System.Drawing.PointF(1024, 1024)),
    [System.Drawing.Color]::FromArgb(40, 229, 195, 120),
    [System.Drawing.Color]::FromArgb(0, 17, 21, 31)
)
$g.FillRectangle($gradBrush, 0, 0, 1024, 1024)
$gradBrush.Dispose()

# Load source logo
$srcLogoPath = Join-Path $workspace "assets/marity_logo_icon.png"
if (-not (Test-Path $srcLogoPath)) {
    $srcLogoPath = Join-Path $workspace "assets/marity_logo.png"
}
$srcImg = [System.Drawing.Image]::FromFile($srcLogoPath)

# Draw centered icon with luxury proportions (640x640 on 1024x1024 canvas)
$logoSize = 640
$logoX = (1024 - $logoSize) / 2
$logoY = (1024 - $logoSize) / 2
$g.DrawImage($srcImg, $logoX, $logoY, $logoSize, $logoSize)
$srcImg.Dispose()
$g.Dispose()

# Save Master 1024
$masterPath = Join-Path $destDir "AppIcon-512@2x.png"
$masterBmp.Save($masterPath, [System.Drawing.Imaging.ImageFormat]::Png)
Write-Host "  ✓ Saved AppIcon-512@2x.png (1024x1024)"

# Define all required iOS icon sizes
$sizes = @(
    @{ name = "AppIcon-20@2x.png"; size = 40 },
    @{ name = "AppIcon-20@3x.png"; size = 60 },
    @{ name = "AppIcon-29@2x.png"; size = 58 },
    @{ name = "AppIcon-29@3x.png"; size = 87 },
    @{ name = "AppIcon-40@2x.png"; size = 80 },
    @{ name = "AppIcon-40@3x.png"; size = 120 },
    @{ name = "AppIcon-60@2x.png"; size = 120 },
    @{ name = "AppIcon-60@3x.png"; size = 180 },
    @{ name = "AppIcon-76@2x.png"; size = 152 },
    @{ name = "AppIcon-83.5@2x.png"; size = 167 }
)

foreach ($item in $sizes) {
    $s = $item.size
    $subBmp = New-Object System.Drawing.Bitmap($s, $s)
    $sg = [System.Drawing.Graphics]::FromImage($subBmp)
    $sg.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $sg.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $sg.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $sg.DrawImage($masterBmp, 0, 0, $s, $s)
    $sg.Dispose()
    
    $outP = Join-Path $destDir $item.name
    $subBmp.Save($outP, [System.Drawing.Imaging.ImageFormat]::Png)
    $subBmp.Dispose()
    Write-Host "  ✓ Saved $($item.name) ($s x $s)"
}

$masterBmp.Dispose()

# Write Contents.json for AppIcon.appiconset
$contentsJson = @'
{
  "images": [
    {
      "idiom": "iphone",
      "scale": "2x",
      "size": "20x20",
      "filename": "AppIcon-20@2x.png"
    },
    {
      "idiom": "iphone",
      "scale": "3x",
      "size": "20x20",
      "filename": "AppIcon-20@3x.png"
    },
    {
      "idiom": "iphone",
      "scale": "2x",
      "size": "29x29",
      "filename": "AppIcon-29@2x.png"
    },
    {
      "idiom": "iphone",
      "scale": "3x",
      "size": "29x29",
      "filename": "AppIcon-29@3x.png"
    },
    {
      "idiom": "iphone",
      "scale": "2x",
      "size": "40x40",
      "filename": "AppIcon-40@2x.png"
    },
    {
      "idiom": "iphone",
      "scale": "3x",
      "size": "40x40",
      "filename": "AppIcon-40@3x.png"
    },
    {
      "idiom": "iphone",
      "scale": "2x",
      "size": "60x60",
      "filename": "AppIcon-60@2x.png"
    },
    {
      "idiom": "iphone",
      "scale": "3x",
      "size": "60x60",
      "filename": "AppIcon-60@3x.png"
    },
    {
      "idiom": "ipad",
      "scale": "2x",
      "size": "76x76",
      "filename": "AppIcon-76@2x.png"
    },
    {
      "idiom": "ipad",
      "scale": "2x",
      "size": "83.5x83.5",
      "filename": "AppIcon-83.5@2x.png"
    },
    {
      "idiom": "ios-marketing",
      "scale": "1x",
      "size": "1024x1024",
      "filename": "AppIcon-512@2x.png"
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
Write-Host ">>> AppIcon.appiconset generated successfully!"
