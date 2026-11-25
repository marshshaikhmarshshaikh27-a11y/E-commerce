Add-Type -AssemblyName System.Drawing
$imgDir = "C:\Users\User\.gemini\antigravity\scratch\qadri-enterprises\assets\images"

# High-Res Sharp Image Generator Helper
function Draw-SharpProduct($filename, $title, $brand, $type, $ah, $theme) {
    $w = 400; $h = 260
    $bmp = [System.Drawing.Bitmap]::new($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $g.Clear([System.Drawing.Color]::White)

    # Soft radial background glow
    $brushGlow = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(248, 250, 252))
    $g.FillRectangle($brushGlow, 0, 0, $w, $h)

    if ($type -eq "Inverter") {
        # Sleek Modern Wall Inverter Graphic
        $bodyBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 255, 255))
        $g.FillRectangle($bodyBrush, 90, 25, 220, 210)
        $g.DrawRectangle([System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(203, 213, 225), 2), 90, 25, 220, 210)

        # Inverter Top Curved Vent
        $g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 41, 59)), 100, 35, 200, 15)

        # LCD Display Screen (Glossy Dark)
        $g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)), 130, 65, 140, 95)
        $g.DrawRectangle([System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(56, 189, 248), 2), 130, 65, 140, 95)

        # Digital Screen Readings
        $fontScr = [System.Drawing.Font]::new("Consolas", 11, [System.Drawing.FontStyle]::Bold)
        $g.DrawString("OUTPUT: 230V", $fontScr, [System.Drawing.Brushes]::Cyan, 138, 75)
        $g.DrawString("SOLAR:  4.8KW", $fontScr, [System.Drawing.Brushes]::LimeGreen, 138, 95)
        $g.DrawString("BATT:   100%", $fontScr, [System.Drawing.Brushes]::Yellow, 138, 115)
        $g.DrawString("STATUS: NORMAL", [System.Drawing.Font]::new("Consolas", 8, [System.Drawing.FontStyle]::Bold), [System.Drawing.Brushes]::White, 145, 138)

        # Brand Logo on Inverter
        $fontB = [System.Drawing.Font]::new("Arial", 13, [System.Drawing.FontStyle]::Bold)
        $g.DrawString($brand, $fontB, [System.Drawing.Brushes]::Black, 145, 172)

        $fontT = [System.Drawing.Font]::new("Arial", 9, [System.Drawing.FontStyle]::Bold)
        $g.DrawString($title, $fontT, [System.Drawing.Brushes]::DarkBlue, 110, 195)
        $g.DrawString("SMART MPPT HYBRID SOLAR", [System.Drawing.Font]::new("Arial", 7.5, [System.Drawing.FontStyle]::Bold), [System.Drawing.Brushes]::SlateGray, 120, 212)
    }
    elseif ($type -eq "Dry") {
        # Sealed Dry Battery (Black casing with handle and magic eye)
        $g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(24, 28, 38)), 50, 45, 300, 180)
        $g.DrawRectangle([System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(15, 23, 42), 2), 50, 45, 300, 180)

        # Top Lid
        $g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(38, 45, 60)), 40, 30, 320, 25)
        $g.DrawRectangle([System.Drawing.Pen]::new([System.Drawing.Color]::Black, 1.5), 40, 30, 320, 25)

        # Flush Handle
        $g.DrawRectangle([System.Drawing.Pen]::new([System.Drawing.Color]::Silver, 2), 110, 36, 180, 10)

        # Terminals (Left Red, Right Black)
        $g.FillRectangle([System.Drawing.Brushes]::Silver, 55, 18, 20, 16)
        $g.FillRectangle([System.Drawing.Brushes]::Red, 55, 28, 20, 4)
        $g.FillRectangle([System.Drawing.Brushes]::Silver, 325, 18, 20, 16)

        # Magic Eye Indicator (Glowing Green Circle)
        $g.FillEllipse([System.Drawing.Brushes]::Black, 95, 32, 16, 16)
        $g.FillEllipse([System.Drawing.Brushes]::LimeGreen, 98, 35, 10, 10)
        $g.DrawString("MAGIC EYE", [System.Drawing.Font]::new("Arial", 7, [System.Drawing.FontStyle]::Bold), [System.Drawing.Brushes]::LimeGreen, 82, 50)

        # Main Label Plaque
        $g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(10, 15, 25)), 65, 75, 270, 130)
        $accentColor = [System.Drawing.Color]::FromArgb(14, 165, 233)
        if ($theme -eq "red") { $accentColor = [System.Drawing.Color]::FromArgb(239, 68, 68) }
        elseif ($theme -eq "gold") { $accentColor = [System.Drawing.Color]::FromArgb(234, 179, 8) }
        $g.DrawRectangle([System.Drawing.Pen]::new($accentColor, 2), 65, 75, 270, 130)

        # Brand Text
        $fontB = [System.Drawing.Font]::new("Arial", 16, [System.Drawing.FontStyle]::Bold)
        $g.DrawString($brand, $fontB, [System.Drawing.Brushes]::White, 80, 85)

        # Model / Series Badge
        $g.FillRectangle([System.Drawing.SolidBrush]::new($accentColor), 80, 120, 240, 32)
        $fontM = [System.Drawing.Font]::new("Arial", 12, [System.Drawing.FontStyle]::Bold)
        $g.DrawString("MAINTENANCE FREE (DRY)", $fontM, [System.Drawing.Brushes]::White, 85, 126)

        $fontCap = [System.Drawing.Font]::new("Arial", 12, [System.Drawing.FontStyle]::Bold)
        $g.DrawString("$title  •  $ah", $fontCap, [System.Drawing.Brushes]::Yellow, 80, 162)

        $fontFt = [System.Drawing.Font]::new("Arial", 8, [System.Drawing.FontStyle]::Bold)
        $g.DrawString("100% SEALED  |  ZERO ACID FUMES  |  READY TO USE", $fontFt, [System.Drawing.Brushes]::Silver, 80, 185)
    }
    else {
        # Tall Tubular Battery
        $g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(245, 247, 250)), 50, 50, 300, 180)
        $g.DrawRectangle([System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(30, 41, 59), 2), 50, 50, 300, 180)

        # Top Lid with Vent Caps
        $lidColor = [System.Drawing.Color]::FromArgb(220, 38, 38)
        if ($theme -eq "blue") { $lidColor = [System.Drawing.Color]::FromArgb(37, 99, 235) }
        elseif ($theme -eq "yellow") { $lidColor = [System.Drawing.Color]::FromArgb(234, 179, 8) }
        $g.FillRectangle([System.Drawing.SolidBrush]::new($lidColor), 40, 30, 320, 25)

        # 6 Vent Caps
        for ($i = 0; $i -lt 6; $i++) {
            $cx = 65 + ($i * 48)
            $g.FillEllipse([System.Drawing.Brushes]::White, $cx, 22, 16, 16)
            $g.FillRectangle([System.Drawing.Brushes]::Red, $cx + 5, 16, 6, 8)
        }

        # Plaque
        $g.FillRectangle([System.Drawing.Brushes]::White, 65, 75, 270, 135)
        $g.DrawRectangle([System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(226, 232, 240), 2), 65, 75, 270, 135)

        # Brand Text
        $fontB = [System.Drawing.Font]::new("Arial", 18, [System.Drawing.FontStyle]::Bold)
        $brandColor = [System.Drawing.Brushes]::DarkBlue
        if ($brand -eq "EXIDE") { $brandColor = [System.Drawing.Brushes]::Red }
        $g.DrawString($brand, $fontB, $brandColor, 80, 85)

        # Tubular Badge
        $g.FillRectangle([System.Drawing.SolidBrush]::new($lidColor), 80, 122, 240, 32)
        $fontM = [System.Drawing.Font]::new("Arial", 11.5, [System.Drawing.FontStyle]::Bold)
        $g.DrawString("DEEP CYCLE TALL TUBULAR", $fontM, [System.Drawing.Brushes]::White, 85, 128)

        $fontCap = [System.Drawing.Font]::new("Arial", 12, [System.Drawing.FontStyle]::Bold)
        $g.DrawString("$title  •  $ah", $fontCap, [System.Drawing.Brushes]::Black, 80, 162)

        $fontFt = [System.Drawing.Font]::new("Arial", 8, [System.Drawing.FontStyle]::Bold)
        $g.DrawString("1500+ CHARGE CYCLES  |  SPINE GAUNTLET  |  SOLAR GRADE", $fontFt, [System.Drawing.Brushes]::Gray, 80, 185)
    }

    $g.Dispose()
    $savePath = Join-Path $imgDir $filename
    $bmp.Save($savePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output "Saved $filename"
}

