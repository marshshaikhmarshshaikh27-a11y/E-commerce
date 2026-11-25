Add-Type -AssemblyName System.Drawing

$imgDir = "C:\Users\User\.gemini\antigravity\scratch\qadri-enterprises\assets\images"

# 1. Generate Daewoo DTT-225 Tall Tubular Battery Image
function Create-DaewooTubular {
    $w = 230; $h = 150
    $bmp = [System.Drawing.Bitmap]::new($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $g.Clear([System.Drawing.Color]::White)

    # Battery Casing (Dark grey tall case)
    $brushBody = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(45, 55, 72))
    $g.FillRectangle($brushBody, 25, 35, 180, 105)
    
    # Border
    $penBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(30, 41, 59), 2)
    $g.DrawRectangle($penBorder, 25, 35, 180, 105)

    # Top Lid (Vibrant Daewoo Yellow Lid)
    $brushLid = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(234, 179, 8))
    $g.FillRectangle($brushLid, 20, 22, 190, 18)
    $penLid = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(202, 138, 4), 2)
    $g.DrawRectangle($penLid, 20, 22, 190, 18)

    # 6 Vent Caps (Red / Black)
    $brushCap = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(220, 38, 38))
    for ($i = 0; $i -lt 6; $i++) {
        $cx = 38 + ($i * 28)
        $g.FillEllipse($brushCap, $cx, 16, 12, 12)
        $g.FillRectangle([System.Drawing.Brushes]::Black, $cx + 4, 12, 4, 6)
    }

    # Terminals (Left red, Right black)
    $g.FillRectangle([System.Drawing.Brushes]::Silver, 26, 10, 8, 12)
    $g.FillRectangle([System.Drawing.Brushes]::Silver, 196, 10, 8, 12)

    # Central Daewoo Blue Logo Plaque
    $brushPlaque = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
    $g.FillRectangle($brushPlaque, 35, 48, 160, 82)
    $g.DrawRectangle([System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(59, 130, 246), 1.5), 35, 48, 160, 82)

    # Daewoo Logo Circle
    $g.FillEllipse([System.Drawing.Brushes]::DodgerBlue, 45, 54, 20, 20)
    $g.DrawEllipse([System.Drawing.Pens]::White, 48, 57, 14, 14)

    # DAEWOO text
    $fontBrand = [System.Drawing.Font]::new("Arial", 12, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("DAEWOO", $fontBrand, [System.Drawing.Brushes]::White, 70, 54)

    $fontSub = [System.Drawing.Font]::new("Arial", 7, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("BATTERY • KOREAN TECH", $fontSub, [System.Drawing.Brushes]::SkyBlue, 70, 70)

    # Model Badge: DTT-225
    $brushModel = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(234, 179, 8))
    $g.FillRectangle($brushModel, 45, 86, 140, 22)
    $fontModel = [System.Drawing.Font]::new("Arial", 9.5, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("DTT - 225  TALL TUBULAR", $fontModel, [System.Drawing.Brushes]::Black, 48, 90)

    # Subtext
    $fontDeep = [System.Drawing.Font]::new("Arial", 7, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("DEEP CYCLE SOLAR  |  180 AH", $fontDeep, [System.Drawing.Brushes]::Silver, 45, 114)

    $g.Dispose()
    $savePath = Join-Path $imgDir "daewoo_tubular.png"
    $bmp.Save($savePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output "Saved daewoo_tubular.png"
}

# 2. Generate Daewoo Maintenance Free Dry Battery Image
function Create-DaewooDry {
    $w = 230; $h = 150
    $bmp = [System.Drawing.Bitmap]::new($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $g.Clear([System.Drawing.Color]::White)

    # Battery Casing (Sleek deep black)
    $brushBody = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(20, 24, 33))
    $g.FillRectangle($brushBody, 25, 30, 180, 110)
    $penBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(10, 15, 20), 2)
    $g.DrawRectangle($penBorder, 25, 30, 180, 110)

    # Top sealed lid (Black with flush handle)
    $brushLid = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(35, 40, 50))
    $g.FillRectangle($brushLid, 20, 20, 190, 18)
    
    # Flush Handle groove
    $g.DrawRectangle([System.Drawing.Pens]::Black, 60, 24, 110, 8)

    # Magic Eye Charge Indicator (Green glowing dot)
    $g.FillEllipse([System.Drawing.Brushes]::Black, 35, 22, 14, 14)
    $g.FillEllipse([System.Drawing.Brushes]::LimeGreen, 38, 25, 8, 8)
    $g.DrawString("MAGIC EYE", [System.Drawing.Font]::new("Arial", 5.5, [System.Drawing.FontStyle]::Bold), [System.Drawing.Brushes]::Silver, 26, 38)

    # Terminals
    $g.FillRectangle([System.Drawing.Brushes]::Silver, 185, 14, 12, 10)
    $g.FillRectangle([System.Drawing.Brushes]::Red, 185, 20, 12, 3)

    # Front Premium Label
    $brushPlaque = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(10, 15, 25))
    $g.FillRectangle($brushPlaque, 35, 45, 160, 85)
    $g.DrawRectangle([System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(0, 150, 255), 1.5), 35, 45, 160, 85)

    # Logo
    $g.FillEllipse([System.Drawing.Brushes]::DeepSkyBlue, 45, 52, 18, 18)
    $fontBrand = [System.Drawing.Font]::new("Arial", 11.5, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("DAEWOO", $fontBrand, [System.Drawing.Brushes]::White, 68, 52)

    # Dry Battery Banner
    $brushDry = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(14, 165, 233))
    $g.FillRectangle($brushDry, 45, 78, 140, 22)
    $fontDry = [System.Drawing.Font]::new("Arial", 8.5, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("MAINTENANCE FREE (DRY)", $fontDry, [System.Drawing.Brushes]::White, 48, 82)

    # Model: DLS-135
    $fontSub = [System.Drawing.Font]::new("Arial", 8, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("DLS - 135  |  100% SEALED", $fontSub, [System.Drawing.Brushes]::Yellow, 45, 105)

    $g.Dispose()
    $savePath = Join-Path $imgDir "daewoo_dry.png"
    $bmp.Save($savePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output "Saved daewoo_dry.png"
}

Create-DaewooTubular
Create-DaewooDry
