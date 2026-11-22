# ==============================================================================
# MARITY TRADE — APPLE APP STORE OFFICIAL SCREENSHOT GENERATOR
# Exact Pixel Dimensions:
#   - iPhone 6.9-inch: 1320 x 2868 px
#   - iPhone 6.3-inch: 1206 x 2622 px
# 100% Genuine Application Features • Zero Fake Account Screens
# ==============================================================================

Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$workspace = Split-Path -Parent $scriptDir

$outDir69 = Join-Path $workspace "MARITY_TRADE_APP_STORE\iPhone_6.9"
$outDir63 = Join-Path $workspace "MARITY_TRADE_APP_STORE\iPhone_6.3"

[System.IO.Directory]::CreateDirectory($outDir69) | Out-Null
[System.IO.Directory]::CreateDirectory($outDir63) | Out-Null

Write-Host ">>> Initializing High-Resolution Asset Cache..."
$assets = @{
    HeroBottle     = [System.Drawing.Image]::FromFile((Join-Path $workspace "assets/hero_bottle.png"))
    SoleilDor      = [System.Drawing.Image]::FromFile((Join-Path $workspace "assets/bottle_soleil_dor.png"))
    ObsidianNoir   = [System.Drawing.Image]::FromFile((Join-Path $workspace "assets/bottle_obsidian_noir.png"))
    OceanBreeze    = [System.Drawing.Image]::FromFile((Join-Path $workspace "assets/product_ocean_breeze.png"))
    VelvetBloom    = [System.Drawing.Image]::FromFile((Join-Path $workspace "assets/product_velvet_bloom.png"))
    CatMens        = [System.Drawing.Image]::FromFile((Join-Path $workspace "assets/cat_mens.png"))
    CatWomens      = [System.Drawing.Image]::FromFile((Join-Path $workspace "assets/cat_womens.png"))
    CatUnisex      = [System.Drawing.Image]::FromFile((Join-Path $workspace "assets/cat_unisex.png"))
    CatGifts       = [System.Drawing.Image]::FromFile((Join-Path $workspace "assets/cat_gifts.png"))
}

# --- GEOMETRY HELPERS ---
function Get-RoundPath([System.Drawing.RectangleF]$rect, [float]$radius) {
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $diameter = $radius * 2.0
    $arc = New-Object System.Drawing.RectangleF($rect.X, $rect.Y, $diameter, $diameter)
    $path.AddArc($arc, 180, 90)
    $arc.X = $rect.Right - $diameter
    $path.AddArc($arc, 270, 90)
    $arc.Y = $rect.Bottom - $diameter
    $path.AddArc($arc, 0, 90)
    $arc.X = $rect.Left
    $path.AddArc($arc, 90, 90)
    $path.CloseFigure()
    return $path
}

function Draw-BaseCanvas([System.Drawing.Graphics]$g, [string]$tag, [string]$headline, [string]$subtitle) {
    # 1. Subtle luxury platinum gradient background
    $bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.PointF(0, 0)),
        (New-Object System.Drawing.PointF(0, 2868)),
        [System.Drawing.ColorTranslator]::FromHtml("#FDFEFE"),
        [System.Drawing.ColorTranslator]::FromHtml("#EBF1F7")
    )
    $g.FillRectangle($bgBrush, 0, 0, 1320, 2868)
    $bgBrush.Dispose()

    # Subtle ambient champagne ellipse glow at top
    $glowBrush = New-Object System.Drawing.Drawing2D.PathGradientBrush((Get-RoundPath (New-Object System.Drawing.RectangleF(160, 40, 1000, 320)) 160))
    $glowBrush.CenterColor = [System.Drawing.Color]::FromArgb(40, 229, 195, 120)
    $glowBrush.SurroundColors = @([System.Drawing.Color]::FromArgb(0, 255, 255, 255))
    $g.FillEllipse($glowBrush, 160, 40, 1000, 320)
    $glowBrush.Dispose()

    # 2. Marketing Tagline
    $tagFont = New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)
    $tagBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))
    $sfCenter = New-Object System.Drawing.StringFormat
    $sfCenter.Alignment = [System.Drawing.StringAlignment]::Center

    $g.DrawString($tag.ToUpper(), $tagFont, $tagBrush, 660, 110, $sfCenter)

    # 3. Main Headline
    $headFont = New-Object System.Drawing.Font("Georgia", 46, [System.Drawing.FontStyle]::Bold)
    $headBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))
    $g.DrawString($headline, $headFont, $headBrush, 660, 155, $sfCenter)

    # 4. Subtitle
    $subFont = New-Object System.Drawing.Font("Segoe UI", 21, [System.Drawing.FontStyle]::Regular)
    $subBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))
    $subRect = New-Object System.Drawing.RectangleF(110, 250, 1100, 90)
    $g.DrawString($subtitle, $subFont, $subBrush, $subRect, $sfCenter)

    $tagFont.Dispose(); $tagBrush.Dispose(); $headFont.Dispose(); $headBrush.Dispose(); $subFont.Dispose(); $subBrush.Dispose()
}

function Draw-iPhoneFrame([System.Drawing.Graphics]$g) {
    # Frame dimensions
    [float]$frameX = 135.0
    [float]$frameY = 380.0
    [float]$frameW = 1050.0
    [float]$frameH = 2488.0
    [float]$radius = 68.0

    # Outer Drop Shadow
    $shadowRect = [System.Drawing.RectangleF]::new(($frameX - 10.0), ($frameY + 16.0), ($frameW + 20.0), ($frameH + 10.0))
    $shadowPath = Get-RoundPath $shadowRect ($radius + 6.0)
    $shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(45, 15, 23, 42))
    $g.FillPath($shadowBrush, $shadowPath)
    $shadowBrush.Dispose(); $shadowPath.Dispose()

    # Titanium Rim
    $rimRect = [System.Drawing.RectangleF]::new($frameX, $frameY, $frameW, $frameH)
    $rimPath = Get-RoundPath $rimRect $radius
    $rimBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#D3DCE6"))
    $g.FillPath($rimBrush, $rimPath)
    
    $rimPen = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 3.0)
    $g.DrawPath($rimPen, $rimPath)
    $rimBrush.Dispose(); $rimPen.Dispose(); $rimPath.Dispose()

    # Inner Screen Frame (Obsidian Bezel)
    $screenRect = [System.Drawing.RectangleF]::new(($frameX + 8.0), ($frameY + 8.0), ($frameW - 16.0), ($frameH - 16.0))
    $screenPath = Get-RoundPath $screenRect ($radius - 8.0)
    $screenBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))
    $g.FillPath($screenBrush, $screenPath)
    $screenBrush.Dispose()

    # Screen Bezel Pen
    $bezelPen = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#11151F"), 10.0)
    $g.DrawPath($bezelPen, $screenPath)
    $bezelPen.Dispose(); $screenPath.Dispose()

    # Return screen bounds
    return [System.Drawing.RectangleF]::new(($frameX + 16.0), ($frameY + 16.0), ($frameW - 32.0), ($frameH - 32.0))
}

function Draw-DynamicIslandAndStatus([System.Drawing.Graphics]$g, [System.Drawing.RectangleF]$screen) {
    # Dynamic Island Pill
    $diW = 280
    $diH = 68
    $diX = $screen.X + ($screen.Width - $diW) / 2.0
    $diY = $screen.Y + 22
    $diRect = New-Object System.Drawing.RectangleF($diX, $diY, $diW, $diH)
    $diPath = Get-RoundPath $diRect 34
    $diBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#0B0E14"))
    $g.FillPath($diBrush, $diPath)
    $diBrush.Dispose(); $diPath.Dispose()

    # Status Bar Time
    $timeFont = New-Object System.Drawing.Font("Segoe UI", 21, [System.Drawing.FontStyle]::Bold)
    $timeBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))
    $g.DrawString("9:41", $timeFont, $timeBrush, ($screen.X + 68), ($screen.Y + 38))
    
    # Status Bar Icons (Cellular, Wifi, Battery)
    $statusFont = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("5G  􀙇  􀛨", $statusFont, $timeBrush, ($screen.Right - 160), ($screen.Y + 42))
    $timeFont.Dispose(); $timeBrush.Dispose(); $statusFont.Dispose()
}