# 1. Inverters
Draw-SharpProduct "inverex_nitrox_2kw.png" "Nitrox 2.5KW Hybrid" "INVEREX" "Inverter" "2500W" "blue"
Draw-SharpProduct "inverex_nitrox_6kw.png" "Nitrox 6KW Dual MPPT" "INVEREX" "Inverter" "6000W" "blue"
Draw-SharpProduct "inverex_yukon_3kw.png" "Yukon 3.2KW Off-Grid" "INVEREX" "Inverter" "3200W" "blue"
Draw-SharpProduct "solis_10kw.png" "Solis 10KW 3-Phase On-Grid" "SOLIS" "Inverter" "10000W" "blue"
Draw-SharpProduct "crown_elego_3kw.png" "Crown Elego 3.2KW Hybrid" "CROWN" "Inverter" "3200W" "blue"
Draw-SharpProduct "homage_vertex.png" "Homage Vertex 1200VA" "HOMAGE" "Inverter" "1000W" "blue"

# 2. 100 Ah Batteries (Tubular & Dry)
Draw-SharpProduct "daewoo_dry_100ah.png" "DLS-100 Dry Battery" "DAEWOO" "Dry" "100 Ah" "gold"
Draw-SharpProduct "phoenix_tx1000_100ah.png" "TX-1000 Tubular" "PHOENIX" "Tubular" "100 Ah" "red"
Draw-SharpProduct "osaka_dry_100ah.png" "Platinum Dry MF-100" "OSAKA" "Dry" "100 Ah" "blue"
Draw-SharpProduct "ags_gl100_100ah.png" "GL-100 Sealed MF" "AGS" "Dry" "100 Ah" "red"

