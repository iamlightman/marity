Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

function Create-RoundedRectanglePath {
    param(
        [System.Drawing.RectangleF]$rect,
        [float]$radius
    )
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $diameter = $radius * 2.0
    $arc = New-Object System.Drawing.RectangleF($rect.X, $rect.Y, $diameter, $diameter)
    
    # Top Left
    $path.AddArc($arc, 180, 90)
    
    # Top Right
    $arc.X = $rect.Right - $diameter
    $path.AddArc($arc, 270, 90)
    
    # Bottom Right
    $arc.Y = $rect.Bottom - $diameter
    $path.AddArc($arc, 0, 90)
    
    # Bottom Left
    $arc.X = $rect.Left
    $path.AddArc($arc, 90, 90)
    
    $path.CloseFigure()
    return $path
}

$bmp = New-Object System.Drawing.Bitmap(1320, 2868)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

# Draw canvas gradient
$bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.PointF(0, 0)),
    (New-Object System.Drawing.PointF(0, 2868)),
    [System.Drawing.ColorTranslator]::FromHtml("#F8FAFD"),
    [System.Drawing.ColorTranslator]::FromHtml("#EAF0F6")
)
$g.FillRectangle($bgBrush, 0, 0, 1320, 2868)
$bgBrush.Dispose()

# Marketing Header
$tagFont = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$tagBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))
$sfCenter = New-Object System.Drawing.StringFormat
$sfCenter.Alignment = [System.Drawing.StringAlignment]::Center

$g.DrawString("MARITY TRADE • HAUTE PARFUMERIE", $tagFont, $tagBrush, 660, 120, $sfCenter)

$headFont = New-Object System.Drawing.Font("Georgia", 48, [System.Drawing.FontStyle]::Bold)
$headBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))
$g.DrawString("DISCOVER YOUR SIGNATURE", $headFont, $headBrush, 660, 175, $sfCenter)

$subFont = New-Object System.Drawing.Font("Segoe UI", 24, [System.Drawing.FontStyle]::Regular)
$subBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))
$subRect = New-Object System.Drawing.RectangleF(110, 275, 1100, 100)
$g.DrawString("Artisanal extraits & fine fragrances handcrafted in Grasse, France.", $subFont, $subBrush, $subRect, $sfCenter)

# Output test
$testOut = "MARITY_TRADE_APP_STORE/iPhone_6.9/test_01.png"
$bmp.Save($testOut, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
Write-Output "Test canvas rendered: $testOut"