function Draw-AppHeaderBar([System.Drawing.Graphics]$g, [System.Drawing.RectangleF]$screen) {
    $headerY = $screen.Y + 104
    
    # Marity wordmark
    $brandFont = New-Object System.Drawing.Font("Georgia", 32, [System.Drawing.FontStyle]::Bold)
    $brandBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))
    $g.DrawString("Marity", $brandFont, $brandBrush, ($screen.X + 36), $headerY)
    
    # TRADE submark
    $tradeFont = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $tradeBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))
    $g.DrawString("TRADE", $tradeFont, $tradeBrush, ($screen.X + 168), ($headerY + 16))

    # Search circular button
    $searchX = $screen.Right - 150
    $btnRect1 = New-Object System.Drawing.RectangleF($searchX, ($headerY + 2), 48, 48)
    $btnPath1 = Get-RoundPath $btnRect1 24
    $btnBrush1 = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F1F5F9"))
    $g.FillPath($btnBrush1, $btnPath1)
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 1.5)), $btnPath1)
    
    $iconFont = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("⌕", $iconFont, $brandBrush, ($searchX + 12), ($headerY + 4))

    # Cart circular button with champagne badge
    $cartX = $screen.Right - 84
    $btnRect2 = New-Object System.Drawing.RectangleF($cartX, ($headerY + 2), 48, 48)
    $btnPath2 = Get-RoundPath $btnRect2 24
    $g.FillPath($btnBrush1, $btnPath2)
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 1.5)), $btnPath2)
    $g.DrawString("🛍", (New-Object System.Drawing.Font("Segoe UI", 14)), $brandBrush, ($cartX + 11), ($headerY + 11))

    # Bag count badge
    $badgeRect = New-Object System.Drawing.RectangleF(($cartX + 30), ($headerY - 4), 24, 24)
    $badgePath = Get-RoundPath $badgeRect 12
    $badgeBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#E5C378"))
    $g.FillPath($badgeBrush, $badgePath)
    $g.DrawString("2", (New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($cartX + 36), ($headerY + 1))

    # Clean up
    $brandFont.Dispose(); $brandBrush.Dispose(); $tradeFont.Dispose(); $tradeBrush.Dispose(); $btnBrush1.Dispose(); $badgeBrush.Dispose()
}

function Draw-BottomCapsuleDock([System.Drawing.Graphics]$g, [System.Drawing.RectangleF]$screen, [string]$activeTab) {
    $dockW = 880
    $dockH = 104
    $dockX = $screen.X + ($screen.Width - $dockW) / 2.0
    $dockY = $screen.Bottom - 146
    
    $dockRect = New-Object System.Drawing.RectangleF($dockX, $dockY, $dockW, $dockH)
    $dockPath = Get-RoundPath $dockRect 52
    
    # Beveled Frosted Glass Fill
    $dockBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(246, 255, 255, 255))
    $g.FillPath($dockBrush, $dockPath)
    $dockPen = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#DCE5EF"), 2.5)
    $g.DrawPath($dockPen, $dockPath)
    
    # 4 tabs: Home, Shop, Orders, Wholesale
    $tabW = $dockW / 4.0
    $tabs = @('Home', 'Shop', 'Orders', 'Wholesale')
    $icons = @('⌂', '◻', '◷', '◈')
    
    for ($i = 0; $i -lt 4; $i++) {
        $tName = $tabs[$i]
        $tIcon = $icons[$i]
        $tx = $dockX + ($i * $tabW)
        
        if ($tName -eq $activeTab) {
            # Active tactile champagne pill
            $pillRect = New-Object System.Drawing.RectangleF(($tx + 8), ($dockY + 10), ($tabW - 16), ($dockH - 20))
            $pillPath = Get-RoundPath $pillRect 42
            $pillBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
                (New-Object System.Drawing.PointF($pillRect.X, $pillRect.Y)),
                (New-Object System.Drawing.PointF($pillRect.X, $pillRect.Bottom)),
                [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"),
                [System.Drawing.ColorTranslator]::FromHtml("#F5F1E6")
            )
            $g.FillPath($pillBrush, $pillPath)
            $pillPen = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E5C378"), 2.2)
            $g.DrawPath($pillPen, $pillPath)
            
            # Active Text & Icon
            $actFont = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
            $actBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))
            $g.DrawString("$tIcon $tName", $actFont, $actBrush, ($tx + $tabW/2.0), ($dockY + 36), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
            $pillBrush.Dispose(); $pillPen.Dispose(); $pillPath.Dispose(); $actFont.Dispose(); $actBrush.Dispose()
        } else {
            # Inactive Tab
            $inactFont = New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Regular)
            $inactBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))
            $g.DrawString("$tIcon $tName", $inactFont, $inactBrush, ($tx + $tabW/2.0), ($dockY + 38), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
            $inactFont.Dispose(); $inactBrush.Dispose()
        }
    }
    
    # iPhone Home Indicator Bar
    $barW = 320
    $barH = 8
    $barX = $screen.X + ($screen.Width - $barW) / 2.0
    $barY = $screen.Bottom - 26
    $barPath = Get-RoundPath (New-Object System.Drawing.RectangleF($barX, $barY, $barW, $barH)) 4
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#0E121B"))), $barPath)
    $barPath.Dispose()
    
    $dockBrush.Dispose(); $dockPen.Dispose(); $dockPath.Dispose()
}

# --- SAVE DUAL RESOLUTIONS HELPER ---
function Save-ScreenshotDual([System.Drawing.Bitmap]$bmpMaster, [string]$filename) {
    # 1. Save 6.9-inch (1320 x 2868)
    $path69 = Join-Path $outDir69 $filename
    $bmpMaster.Save($path69, [System.Drawing.Imaging.ImageFormat]::Png)
    Write-Host "  [OK 6.9] $filename (1320 x 2868)"

    # 2. Resample to 6.3-inch (1206 x 2622) with HighQualityBicubic
    $bmp63 = New-Object System.Drawing.Bitmap(1206, 2622)
    $g63 = [System.Drawing.Graphics]::FromImage($bmp63)
    $g63.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g63.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g63.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g63.DrawImage($bmpMaster, 0, 0, 1206, 2622)
    
    $path63 = Join-Path $outDir63 $filename
    $bmp63.Save($path63, [System.Drawing.Imaging.ImageFormat]::Png)
    $g63.Dispose(); $bmp63.Dispose()
    Write-Host "  [OK 6.3] $filename (1206 x 2622)"
}