# 3. 150 Ah Batteries (Tubular & Dry)
Draw-SharpProduct "daewoo_dtt175_150ah.png" "DTT-175 Tall Tubular" "DAEWOO" "Tubular" "150 Ah" "yellow"
Draw-SharpProduct "phoenix_uglt180_150ah.png" "UGLT-180 Tubular" "PHOENIX" "Tubular" "150 Ah" "red"
Draw-SharpProduct "phoenix_plc150_150ah.png" "PLC-150 Lead Carbon" "PHOENIX" "Dry" "150 Ah" "red"
Draw-SharpProduct "exide_im1500_150ah.png" "IM-1500 Inverter" "EXIDE" "Tubular" "150 Ah" "red"
Draw-SharpProduct "osaka_tt180_150ah.png" "TT-180 Tubular" "OSAKA" "Tubular" "150 Ah" "blue"

# 4. 250 Ah Batteries (Super Heavy Tubular & Dry)
Draw-SharpProduct "daewoo_dtt260_250ah.png" "DTT-260 Super Tubular" "DAEWOO" "Tubular" "250 Ah" "yellow"
Draw-SharpProduct "phoenix_tx2500_250ah.png" "TX-2500 Extreme Tubular" "PHOENIX" "Tubular" "250 Ah" "red"
Draw-SharpProduct "osaka_tt260_250ah.png" "TT-260 Supreme Tubular" "OSAKA" "Tubular" "250 Ah" "blue"
Draw-SharpProduct "exide_gold_250ah.png" "Gold Tubular 250" "EXIDE" "Tubular" "250 Ah" "red"
Draw-SharpProduct "phoenix_plc250_250ah.png" "PLC-250 Lead Carbon Dry" "PHOENIX" "Dry" "250 Ah" "red"
Draw-SharpProduct "daewoo_mf250_dry.png" "Mega Power MF-250 Dry" "DAEWOO" "Dry" "250 Ah" "gold"
Draw-SharpProduct "narada_lithium.png" "48V 100Ah LiFePO4 Lithium" "NARADA" "Dry" "100Ah / 5KW" "blue"

