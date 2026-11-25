Add-Type -AssemblyName System.Drawing
$imgDir = "C:\Users\User\.gemini\antigravity\scratch\qadri-enterprises\assets\images"

function Create-DryBattery($name, $brand, $colorBody, $colorAccent, $outName, $model) {
    $w = 230; $h = 150
    $bmp = [System.Drawing.Bitmap]::new($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $g.Clear([System.Drawing.Color]::White)

    # Battery Casing
    $brushBody = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb($colorBody[0], $colorBody[1], $colorBody[2]))
    $g.FillRectangle($brushBody, 25, 30, 180, 110)
    $g.DrawRectangle([System.Drawing.Pen]::new([System.Drawing.Color]::Black, 2), 25, 30, 180, 110)

    # Top sealed lid
    $brushLid = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(40, 45, 55))
    $g.FillRectangle($brushLid, 20, 20, 190, 18)
    
    # Terminals
    $g.FillRectangle([System.Drawing.Brushes]::Silver, 26, 12, 10, 10)
    $g.FillRectangle([System.Drawing.Brushes]::Silver, 194, 12, 10, 10)
    $g.FillEllipse([System.Drawing.Brushes]::LimeGreen, 175, 23, 10, 10)

    # Label
    $brushPlaque = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 20, 30))
    $g.FillRectangle($brushPlaque, 35, 45, 160, 85)
    $penAccent = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb($colorAccent[0], $colorAccent[1], $colorAccent[2]), 2)
    $g.DrawRectangle($penAccent, 35, 45, 160, 85)

    $fontBrand = [System.Drawing.Font]::new("Arial", 12, [System.Drawing.FontStyle]::Bold)
    $g.DrawString($brand, $fontBrand, [System.Drawing.Brushes]::White, 45, 52)

    # Dry banner
    $brushDry = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb($colorAccent[0], $colorAccent[1], $colorAccent[2]))
    $g.FillRectangle($brushDry, 45, 76, 140, 22)
    $fontDry = [System.Drawing.Font]::new("Arial", 8, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("MAINTENANCE FREE (DRY)", $fontDry, [System.Drawing.Brushes]::White, 48, 80)

    $fontSub = [System.Drawing.Font]::new("Arial", 8, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("$model | ZERO MAINTENANCE", $fontSub, [System.Drawing.Brushes]::Silver, 45, 105)

    $g.Dispose()
    $savePath = Join-Path $imgDir $outName
    $bmp.Save($savePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output "Saved $outName"
}

Create-DryBattery "Phoenix Lead Carbon" "PHOENIX" @(25, 30, 45) @(220, 38, 38) "phoenix_dry.png" "PLC - 200 LEAD CARBON"
Create-DryBattery "Osaka Platinum Dry" "OSAKA" @(30, 40, 50) @(2, 132, 199) "osaka_dry.png" "PLATINUM MF - 125"