# ==============================================================================
# SCREEN 01 — HOMEPAGE
# ==============================================================================
function Build-Screen01 {
    Write-Host "`n>>> Generating Screen 01: Homepage..."
    $bmp = New-Object System.Drawing.Bitmap(1320, 2868)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    Draw-BaseCanvas $g "MARITY TRADE • FINE FRAGRANCES" "DISCOVER YOUR SIGNATURE" "Artisanal extraits & fine fragrances handcrafted in Grasse, France."
    $screen = Draw-iPhoneFrame $g
    Draw-DynamicIslandAndStatus $g $screen
    Draw-AppHeaderBar $g $screen

    # Hero Editorial Stage
    $heroY = $screen.Y + 180
    $heroRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $heroY, ($screen.Width - 72), 620)
    $heroPath = Get-RoundPath $heroRect 36
    $heroGrad = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.PointF($heroRect.X, $heroRect.Y)),
        (New-Object System.Drawing.PointF($heroRect.Right, $heroRect.Bottom)),
        [System.Drawing.ColorTranslator]::FromHtml("#0F141F"),
        [System.Drawing.ColorTranslator]::FromHtml("#1C2333")
    )
    $g.FillPath($heroGrad, $heroPath)

    # Hero Text Copy
    $g.DrawString("The Art of", (New-Object System.Drawing.Font("Georgia", 20, [System.Drawing.FontStyle]::Italic)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#E5C378"))), ($heroRect.X + 44), ($heroY + 80))
    $g.DrawString("FRAGRANCE", (New-Object System.Drawing.Font("Georgia", 38, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($heroRect.X + 40), ($heroY + 120))
    $g.DrawString("Timeless elegance.`nUnforgettable presence.", (New-Object System.Drawing.Font("Segoe UI", 16)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#94A3B8"))), ($heroRect.X + 44), ($heroY + 195))
    
    # Hero CTA Pill Button
    $ctaRect = New-Object System.Drawing.RectangleF(($heroRect.X + 44), ($heroY + 290), 220, 56)
    $ctaPath = Get-RoundPath $ctaRect 28
    $g.FillPath((New-Object System.Drawing.Drawing2D.LinearGradientBrush((New-Object System.Drawing.PointF($ctaRect.X, $ctaRect.Y)), (New-Object System.Drawing.PointF($ctaRect.Right, $ctaRect.Bottom)), [System.Drawing.ColorTranslator]::FromHtml("#F9E7B3"), [System.Drawing.ColorTranslator]::FromHtml("#CFA348"))), $ctaPath)
    $g.DrawString("Explore Collection →", (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($ctaRect.X + 26), ($ctaRect.Y + 17))

    # Hero Flacon Bottle Image
    $flaconW = 420
    $flaconH = 460
    $g.DrawImage($assets.HeroBottle, ($heroRect.Right - $flaconW - 10), ($heroY + 80), $flaconW, $flaconH)

    # Category Pods Row
    $catY = $heroY + 660
    $catW = ($screen.Width - 72) / 4.0
    $cats = @(
        @{ Title = "Men's"; Img = $assets.CatMens },
        @{ Title = "Women's"; Img = $assets.CatWomens },
        @{ Title = "Unisex"; Img = $assets.CatUnisex },
        @{ Title = "Gifts"; Img = $assets.CatGifts }
    )
    for ($i = 0; $i -lt 4; $i++) {
        $cx = ($screen.X + 36) + ($i * $catW)
        $circleRect = New-Object System.Drawing.RectangleF(($cx + 20), $catY, 130, 130)
        $cPath = Get-RoundPath $circleRect 65
        $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F1F5F9"))), $cPath)
        $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), $cPath)
        $g.DrawImage($cats[$i].Img, ($circleRect.X + 16), ($circleRect.Y + 16), 98, 98)
        $g.DrawString($cats[$i].Title, (New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#334155"))), ($cx + 85), ($catY + 144), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
    }

    # Best Sellers Section Heading
    $bsY = $catY + 210
    $g.DrawString("Best Sellers", (New-Object System.Drawing.Font("Georgia", 28, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($screen.X + 36), $bsY)
    $g.DrawString("View All →", (New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))), ($screen.Right - 150), ($bsY + 8))

    # 2 Product Cards
    $cardW = ($screen.Width - 96) / 2.0
    $cardH = 590
    $cardY = $bsY + 60

    # Card 1: Ocean Breeze
    $c1Rect = New-Object System.Drawing.RectangleF(($screen.X + 36), $cardY, $cardW, $cardH)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $c1Rect 30))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $c1Rect 30))
    $g.DrawImage($assets.OceanBreeze, ($c1Rect.X + 40), ($cardY + 40), ($cardW - 80), 300)
    $g.DrawString("Ocean Breeze", (New-Object System.Drawing.Font("Georgia", 20, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($c1Rect.X + 24), ($cardY + 365))
    $g.DrawString("Extrait de Parfum", (New-Object System.Drawing.Font("Segoe UI", 13)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($c1Rect.X + 24), ($cardY + 405))
    $g.DrawString("GH₵129.00", (New-Object System.Drawing.Font("Segoe UI", 21, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($c1Rect.X + 24), ($cardY + 438))
    
    # Add to bag pill
    $addBtn1 = New-Object System.Drawing.RectangleF(($c1Rect.X + 24), ($cardY + 495), ($cardW - 48), 56)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $addBtn1 28))
    $g.DrawString("Add to Bag", (New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($addBtn1.X + $addBtn1.Width/2.0), ($addBtn1.Y + 16), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    # Card 2: Velvet Bloom
    $c2Rect = New-Object System.Drawing.RectangleF(($screen.X + 36 + $cardW + 24), $cardY, $cardW, $cardH)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $c2Rect 30))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $c2Rect 30))
    $g.DrawImage($assets.VelvetBloom, ($c2Rect.X + 40), ($cardY + 40), ($cardW - 80), 300)
    $g.DrawString("Velvet Bloom", (New-Object System.Drawing.Font("Georgia", 20, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($c2Rect.X + 24), ($cardY + 365))
    $g.DrawString("Pétale Sublime", (New-Object System.Drawing.Font("Segoe UI", 13)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($c2Rect.X + 24), ($cardY + 405))
    $g.DrawString("GH₵139.00", (New-Object System.Drawing.Font("Segoe UI", 21, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($c2Rect.X + 24), ($cardY + 438))
    
    # Add to bag pill 2
    $addBtn2 = New-Object System.Drawing.RectangleF(($c2Rect.X + 24), ($cardY + 495), ($cardW - 48), 56)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $addBtn2 28))
    $g.DrawString("Add to Bag", (New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($addBtn2.X + $addBtn2.Width/2.0), ($addBtn2.Y + 16), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    # Trust Pillar Banner
    $trustY = $cardY + 630
    $trustRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $trustY, ($screen.Width - 72), 90)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F1F5F9"))), (Get-RoundPath $trustRect 24))
    $g.DrawString("⚡ Express Delivery • Delivery within 12 to 24 hours in Accra", (New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#1E293B"))), ($screen.X + $screen.Width/2.0), ($trustY + 32), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    Draw-BottomCapsuleDock $g $screen "Home"

    Save-ScreenshotDual $bmp "01-homepage.png"
    $g.Dispose(); $bmp.Dispose()
}

# ==============================================================================
# SCREEN 02 — COLLECTION
# ==============================================================================
function Build-Screen02 {
    Write-Host "`n>>> Generating Screen 02: Product Collection..."
    $bmp = New-Object System.Drawing.Bitmap(1320, 2868)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    Draw-BaseCanvas $g "MARITY TRADE • FINE FRAGRANCES" "EXPLORE THE COLLECTION" "Curated flacons, pure oil extraits, and signature coffrets."
    $screen = Draw-iPhoneFrame $g
    Draw-DynamicIslandAndStatus $g $screen
    Draw-AppHeaderBar $g $screen

    $currY = $screen.Y + 180
    $g.DrawString("Marity Collection", (New-Object System.Drawing.Font("Georgia", 32, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($screen.X + 36), $currY)
    $g.DrawString("Hand-blended extrait and fine fragrance collection.", (New-Object System.Drawing.Font("Segoe UI", 15)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($screen.X + 36), ($currY + 52))

    # Filter Bar Pills
    $pillsY = $currY + 110
    $pills = @(
        @{ Title = "All Flacons"; Active = $true; W = 160 },
        @{ Title = "Men's"; Active = $false; W = 110 },
        @{ Title = "Women's"; Active = $false; W = 130 },
        @{ Title = "Unisex"; Active = $false; W = 115 },
        @{ Title = "Coffrets"; Active = $false; W = 130 }
    )
    $px = $screen.X + 36
    foreach ($p in $pills) {
        $pRect = New-Object System.Drawing.RectangleF($px, $pillsY, $p.W, 54)
        $pPath = Get-RoundPath $pRect 27
        if ($p.Active) {
            $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), $pPath)
            $g.DrawString($p.Title, (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($px + $p.W/2.0), ($pillsY + 17), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
        } else {
            $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F1F5F9"))), $pPath)
            $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 1.5)), $pPath)
            $g.DrawString($p.Title, (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#475569"))), ($px + $p.W/2.0), ($pillsY + 17), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
        }
        $px += $p.W + 16
    }

    # Olfactory Diagnostic Callout
    $diagY = $pillsY + 84
    $diagRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $diagY, ($screen.Width - 72), 116)
    $g.FillPath((New-Object System.Drawing.Drawing2D.LinearGradientBrush((New-Object System.Drawing.PointF($diagRect.X, $diagRect.Y)), (New-Object System.Drawing.PointF($diagRect.Right, $diagRect.Bottom)), [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"), [System.Drawing.ColorTranslator]::FromHtml("#F1F5F9"))), (Get-RoundPath $diagRect 28))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $diagRect 28))
    $g.DrawString("Olfactory Diagnostic", (New-Object System.Drawing.Font("Georgia", 19, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($diagRect.X + 28), ($diagY + 28))
    $g.DrawString("Find your tailored signature fragrance in 30 seconds.", (New-Object System.Drawing.Font("Segoe UI", 13)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($diagRect.X + 28), ($diagY + 64))
    
    $diagBtn = New-Object System.Drawing.RectangleF(($diagRect.Right - 180), ($diagY + 30), 150, 56)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $diagBtn 28))
    $g.DrawString("Start Quiz →", (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($diagBtn.X + 75), ($diagBtn.Y + 17), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    # 4 Product Cards Grid (2x2)
    $gridY = $diagY + 146
    $cardW = ($screen.Width - 96) / 2.0
    $cardH = 590
    $prods = @(
        @{ Name = "Ocean Breeze"; Spec = "Extrait de Parfum"; Price = "GH₵129.00"; Img = $assets.OceanBreeze },
        @{ Name = "Velvet Bloom"; Spec = "Pétale Sublime"; Price = "GH₵139.00"; Img = $assets.VelvetBloom },
        @{ Name = "The Art of Fragrance"; Spec = "Grand Cru Extrait"; Price = "GH₵165.00"; Img = $assets.HeroBottle },
        @{ Name = "Obsidian Noir"; Spec = "Extrait de Nuit"; Price = "GH₵149.00"; Img = $assets.ObsidianNoir }
    )

    for ($idx = 0; $idx -lt 4; $idx++) {
        $col = $idx % 2
        $row = [Math]::Floor($idx / 2.0)
        $cx = ($screen.X + 36) + ($col * ($cardW + 24))
        $cy = $gridY + ($row * ($cardH + 24))

        $cRect = New-Object System.Drawing.RectangleF($cx, $cy, $cardW, $cardH)
        $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $cRect 30))
        $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $cRect 30))
        $g.DrawImage($prods[$idx].Img, ($cx + 40), ($cy + 36), ($cardW - 80), 290)
        $g.DrawString($prods[$idx].Name, (New-Object System.Drawing.Font("Georgia", 19, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($cx + 24), ($cy + 355))
        $g.DrawString($prods[$idx].Spec, (New-Object System.Drawing.Font("Segoe UI", 13)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($cx + 24), ($cy + 395))
        $g.DrawString($prods[$idx].Price, (New-Object System.Drawing.Font("Segoe UI", 21, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($cx + 24), ($cy + 430))
        
        $addBtn = New-Object System.Drawing.RectangleF(($cx + 24), ($cy + 490), ($cardW - 48), 56)
        $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $addBtn 28))
        $g.DrawString("Add to Bag", (New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($addBtn.X + $addBtn.Width/2.0), ($addBtn.Y + 16), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
    }

    Draw-BottomCapsuleDock $g $screen "Shop"

    Save-ScreenshotDual $bmp "02-collection.png"
    $g.Dispose(); $bmp.Dispose()
}

# ==============================================================================
# SCREEN 03 — SEARCH
# ==============================================================================
function Build-Screen03 {
    Write-Host "`n>>> Generating Screen 03: Search..."
    $bmp = New-Object System.Drawing.Bitmap(1320, 2868)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    Draw-BaseCanvas $g "MARITY TRADE • FINE FRAGRANCES" "FIND YOUR FRAGRANCE" "Instant live discovery by olfactory family, floral chord, or note."
    $screen = Draw-iPhoneFrame $g
    Draw-DynamicIslandAndStatus $g $screen
    Draw-AppHeaderBar $g $screen

    # Background shop grid (subtly dim)
    $g.FillRectangle((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(120, 15, 23, 42))), $screen.X, ($screen.Y + 170), $screen.Width, ($screen.Height - 170))

    # Search Overlay Sheet
    $sheetY = $screen.Y + 160
    $sheetH = $screen.Height - 200
    $sheetRect = New-Object System.Drawing.RectangleF($screen.X, $sheetY, $screen.Width, $sheetH)
    $sheetPath = Get-RoundPath $sheetRect 48
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), $sheetPath)

    # Handle pill
    $handleRect = New-Object System.Drawing.RectangleF(($screen.X + $screen.Width/2.0 - 50), ($sheetY + 20), 100, 10)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"))), (Get-RoundPath $handleRect 5))

    # Search Header Row with Input & Dedicated Cancel X Button
    $shY = $sheetY + 60
    $inputRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $shY, ($screen.Width - 170), 80)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F1F5F9"))), (Get-RoundPath $inputRect 24))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 2)), (Get-RoundPath $inputRect 24))
    $g.DrawString("⌕", (New-Object System.Drawing.Font("Segoe UI", 26)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))), ($inputRect.X + 24), ($shY + 18))
    $g.DrawString("Sea Salt", (New-Object System.Drawing.Font("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($inputRect.X + 80), ($shY + 24))

    # Dedicated Circular Cancel X Button (Never covering text)
    $xBtnRect = New-Object System.Drawing.RectangleF(($screen.Right - 106), $shY, 70, 70)
    $xPath = Get-RoundPath $xBtnRect 35
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), $xPath)
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 2.5)), $xPath)
    $g.DrawString("✕", (New-Object System.Drawing.Font("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($xBtnRect.X + 18), ($xBtnRect.Y + 16))

    # Quick Search Tags
    $tagY = $shY + 110
    $qTags = @('Ocean Breeze', 'Velvet Bloom', 'Amber', 'Oud', 'Rose', 'Extrait')
    $tx = $screen.X + 36
    foreach ($qt in $qTags) {
        $tw = 135
        if ($qt.Length -gt 8) { $tw = 180 }
        $tRect = New-Object System.Drawing.RectangleF($tx, $tagY, $tw, 52)
        $tPath = Get-RoundPath $tRect 26
        if ($qt -eq 'Ocean Breeze') {
            $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), $tPath)
            $g.DrawString($qt, (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($tx + $tw/2.0), ($tagY + 16), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
        } else {
            $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), $tPath)
            $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 1.8)), $tPath)
            $g.DrawString($qt, (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#475569"))), ($tx + $tw/2.0), ($tagY + 16), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
        }
        $tx += $tw + 14
    }

    # Live Search Results Count
    $resHeaderY = $tagY + 84
    $g.DrawString("Matching Signatures (3)", (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#94A3B8"))), ($screen.X + 36), $resHeaderY)

    # 3 Search Results Rows
    $resY = $resHeaderY + 44
    $results = @(
        @{ Name = "Ocean Breeze"; Note = "Calabrian Bergamot • Sea Salt • Ambergris"; Price = "GH₵129.00"; Img = $assets.OceanBreeze },
        @{ Name = "Soleil d'Or"; Note = "Mediterranean Neroli • Solar Amber"; Price = "GH₵155.00"; Img = $assets.SoleilDor },
        @{ Name = "The Art of Fragrance"; Note = "Smoked Oakmoss • French Lavender"; Price = "GH₵165.00"; Img = $assets.HeroBottle }
    )

    foreach ($r in $results) {
        $rowRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $resY, ($screen.Width - 72), 170)
        $rPath = Get-RoundPath $rowRect 28
        $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), $rPath)
        $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), $rPath)
        
        $g.DrawImage($r.Img, ($rowRect.X + 24), ($resY + 15), 140, 140)
        $g.DrawString($r.Name, (New-Object System.Drawing.Font("Georgia", 22, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($rowRect.X + 180), ($resY + 36))
        $g.DrawString($r.Note, (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($rowRect.X + 180), ($resY + 80))
        $g.DrawString($r.Price, (New-Object System.Drawing.Font("Segoe UI", 21, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($rowRect.X + 180), ($resY + 112))
        
        # Arrow pill
        $arrBtn = New-Object System.Drawing.RectangleF(($rowRect.Right - 80), ($resY + 55), 56, 56)
        $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), (Get-RoundPath $arrBtn 28))
        $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 1.8)), (Get-RoundPath $arrBtn 28))
        $g.DrawString("→", (New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($arrBtn.X + 16), ($arrBtn.Y + 12))

        $resY += 194
    }

    Draw-BottomCapsuleDock $g $screen "Shop"

    Save-ScreenshotDual $bmp "03-search.png"
    $g.Dispose(); $bmp.Dispose()
}

# ==============================================================================
# SCREEN 04 — PRODUCT DETAILS
# ==============================================================================
function Build-Screen04 {
    Write-Host "`n>>> Generating Screen 04: Product Details..."
    $bmp = New-Object System.Drawing.Bitmap(1320, 2868)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    Draw-BaseCanvas $g "MARITY TRADE • FINE FRAGRANCES" "EVERY DETAIL MATTERS" "Complete olfactory pyramids, longevity ratings & custom gold cap engraving."
    $screen = Draw-iPhoneFrame $g
    Draw-DynamicIslandAndStatus $g $screen

    # Modal Sheet
    $sheetY = $screen.Y + 130
    $sheetRect = New-Object System.Drawing.RectangleF($screen.X, $sheetY, $screen.Width, ($screen.Height - 130))
    $sheetPath = Get-RoundPath $sheetRect 48
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), $sheetPath)

    # Handle pill
    $handleRect = New-Object System.Drawing.RectangleF(($screen.X + $screen.Width/2.0 - 50), ($sheetY + 20), 100, 10)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"))), (Get-RoundPath $handleRect 5))

    # Dedicated Modal Header Bar with Title & Cancel Button
    $mhY = $sheetY + 50
    $g.DrawString("MARITY TRADE", (New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))), ($screen.X + 36), $mhY)
    $g.DrawString("Ocean Breeze", (New-Object System.Drawing.Font("Georgia", 26, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($screen.X + 36), ($mhY + 24))

    # Dedicated Circular Cancel X Button (Right aligned, never covering text)
    $xBtn = New-Object System.Drawing.RectangleF(($screen.Right - 106), $mhY, 70, 70)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), (Get-RoundPath $xBtn 35))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 2.5)), (Get-RoundPath $xBtn 35))
    $g.DrawString("✕", (New-Object System.Drawing.Font("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($xBtn.X + 18), ($xBtn.Y + 16))

    # High-Res Gallery Stage with Bottle & Cap Engraving
    $galY = $mhY + 110
    $galRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $galY, ($screen.Width - 72), 620)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $galRect 36))
    $g.DrawImage($assets.OceanBreeze, ($screen.X + $screen.Width/2.0 - 240), ($galY + 30), 480, 560)
    
    # Custom Gold Engraving Preview Tag on bottle cap
    $engrPill = New-Object System.Drawing.RectangleF(($screen.X + $screen.Width/2.0 - 70), ($galY + 90), 140, 44)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#E5C378"))), (Get-RoundPath $engrPill 22))
    $g.DrawString("J.L.", (New-Object System.Drawing.Font("Georgia", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($engrPill.X + 50), ($engrPill.Y + 10))

    # Stock & Rating Row
    $metaY = $galY + 650
    $g.DrawString("● IN STOCK", (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#2E7D32"))), ($screen.X + 36), $metaY)
    $g.DrawString("★★★★★ 4.9 ★ (342 verified reviews)", (New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))), ($screen.Right - 360), $metaY)

    # Price & Delivery Row
    $priceY = $metaY + 44
    $g.DrawString("GH₵129.00", (New-Object System.Drawing.Font("Segoe UI", 34, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($screen.X + 36), $priceY)
    $g.DrawString("Delivery within 12 to 24 hours • Gift Box Included", (New-Object System.Drawing.Font("Segoe UI", 14)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($screen.X + 36), ($priceY + 54))

    # Flacon Volume Chips
    $sizeY = $priceY + 110
    $g.DrawString("SELECT FLACON VOLUME", (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#94A3B8"))), ($screen.X + 36), $sizeY)
    
    $sizes = @(
        @{ Vol = "50ml"; Price = "GH₵89"; Active = $false },
        @{ Vol = "100ml"; Price = "GH₵129"; Active = $true },
        @{ Vol = "200ml"; Price = "GH₵219"; Active = $false }
    )
    $sx = $screen.X + 36
    foreach ($s in $sizes) {
        $sRect = New-Object System.Drawing.RectangleF($sx, ($sizeY + 30), 220, 80)
        $sPath = Get-RoundPath $sRect 24
        if ($s.Active) {
            $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), $sPath)
            $g.DrawString($s.Vol, (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($sx + 110), ($sizeY + 42), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
            $g.DrawString($s.Price, (New-Object System.Drawing.Font("Segoe UI", 13)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#E5C378"))), ($sx + 110), ($sizeY + 74), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
        } else {
            $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), $sPath)
            $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 1.8)), $sPath)
            $g.DrawString($s.Vol, (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#334155"))), ($sx + 110), ($sizeY + 42), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
            $g.DrawString($s.Price, (New-Object System.Drawing.Font("Segoe UI", 13)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($sx + 110), ($sizeY + 74), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
        }
        $sx += 240
    }

    # Olfactory Pyramid Box
    $pyrY = $sizeY + 130
    $pyrRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $pyrY, ($screen.Width - 72), 220)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $pyrRect 28))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $pyrRect 28))
    $g.DrawString("Olfactory Pyramid", (New-Object System.Drawing.Font("Georgia", 18, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($pyrRect.X + 24), ($pyrY + 20))
    $g.DrawString("Head / Top: Calabrian Bergamot • Sea Salt", (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#475569"))), ($pyrRect.X + 24), ($pyrY + 68))
    $g.DrawString("Heart / Core: French Clary Sage • Maritime Accord", (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#475569"))), ($pyrRect.X + 24), ($pyrY + 112))
    $g.DrawString("Soul / Base: Gray Ambergris • White Cedar", (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#475569"))), ($pyrRect.X + 24), ($pyrY + 156))

    # Add to Bag CTA Bar
    $ctaY = $pyrY + 250
    $ctaBar = New-Object System.Drawing.RectangleF(($screen.X + 36), $ctaY, ($screen.Width - 72), 80)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $ctaBar 40))
    $g.DrawString("Add to Bag • GH₵129.00", (New-Object System.Drawing.Font("Segoe UI", 19, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($screen.X + $screen.Width/2.0), ($ctaY + 26), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    Save-ScreenshotDual $bmp "04-product-details.png"
    $g.Dispose(); $bmp.Dispose()
}

# ==============================================================================
# SCREEN 05 — WISHLIST
# ==============================================================================
function Build-Screen05 {
    Write-Host "`n>>> Generating Screen 05: Wishlist..."
    $bmp = New-Object System.Drawing.Bitmap(1320, 2868)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    Draw-BaseCanvas $g "MARITY TRADE • FINE FRAGRANCES" "SAVE YOUR FAVOURITES" "Curate your private selection of signature flacons for future acquisitions."
    $screen = Draw-iPhoneFrame $g
    Draw-DynamicIslandAndStatus $g $screen
    Draw-AppHeaderBar $g $screen

    $currY = $screen.Y + 180
    $g.DrawString("Private Wishlist", (New-Object System.Drawing.Font("Georgia", 32, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($screen.X + 36), $currY)
    $g.DrawString("Your curated selection of signature flacons.", (New-Object System.Drawing.Font("Segoe UI", 15)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($screen.X + 36), ($currY + 52))

    # Add All to Bag Pearl Button
    $allBtn = New-Object System.Drawing.RectangleF(($screen.Right - 220), ($currY + 10), 184, 56)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $allBtn 28))
    $g.DrawString("Add All to Bag", (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($allBtn.X + $allBtn.Width/2.0), ($allBtn.Y + 18), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    # Wishlist 2-Column Grid
    $gridY = $currY + 130
    $cardW = ($screen.Width - 96) / 2.0
    $cardH = 620
    $wProds = @(
        @{ Name = "The Art of Fragrance"; Spec = "Grand Cru Extrait"; Price = "GH₵165.00"; Img = $assets.HeroBottle },
        @{ Name = "Obsidian Noir"; Spec = "Extrait de Nuit"; Price = "GH₵149.00"; Img = $assets.ObsidianNoir },
        @{ Name = "Soleil d'Or"; Spec = "Solar Amber Elixir"; Price = "GH₵155.00"; Img = $assets.SoleilDor },
        @{ Name = "Velvet Bloom"; Spec = "Pétale Sublime"; Price = "GH₵139.00"; Img = $assets.VelvetBloom }
    )

    for ($idx = 0; $idx -lt 4; $idx++) {
        $col = $idx % 2
        $row = [Math]::Floor($idx / 2.0)
        $cx = ($screen.X + 36) + ($col * ($cardW + 24))
        $cy = $gridY + ($row * ($cardH + 24))

        $cRect = New-Object System.Drawing.RectangleF($cx, $cy, $cardW, $cardH)
        $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $cRect 30))
        $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $cRect 30))
        
        # Active gold heart button
        $heartBtn = New-Object System.Drawing.RectangleF(($cRect.Right - 66), ($cy + 20), 46, 46)
        $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FDF8ED"))), (Get-RoundPath $heartBtn 23))
        $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E5C378"), 1.8)), (Get-RoundPath $heartBtn 23))
        $g.DrawString("♥", (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))), ($heartBtn.X + 11), ($heartBtn.Y + 9))

        $g.DrawImage($wProds[$idx].Img, ($cx + 40), ($cy + 36), ($cardW - 80), 290)
        $g.DrawString($wProds[$idx].Name, (New-Object System.Drawing.Font("Georgia", 19, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($cx + 24), ($cy + 355))
        $g.DrawString($wProds[$idx].Spec, (New-Object System.Drawing.Font("Segoe UI", 13)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($cx + 24), ($cy + 395))
        $g.DrawString($wProds[$idx].Price, (New-Object System.Drawing.Font("Segoe UI", 21, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($cx + 24), ($cy + 430))
        
        $addBtn = New-Object System.Drawing.RectangleF(($cx + 24), ($cy + 490), ($cardW - 48), 56)
        $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $addBtn 28))
        $g.DrawString("Add to Bag", (New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($addBtn.X + $addBtn.Width/2.0), ($addBtn.Y + 16), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
    }

    Draw-BottomCapsuleDock $g $screen "Shop"

    Save-ScreenshotDual $bmp "05-wishlist.png"
    $g.Dispose(); $bmp.Dispose()
}

# ==============================================================================
# SCREEN 06 — SHOPPING CART
# ==============================================================================
function Build-Screen06 {
    Write-Host "`n>>> Generating Screen 06: Shopping Cart..."
    $bmp = New-Object System.Drawing.Bitmap(1320, 2868)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    Draw-BaseCanvas $g "MARITY TRADE • FINE FRAGRANCES" "YOUR SHOPPING BAG" "Review your curated flacons, custom engravings, and express delivery status."
    $screen = Draw-iPhoneFrame $g
    Draw-DynamicIslandAndStatus $g $screen

    # Modal Sheet
    $sheetY = $screen.Y + 130
    $sheetRect = New-Object System.Drawing.RectangleF($screen.X, $sheetY, $screen.Width, ($screen.Height - 130))
    $sheetPath = Get-RoundPath $sheetRect 48
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), $sheetPath)

    # Handle pill
    $handleRect = New-Object System.Drawing.RectangleF(($screen.X + $screen.Width/2.0 - 50), ($sheetY + 20), 100, 10)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"))), (Get-RoundPath $handleRect 5))

    # Dedicated Header Bar
    $mhY = $sheetY + 50
    $g.DrawString("Shopping Bag", (New-Object System.Drawing.Font("Georgia", 28, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($screen.X + 36), $mhY)
    $g.DrawString("Curated Luxury Selection (2 items)", (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($screen.X + 36), ($mhY + 44))

    # Dedicated Circular Cancel X Button (Right aligned, never covering text)
    $xBtn = New-Object System.Drawing.RectangleF(($screen.Right - 106), $mhY, 70, 70)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), (Get-RoundPath $xBtn 35))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 2.5)), (Get-RoundPath $xBtn 35))
    $g.DrawString("✕", (New-Object System.Drawing.Font("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($xBtn.X + 18), ($xBtn.Y + 16))

    # Free Delivery Progress Bar (Zero "Complimentary" text)
    $progY = $mhY + 110
    $progRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $progY, ($screen.Width - 72), 90)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $progRect 24))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $progRect 24))
    $g.DrawString("Free Delivery within 12 to 24 hours Unlocked!", (New-Object System.Drawing.Font("Segoe UI", 14.5, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#2E7D32"))), ($progRect.X + 24), ($progY + 18))
    
    $trackRect = New-Object System.Drawing.RectangleF(($progRect.X + 24), ($progY + 54), ($progRect.Width - 48), 12)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"))), (Get-RoundPath $trackRect 6))
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#E5C378"))), (Get-RoundPath $trackRect 6))

    # Cart Item 1: Ocean Breeze
    $ci1Y = $progY + 120
    $ci1Rect = New-Object System.Drawing.RectangleF(($screen.X + 36), $ci1Y, ($screen.Width - 72), 190)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $ci1Rect 28))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $ci1Rect 28))
    $g.DrawImage($assets.OceanBreeze, ($ci1Rect.X + 20), ($ci1Y + 15), 150, 160)
    $g.DrawString("Ocean Breeze", (New-Object System.Drawing.Font("Georgia", 22, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($ci1Rect.X + 180), ($ci1Y + 30))
    $g.DrawString("100ml • Custom Engraved: 'J.L.'", (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($ci1Rect.X + 180), ($ci1Y + 70))
    $g.DrawString("GH₵129.00", (New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($ci1Rect.X + 180), ($ci1Y + 110))
    
    # Qty stepper
    $qStep = New-Object System.Drawing.RectangleF(($ci1Rect.Right - 150), ($ci1Y + 104), 120, 50)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), (Get-RoundPath $qStep 25))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 1.8)), (Get-RoundPath $qStep 25))
    $g.DrawString("-  1  +", (New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($qStep.X + 60), ($qStep.Y + 12), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    # Cart Item 2: Velvet Bloom
    $ci2Y = $ci1Y + 214
    $ci2Rect = New-Object System.Drawing.RectangleF(($screen.X + 36), $ci2Y, ($screen.Width - 72), 190)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $ci2Rect 28))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $ci2Rect 28))
    $g.DrawImage($assets.VelvetBloom, ($ci2Rect.X + 20), ($ci2Y + 15), 150, 160)
    $g.DrawString("Velvet Bloom", (New-Object System.Drawing.Font("Georgia", 22, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($ci2Rect.X + 180), ($ci2Y + 30))
    $g.DrawString("100ml • Extrait Dilution", (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($ci2Rect.X + 180), ($ci2Y + 70))
    $g.DrawString("GH₵139.00", (New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($ci2Rect.X + 180), ($ci2Y + 110))
    
    $qStep2 = New-Object System.Drawing.RectangleF(($ci2Rect.Right - 150), ($ci2Y + 104), 120, 50)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), (Get-RoundPath $qStep2 25))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 1.8)), (Get-RoundPath $qStep2 25))
    $g.DrawString("-  1  +", (New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($qStep2.X + 60), ($qStep2.Y + 12), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    # Summary Calculations Box
    $sumY = $ci2Y + 220
    $sumRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $sumY, ($screen.Width - 72), 260)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $sumRect 28))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $sumRect 28))
    
    $g.DrawString("Subtotal", (New-Object System.Drawing.Font("Segoe UI", 14.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($sumRect.X + 24), ($sumY + 24))
    $g.DrawString("GH₵268.00", (New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($sumRect.Right - 130), ($sumY + 24))
    
    $g.DrawString("Privilège Discount", (New-Object System.Drawing.Font("Segoe UI", 14.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($sumRect.X + 24), ($sumY + 68))
    $g.DrawString("-GH₵26.80", (New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#2E7D32"))), ($sumRect.Right - 130), ($sumY + 68))

    $g.DrawString("Express Delivery (12-24h)", (New-Object System.Drawing.Font("Segoe UI", 14.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($sumRect.X + 24), ($sumY + 112))
    $g.DrawString("Free", (New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#2E7D32"))), ($sumRect.Right - 80), ($sumY + 112))

    $g.DrawString("Estimated Total", (New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($sumRect.X + 24), ($sumY + 180))
    $g.DrawString("GH₵260.50", (New-Object System.Drawing.Font("Segoe UI", 26, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($sumRect.Right - 180), ($sumY + 172))

    # Proceed to Checkout CTA Bar
    $chkY = $sumY + 290
    $chkBar = New-Object System.Drawing.RectangleF(($screen.X + 36), $chkY, ($screen.Width - 72), 80)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $chkBar 40))
    $g.DrawString("Proceed to Checkout →", (New-Object System.Drawing.Font("Segoe UI", 19, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($screen.X + $screen.Width/2.0), ($chkY + 26), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    Save-ScreenshotDual $bmp "06-shopping-cart.png"
    $g.Dispose(); $bmp.Dispose()
}

# ==============================================================================
# SCREEN 07 — CHECKOUT
# ==============================================================================
function Build-Screen07 {
    Write-Host "`n>>> Generating Screen 07: Checkout..."
    $bmp = New-Object System.Drawing.Bitmap(1320, 2868)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    Draw-BaseCanvas $g "MARITY TRADE • FINE FRAGRANCES" "CHECKOUT WITH EASE" "White Glove Express delivery dispatched within 12 to 24 hours."
    $screen = Draw-iPhoneFrame $g
    Draw-DynamicIslandAndStatus $g $screen

    # Modal Sheet
    $sheetY = $screen.Y + 130
    $sheetRect = New-Object System.Drawing.RectangleF($screen.X, $sheetY, $screen.Width, ($screen.Height - 130))
    $sheetPath = Get-RoundPath $sheetRect 48
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), $sheetPath)

    # Handle pill
    $handleRect = New-Object System.Drawing.RectangleF(($screen.X + $screen.Width/2.0 - 50), ($sheetY + 20), 100, 10)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"))), (Get-RoundPath $handleRect 5))

    # Dedicated Header Bar
    $mhY = $sheetY + 50
    $g.DrawString("Checkout", (New-Object System.Drawing.Font("Georgia", 28, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($screen.X + 36), $mhY)
    $g.DrawString("White Glove Settlement • Luxury Delivery", (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($screen.X + 36), ($mhY + 44))

    # Dedicated Circular Cancel X Button (Right aligned, never covering text)
    $xBtn = New-Object System.Drawing.RectangleF(($screen.Right - 106), $mhY, 70, 70)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), (Get-RoundPath $xBtn 35))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 2.5)), (Get-RoundPath $xBtn 35))
    $g.DrawString("✕", (New-Object System.Drawing.Font("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($xBtn.X + 18), ($xBtn.Y + 16))

    # Step Indicators Nav Bar
    $navY = $mhY + 110
    $steps = @("1. Address", "2. Delivery", "3. Payment", "4. Receipt")
    $sw = ($screen.Width - 72) / 4.0
    for ($i = 0; $i -lt 4; $i++) {
        $sx = ($screen.X + 36) + ($i * $sw)
        $isAct = ($i -eq 2)
        $sColor = if ($isAct) { "#11151F" } else { "#94A3B8" }
        $sWeight = if ($isAct) { [System.Drawing.FontStyle]::Bold } else { [System.Drawing.FontStyle]::Regular }
        $g.DrawString($steps[$i], (New-Object System.Drawing.Font("Segoe UI", 13.5, $sWeight)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml($sColor))), ($sx + $sw/2.0), $navY, (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
    }

    # Destination Address Card
    $destY = $navY + 50
    $destRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $destY, ($screen.Width - 72), 160)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $destRect 28))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $destRect 28))
    $g.DrawString("DELIVERY DESTINATION", (New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))), ($destRect.X + 24), ($destY + 20))
    $g.DrawString("Alexandre Laurent • 14 Place Vendôme, Accra, Ghana", (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($destRect.X + 24), ($destY + 54))
    $g.DrawString("White Glove Dispatch • Delivery within 12 to 24 hours", (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($destRect.X + 24), ($destY + 96))

    # Payment Options Section
    $payY = $destY + 190
    $g.DrawString("SECURE SETTLEMENT", (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#94A3B8"))), ($screen.X + 36), $payY)

    # 1-Tap Apple Pay / Mobile Money Box
    $apY = $payY + 30
    $apRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $apY, ($screen.Width - 72), 120)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#000000"))), (Get-RoundPath $apRect 28))
    $g.DrawString("Pay • Mobile Money", (New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($screen.X + $screen.Width/2.0), ($apY + 26), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
    $g.DrawString("One-tap biometric instant settlement", (New-Object System.Drawing.Font("Segoe UI", 13)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#94A3B8"))), ($screen.X + $screen.Width/2.0), ($apY + 70), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    # Client Card Details Form
    $cardFormY = $apY + 150
    $cfRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $cardFormY, ($screen.Width - 72), 310)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $cfRect 28))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $cfRect 28))
    
    $g.DrawString("CLIENT CARD PAYMENT", (New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))), ($cfRect.X + 24), ($cardFormY + 24))
    $g.DrawString("Cardholder: Alexandre Laurent", (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($cfRect.X + 24), ($cardFormY + 68))
    $g.DrawString("Card: •••• •••• •••• 8492", (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($cfRect.X + 24), ($cardFormY + 120))
    $g.DrawString("Expiry: 11/28        CVC: •••", (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($cfRect.X + 24), ($cardFormY + 172))
    $g.DrawString("256-Bit SSL Encrypted & Verified Atelier Gateway", (New-Object System.Drawing.Font("Segoe UI", 13)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($cfRect.X + 24), ($cardFormY + 236))

    # Authorize Button
    $authY = $cardFormY + 340
    $authBar = New-Object System.Drawing.RectangleF(($screen.X + 36), $authY, ($screen.Width - 72), 80)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $authBar 40))
    $g.DrawString("Authorize Payment • GH₵260.50", (New-Object System.Drawing.Font("Segoe UI", 19, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($screen.X + $screen.Width/2.0), ($authY + 26), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    Save-ScreenshotDual $bmp "07-checkout.png"
    $g.Dispose(); $bmp.Dispose()
}

# ==============================================================================
# SCREEN 08 — ORDER CONFIRMATION
# ==============================================================================
function Build-Screen08 {
    Write-Host "`n>>> Generating Screen 08: Order Confirmation..."
    $bmp = New-Object System.Drawing.Bitmap(1320, 2868)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    Draw-BaseCanvas $g "MARITY TRADE • FINE FRAGRANCES" "YOUR ORDER, CONFIRMED" "Hand-poured at the atelier, inspected, sealed, and ready for dispatch."
    $screen = Draw-iPhoneFrame $g
    Draw-DynamicIslandAndStatus $g $screen

    # Modal Sheet
    $sheetY = $screen.Y + 130
    $sheetRect = New-Object System.Drawing.RectangleF($screen.X, $sheetY, $screen.Width, ($screen.Height - 130))
    $sheetPath = Get-RoundPath $sheetRect 48
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), $sheetPath)

    # Handle pill
    $handleRect = New-Object System.Drawing.RectangleF(($screen.X + $screen.Width/2.0 - 50), ($sheetY + 20), 100, 10)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"))), (Get-RoundPath $handleRect 5))

    # Dedicated Header Bar
    $mhY = $sheetY + 50
    $g.DrawString("Order Confirmation", (New-Object System.Drawing.Font("Georgia", 28, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($screen.X + 36), $mhY)
    $g.DrawString("Atelier Registration & White Glove Receipt", (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($screen.X + 36), ($mhY + 44))

    # Dedicated Circular Cancel X Button (Right aligned, never covering text)
    $xBtn = New-Object System.Drawing.RectangleF(($screen.Right - 106), $mhY, 70, 70)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), (Get-RoundPath $xBtn 35))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 2.5)), (Get-RoundPath $xBtn 35))
    $g.DrawString("✕", (New-Object System.Drawing.Font("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($xBtn.X + 18), ($xBtn.Y + 16))

    # Gold Circular Checkmark Emblem
    $checkY = $mhY + 120
    $checkCircle = New-Object System.Drawing.RectangleF(($screen.X + $screen.Width/2.0 - 60), $checkY, 120, 120)
    $g.FillPath((New-Object System.Drawing.Drawing2D.LinearGradientBrush((New-Object System.Drawing.PointF($checkCircle.X, $checkCircle.Y)), (New-Object System.Drawing.PointF($checkCircle.Right, $checkCircle.Bottom)), [System.Drawing.ColorTranslator]::FromHtml("#F9E7B3"), [System.Drawing.ColorTranslator]::FromHtml("#CFA348"))), (Get-RoundPath $checkCircle 60))
    $g.DrawString("✓", (New-Object System.Drawing.Font("Segoe UI", 48, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($checkCircle.X + 32), ($checkCircle.Y + 20))

    $g.DrawString("Grand Flacon Confirmed", (New-Object System.Drawing.Font("Georgia", 32, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($screen.X + $screen.Width/2.0), ($checkY + 150), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))
    $g.DrawString("Your bespoke order has been registered at our atelier.", (New-Object System.Drawing.Font("Segoe UI", 16)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($screen.X + $screen.Width/2.0), ($checkY + 205), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    # Order Receipt Card
    $recY = $checkY + 260
    $recRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $recY, ($screen.Width - 72), 380)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $recRect 28))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $recRect 28))
    
    $g.DrawString("Order Reference:", (New-Object System.Drawing.Font("Segoe UI", 15)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($recRect.X + 24), ($recY + 30))
    $g.DrawString("#MR-2026-9482", (New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($recRect.Right - 220), ($recY + 26))

    $g.DrawString("Estimated Delivery:", (New-Object System.Drawing.Font("Segoe UI", 15)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($recRect.X + 24), ($recY + 84))
    $g.DrawString("Delivery within 12 to 24 hours", (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#2E7D32"))), ($recRect.Right - 340), ($recY + 80))

    $g.DrawString("Carrier:", (New-Object System.Drawing.Font("Segoe UI", 15)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($recRect.X + 24), ($recY + 138))
    $g.DrawString("DHL Express Worldwide", (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($recRect.Right - 260), ($recY + 134))

    $g.DrawString("Payment Method:", (New-Object System.Drawing.Font("Segoe UI", 15)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($recRect.X + 24), ($recY + 192))
    $g.DrawString("Pay (Biometric Verified)", (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($recRect.Right - 270), ($recY + 188))

    $g.DrawString("Settlement Amount:", (New-Object System.Drawing.Font("Segoe UI", 17, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($recRect.X + 24), ($recY + 280))
    $g.DrawString("GH₵260.50", (New-Object System.Drawing.Font("Segoe UI", 26, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($recRect.Right - 200), ($recY + 270))

    # Track Dispatch CTA Bar
    $trY = $recY + 420
    $trBar = New-Object System.Drawing.RectangleF(($screen.X + 36), $trY, ($screen.Width - 72), 80)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $trBar 40))
    $g.DrawString("Track Dispatch in Delivery Concierge →", (New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($screen.X + $screen.Width/2.0), ($trY + 26), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    Save-ScreenshotDual $bmp "08-order-confirmation.png"
    $g.Dispose(); $bmp.Dispose()
}

# ==============================================================================
# SCREEN 09 — DELIVERY TRACKING
# ==============================================================================
function Build-Screen09 {
    Write-Host "`n>>> Generating Screen 09: Delivery Tracking..."
    $bmp = New-Object System.Drawing.Bitmap(1320, 2868)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    Draw-BaseCanvas $g "MARITY TRADE • FINE FRAGRANCES" "FOLLOW YOUR DELIVERY" "Real-time artisan progress from Grasse formulation to your doorstep."
    $screen = Draw-iPhoneFrame $g
    Draw-DynamicIslandAndStatus $g $screen
    Draw-AppHeaderBar $g $screen

    $currY = $screen.Y + 180
    $g.DrawString("Delivery Concierge", (New-Object System.Drawing.Font("Georgia", 32, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($screen.X + 36), $currY)
    $g.DrawString("Real-time status of your atelier shipments.", (New-Object System.Drawing.Font("Segoe UI", 15)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($screen.X + 36), ($currY + 52))

    # Verified Client Access Pill
    $vPillY = $currY + 110
    $vRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $vPillY, ($screen.Width - 72), 80)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F1F5F9"))), (Get-RoundPath $vRect 24))
    $g.DrawString("● VERIFIED CLIENT ACCESS: alexandre.laurent@parfum.fr", (New-Object System.Drawing.Font("Segoe UI", 13.5, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#2E7D32"))), ($vRect.X + 24), ($vPillY + 28))

    # Tracking Stepper Card
    $stepCardY = $vPillY + 104
    $scRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $stepCardY, ($screen.Width - 72), 880)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $scRect 32))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $scRect 32))

    # Order header row inside card
    $g.DrawString("#MR-2026-9482", (New-Object System.Drawing.Font("Georgia", 24, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($scRect.X + 30), ($stepCardY + 30))
    $g.DrawString("Nov 22, 2026 • DHL Express Priority", (New-Object System.Drawing.Font("Segoe UI", 14)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($scRect.X + 30), ($stepCardY + 70))
    
    $inTransit = New-Object System.Drawing.RectangleF(($scRect.Right - 150), ($stepCardY + 34), 120, 44)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FDF8ED"))), (Get-RoundPath $inTransit 22))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E5C378"), 1.8)), (Get-RoundPath $inTransit 22))
    $g.DrawString("In Transit", (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))), ($inTransit.X + 60), ($inTransit.Y + 12), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    # Tracking code strip
    $tStrip = New-Object System.Drawing.RectangleF(($scRect.X + 30), ($stepCardY + 120), ($scRect.Width - 60), 64)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), (Get-RoundPath $tStrip 16))
    $g.DrawString("Tracking: DHL-EXP-840291932", (New-Object System.Drawing.Font("Segoe UI", 14.5, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($tStrip.X + 20), ($tStrip.Y + 20))
    $g.DrawString("Copy", (New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))), ($tStrip.Right - 70), ($tStrip.Y + 20))

    # 4 Stepper Items
    $stY = $stepCardY + 220
    $stepsData = @(
        @{ Num = "✓"; Title = "Order Authenticated & Hand-Poured"; Desc = "Atelier in Grasse, France • Verified Formula"; Done = $true },
        @{ Num = "✓"; Title = "Custom Monogram Cap Engraving"; Desc = "Precision diamond tool gold-plate engraving 'J.L.'"; Done = $true },
        @{ Num = "✓"; Title = "White Glove QA & Wax Seal"; Desc = "Inspected for clarity, hermeticity & packaging"; Done = $true },
        @{ Num = "4"; Title = "Dispatched via Express Delivery"; Desc = "Estimated Arrival: Delivery within 12 to 24 hours"; Done = $false; Active = $true }
    )

    foreach ($sd in $stepsData) {
        $bullet = New-Object System.Drawing.RectangleF(($scRect.X + 36), $stY, 52, 52)
        if ($sd.Done) {
            $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#2E7D32"))), (Get-RoundPath $bullet 26))
            $g.DrawString($sd.Num, (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($bullet.X + 16), ($bullet.Y + 12))
        } else {
            $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $bullet 26))
            $g.DrawString($sd.Num, (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($bullet.X + 18), ($bullet.Y + 12))
        }

        $g.DrawString($sd.Title, (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($scRect.X + 106), ($stY + 4))
        $g.DrawString($sd.Desc, (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($scRect.X + 106), ($stY + 36))

        $stY += 130
    }

    # Card footer total
    $ftY = $stepCardY + 770
    $g.DrawString("Total Paid: GH₵260.50 (2 items)", (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($scRect.X + 30), $ftY)
    
    $recBtn = New-Object System.Drawing.RectangleF(($scRect.Right - 160), ($ftY - 6), 130, 48)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $recBtn 24))
    $g.DrawString("View Receipt", (New-Object System.Drawing.Font("Segoe UI", 12.5, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($recBtn.X + 65), ($recBtn.Y + 14), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    Draw-BottomCapsuleDock $g $screen "Orders"

    Save-ScreenshotDual $bmp "09-delivery-tracking.png"
    $g.Dispose(); $bmp.Dispose()
}

# ==============================================================================
# SCREEN 10 — SCENT FINDER QUIZ (OLFACTORY DIAGNOSTIC)
# ==============================================================================
function Build-Screen10 {
    Write-Host "`n>>> Generating Screen 10: Scent Finder Quiz (Olfactory Diagnostic)..."
    $bmp = New-Object System.Drawing.Bitmap(1320, 2868)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    Draw-BaseCanvas $g "MARITY TRADE • FINE FRAGRANCES" "FIND YOUR TRUE ACCORD" "Interactive olfactory diagnostic matching your lifestyle to signature scents."
    $screen = Draw-iPhoneFrame $g
    Draw-DynamicIslandAndStatus $g $screen

    # Modal Sheet
    $sheetY = $screen.Y + 130
    $sheetRect = New-Object System.Drawing.RectangleF($screen.X, $sheetY, $screen.Width, ($screen.Height - 130))
    $sheetPath = Get-RoundPath $sheetRect 48
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), $sheetPath)

    # Handle pill
    $handleRect = New-Object System.Drawing.RectangleF(($screen.X + $screen.Width/2.0 - 50), ($sheetY + 20), 100, 10)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"))), (Get-RoundPath $handleRect 5))

    # Dedicated Header Bar
    $mhY = $sheetY + 50
    $g.DrawString("Olfactory Diagnostic", (New-Object System.Drawing.Font("Georgia", 28, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($screen.X + 36), $mhY)
    $g.DrawString("Find your bespoke signature fragrance in 30 seconds.", (New-Object System.Drawing.Font("Segoe UI", 13.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($screen.X + 36), ($mhY + 44))

    # Dedicated Circular Cancel X Button (Right aligned, never covering text)
    $xBtn = New-Object System.Drawing.RectangleF(($screen.Right - 106), $mhY, 70, 70)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), (Get-RoundPath $xBtn 35))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#CBD5E1"), 2.5)), (Get-RoundPath $xBtn 35))
    $g.DrawString("✕", (New-Object System.Drawing.Font("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($xBtn.X + 18), ($xBtn.Y + 16))

    # Question 1: Desired Atmosphere
    $q1Y = $mhY + 120
    $g.DrawString("1. DESIRED ATMOSPHERE & SENSORY CHORD", (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))), ($screen.X + 36), $q1Y)

    # 4 Mood Choice Cards (2x2)
    $mY = $q1Y + 36
    $cardW = ($screen.Width - 96) / 2.0
    $cardH = 140
    $moods = @(
        @{ Title = "Oceanic Crispness"; Sub = "Sea salt, bergamot & ambergris"; Selected = $true },
        @{ Title = "Velvety Rose Petals"; Sub = "Grasse rose & warm musk"; Selected = $false },
        @{ Title = "Smoked Nighttime Oud"; Sub = "Agarwood & glove leather"; Selected = $false },
        @{ Title = "Aged Amber Royal Cru"; Sub = "Solar amber & honeyed neroli"; Selected = $false }
    )

    for ($idx = 0; $idx -lt 4; $idx++) {
        $col = $idx % 2
        $row = [Math]::Floor($idx / 2.0)
        $cx = ($screen.X + 36) + ($col * ($cardW + 24))
        $cy = $mY + ($row * ($cardH + 20))

        $mRect = New-Object System.Drawing.RectangleF($cx, $cy, $cardW, $cardH)
        if ($moods[$idx].Selected) {
            $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $mRect 24))
            $g.DrawString("● " + $moods[$idx].Title, (New-Object System.Drawing.Font("Segoe UI", 15.5, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($cx + 20), ($cy + 28))
            $g.DrawString($moods[$idx].Sub, (New-Object System.Drawing.Font("Segoe UI", 12.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#E5C378"))), ($cx + 20), ($cy + 74))
        } else {
            $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $mRect 24))
            $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $mRect 24))
            $g.DrawString("○ " + $moods[$idx].Title, (New-Object System.Drawing.Font("Segoe UI", 15.5, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($cx + 20), ($cy + 28))
            $g.DrawString($moods[$idx].Sub, (New-Object System.Drawing.Font("Segoe UI", 12.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($cx + 20), ($cy + 74))
        }
    }

    # Question 2: Wearing Occasion
    $q2Y = $mY + 340
    $g.DrawString("2. WEARING OCCASION", (New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#9A7B35"))), ($screen.X + 36), $q2Y)
    
    $occRect = New-Object System.Drawing.RectangleF(($screen.X + 36), ($q2Y + 36), ($screen.Width - 72), 90)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))), (Get-RoundPath $occRect 24))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $occRect 24))
    $g.DrawString("● Signature Daily & Business Elegance (Versatile Sillage)", (New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($occRect.X + 24), ($occRect.Y + 32))

    # Matched Diagnostic Flacon Preview Stage
    $prevY = $q2Y + 160
    $prevRect = New-Object System.Drawing.RectangleF(($screen.X + 36), $prevY, ($screen.Width - 72), 340)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#F1F5F9"))), (Get-RoundPath $prevRect 28))
    $g.DrawPath((New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)), (Get-RoundPath $prevRect 28))
    
    $g.DrawImage($assets.OceanBreeze, ($prevRect.X + 30), ($prevY + 20), 220, 300)
    $g.DrawString("ALGORITHM MATCH: 98% CHORD", (New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#2E7D32"))), ($prevRect.X + 270), ($prevY + 44))
    $g.DrawString("Ocean Breeze", (New-Object System.Drawing.Font("Georgia", 26, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($prevRect.X + 270), ($prevY + 84))
    $g.DrawString("Extrait de Parfum • 100ml Flacon", (New-Object System.Drawing.Font("Segoe UI", 14)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#64748B"))), ($prevRect.X + 270), ($prevY + 130))
    $g.DrawString("GH₵129.00", (New-Object System.Drawing.Font("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), ($prevRect.X + 270), ($prevY + 172))
    $g.DrawString("Calabrian Bergamot, Sea Salt & Gray Ambergris.", (New-Object System.Drawing.Font("Segoe UI", 12.5)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#475569"))), ($prevRect.X + 270), ($prevY + 224))

    # Action CTA Bar
    $ctaY = $prevY + 380
    $ctaBar = New-Object System.Drawing.RectangleF(($screen.X + 36), $ctaY, ($screen.Width - 72), 80)
    $g.FillPath((New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#11151F"))), (Get-RoundPath $ctaBar 40))
    $g.DrawString("Reveal Full Olfactory Chord →", (New-Object System.Drawing.Font("Segoe UI", 19, [System.Drawing.FontStyle]::Bold)), (New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))), ($screen.X + $screen.Width/2.0), ($ctaY + 26), (New-Object System.Drawing.StringFormat -Property @{Alignment = 'Center'}))

    Save-ScreenshotDual $bmp "10-shopping-feature.png"
    $g.Dispose(); $bmp.Dispose()
}

# --- EXECUTE ALL 10 BUILDS ---
Build-Screen01
Build-Screen02
Build-Screen03
Build-Screen04
Build-Screen05
Build-Screen06
Build-Screen07
Build-Screen08
Build-Screen09
Build-Screen10

# Clean up memory
foreach ($key in $assets.Keys) {
    $assets[$key].Dispose()
}

Write-Host "`n>>> All 10 Screens Successfully Rendered at Both Apple Resolutions (iPhone 6.9 & iPhone 6.3)!"