# 5. Razor-Sharp High-Res Promotional Banners (Replacing Blurry ones)
function Create-CrispBanner($filename, $title, $sub, $badge, $c1, $c2, $tag) {
    $w = 600; $h = 240
    $bmp = [System.Drawing.Bitmap]::new($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $rect = [System.Drawing.Rectangle]::new(0, 0, $w, $h)
    $brush = [System.Drawing.Drawing2D.LinearGradientBrush]::new($rect, $c1, $c2, [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal)
    $g.FillRectangle($brush, $rect)

    # Decorative Circles
    $g.FillEllipse([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(40, 255, 255, 255)), 420, -40, 240, 240)
    $g.FillEllipse([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 255, 255, 255)), 480, 60, 180, 180)

    # Badge
    $g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 255, 255)), 30, 25, 180, 26)
    $g.DrawString($badge, [System.Drawing.Font]::new("Arial", 8, [System.Drawing.FontStyle]::Bold), [System.Drawing.Brushes]::Black, 38, 31)

    # Title
    $g.DrawString($title, [System.Drawing.Font]::new("Arial", 18, [System.Drawing.FontStyle]::Bold), [System.Drawing.Brushes]::White, 30, 65)

    # Subtitle
    $g.DrawString($sub, [System.Drawing.Font]::new("Arial", 10.5, [System.Drawing.FontStyle]::Regular), [System.Drawing.Brushes]::LightCyan, 30, 110)

    # Button
    $g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(234, 179, 8)), 30, 160, 160, 38)
    $g.DrawString("Shop Now →", [System.Drawing.Font]::new("Arial", 11, [System.Drawing.FontStyle]::Bold), [System.Drawing.Brushes]::Black, 50, 170)

    # Right side graphic text
    $g.DrawString($tag, [System.Drawing.Font]::new("Arial", 28, [System.Drawing.FontStyle]::Bold), [System.Drawing.Brushes]::White, 430, 90)

    $g.Dispose()
    $savePath = Join-Path $imgDir $filename
    $bmp.Save($savePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output "Saved crisp banner: $filename"
}

Create-CrispBanner "crisp_banner_water.png" "Pure Electrolyte & Tonic" "100% De-ionized Battery Water for Longer Plate Life" "AUTHENTIC FORMULA" ([System.Drawing.Color]::FromArgb(2, 132, 199)) ([System.Drawing.Color]::FromArgb(12, 74, 110)) "💧 100%"
Create-CrispBanner "crisp_banner_backup.png" "Heavy Duty Long Backup" "Deep Cycle Tubular & Lead Carbon for Uninterrupted Power" "SOLAR GRADE" ([System.Drawing.Color]::FromArgb(15, 23, 42)) ([System.Drawing.Color]::FromArgb(30, 58, 138)) "⚡ 24/7"
Create-CrispBanner "crisp_banner_gosolar.png" "Go Solar Save Electricity" "Net Metering Hybrid Inverters & Solar Batteries in Hyderabad" "GO GREEN" ([System.Drawing.Color]::FromArgb(6, 95, 70)) ([System.Drawing.Color]::FromArgb(15, 118, 110)) "☀️ 90%"

Write-Output "All razor-sharp high-res images generated successfully!"
