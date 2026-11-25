Add-Type -AssemblyName System.Drawing

$imgDir = "C:\Users\User\.gemini\antigravity\scratch\qadri-enterprises\assets\images"
if (!(Test-Path $imgDir)) { New-Item -ItemType Directory -Path $imgDir -Force }

function Create-TonicBottle {
    param(
        [string]$Filename,
        [string]$BrandName,
        [string]$SubText,
        [string]$CapacityText,
        [System.Drawing.Color]$BottleColor,
        [System.Drawing.Color]$CapColor,
        [System.Drawing.Color]$LabelBgColor,
        [System.Drawing.Color]$LabelTextColor,
        [bool]$IsGallon = $false
    )
    
    $width = 500
    $height = 500
    $bmp = New-Object System.Drawing.Bitmap($width, $height)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.Clear([System.Drawing.Color]::Transparent)
    
    # Bottle shadow
    $shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40, 0, 0, 0))
    $g.FillEllipse($shadowBrush, 130, 440, 240, 35)
    $shadowBrush.Dispose()

    if ($IsGallon) {
        # 5L Gallon
        $bodyBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
            (New-Object System.Drawing.Point(120, 160)),
            (New-Object System.Drawing.Point(380, 440)),
            $BottleColor,
            [System.Drawing.Color]::FromArgb(255, 230, 245, 255)
        )
        # Main Gallon Body
        $path = New-Object System.Drawing.Drawing2D.GraphicsPath
        $path.AddRectangle((New-Object System.Drawing.Rectangle(130, 190, 240, 250)))
        $g.FillPath($bodyBrush, $path)

        # Handle
        $handlePen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(180, 200, 230), 22)
        $g.DrawArc($handlePen, 80, 220, 90, 150, 90, 180)
        $handlePen.Dispose()

        # Neck & Cap
        $neckBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(210, 230, 250))
        $g.FillRectangle($neckBrush, 215, 140, 70, 50)
        $neckBrush.Dispose()

        $capBrush = New-Object System.Drawing.SolidBrush($CapColor)
        $g.FillRectangle($capBrush, 205, 110, 90, 35)
        $capBrush.Dispose()

        # Label
        $lblBrush = New-Object System.Drawing.SolidBrush($LabelBgColor)
        $g.FillRectangle($lblBrush, 150, 250, 200, 150)
        $lblBrush.Dispose()

        $borderPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(200, 255, 255, 255), 3)
        $g.DrawRectangle($borderPen, 150, 250, 200, 150)
        $borderPen.Dispose()

        # Text on Label
        $brandFont = New-Object System.Drawing.Font("Arial", 22, [System.Drawing.FontStyle]::Bold)
        $txtBrush = New-Object System.Drawing.SolidBrush($LabelTextColor)
        $sf = New-Object System.Drawing.StringFormat
        $sf.Alignment = [System.Drawing.StringAlignment]::Center
        $sf.LineAlignment = [System.Drawing.StringAlignment]::Center

        $g.DrawString($BrandName, $brandFont, $txtBrush, (New-Object System.Drawing.RectangleF(150, 260, 200, 40)), $sf)

        $subFont = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
        $g.DrawString($SubText, $subFont, $txtBrush, (New-Object System.Drawing.RectangleF(150, 305, 200, 30)), $sf)

        $capFont = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
        $capTextBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
        $capBgBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(220, 20, 20))
        $g.FillRectangle($capBgBrush, 170, 345, 160, 32)
        $g.DrawString($CapacityText, $capFont, $capTextBrush, (New-Object System.Drawing.RectangleF(170, 345, 160, 32)), $sf)

        $brandFont.Dispose(); $subFont.Dispose(); $capFont.Dispose(); $txtBrush.Dispose(); $capTextBrush.Dispose(); $capBgBrush.Dispose(); $bodyBrush.Dispose()
    } else {
        # Regular Bottle (1L - 2L)
        $bodyBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
            (New-Object System.Drawing.Point(150, 120)),
            (New-Object System.Drawing.Point(350, 440)),
            $BottleColor,
            [System.Drawing.Color]::FromArgb(255, 240, 250, 255)
        )

        # Bottle neck tapered
        $taperPoints = @(
            (New-Object System.Drawing.Point(225, 130)),
            (New-Object System.Drawing.Point(275, 130)),
            (New-Object System.Drawing.Point(330, 220)),
            (New-Object System.Drawing.Point(170, 220))
        )
        $g.FillPolygon($bodyBrush, $taperPoints)

        # Bottle body
        $g.FillRectangle($bodyBrush, 170, 220, 160, 220)

        # Bottle cap
        $capBrush = New-Object System.Drawing.SolidBrush($CapColor)
        $g.FillRectangle($capBrush, 220, 90, 60, 40)
        # Cap ridges
        $ridgePen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 2)
        $g.DrawLine($ridgePen, 230, 90, 230, 130)
        $g.DrawLine($ridgePen, 240, 90, 240, 130)
        $g.DrawLine($ridgePen, 250, 90, 250, 130)
        $g.DrawLine($ridgePen, 260, 90, 260, 130)
        $g.DrawLine($ridgePen, 270, 90, 270, 130)
        $capBrush.Dispose(); $ridgePen.Dispose()

        # Water level gloss / ribs
        $ribPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(100, 255, 255, 255), 3)
        $g.DrawArc($ribPen, 175, 230, 150, 30, 0, 180)
        $g.DrawArc($ribPen, 175, 260, 150, 30, 0, 180)
        $g.DrawArc($ribPen, 175, 410, 150, 30, 0, 180)
        $ribPen.Dispose()

        # Label wrap
        $lblBrush = New-Object System.Drawing.SolidBrush($LabelBgColor)
        $g.FillRectangle($lblBrush, 170, 280, 160, 120)
        $lblBrush.Dispose()

        $borderPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(220, 255, 255, 255), 2)
        $g.DrawRectangle($borderPen, 170, 280, 160, 120)
        $borderPen.Dispose()

        # Text
        $brandFont = New-Object System.Drawing.Font("Arial", 18, [System.Drawing.FontStyle]::Bold)
        $txtBrush = New-Object System.Drawing.SolidBrush($LabelTextColor)
        $sf = New-Object System.Drawing.StringFormat
        $sf.Alignment = [System.Drawing.StringAlignment]::Center
        $sf.LineAlignment = [System.Drawing.StringAlignment]::Center

        $g.DrawString($BrandName, $brandFont, $txtBrush, (New-Object System.Drawing.RectangleF(170, 285, 160, 35)), $sf)

        $subFont = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
        $g.DrawString($SubText, $subFont, $txtBrush, (New-Object System.Drawing.RectangleF(170, 320, 160, 25)), $sf)

        $capFont = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
        $capTextBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
        $capBgBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(210, 20, 20))
        $g.FillRectangle($capBgBrush, 185, 355, 130, 28)
        $g.DrawString($CapacityText, $capFont, $capTextBrush, (New-Object System.Drawing.RectangleF(185, 355, 130, 28)), $sf)

        $brandFont.Dispose(); $subFont.Dispose(); $capFont.Dispose(); $txtBrush.Dispose(); $capTextBrush.Dispose(); $capBgBrush.Dispose(); $bodyBrush.Dispose()
    }

    $outPath = Join-Path $imgDir $Filename
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
    Write-Output "Created tonic image: $Filename"
}

# 1. AGS Battery Tonic (1 Liter)
Create-TonicBottle "ags_tonic_1l.png" "AGS" "BATTERY TONIC" "1 LITER" ([System.Drawing.Color]::FromArgb(180, 215, 245)) ([System.Drawing.Color]::FromArgb(220, 20, 20)) ([System.Drawing.Color]::FromArgb(255, 255, 255)) ([System.Drawing.Color]::FromArgb(15, 50, 130)) $false

# 2. AGS Battery Tonic (5 Liters Mega)
Create-TonicBottle "ags_tonic_5l.png" "AGS" "TONIC MEGA PACK" "5 LITERS" ([System.Drawing.Color]::FromArgb(160, 210, 245)) ([System.Drawing.Color]::FromArgb(220, 20, 20)) ([System.Drawing.Color]::FromArgb(255, 255, 255)) ([System.Drawing.Color]::FromArgb(15, 50, 130)) $true

# 3. Osaka Distilled Water (1.5L)
Create-TonicBottle "osaka_water_15l.png" "OSAKA" "DE-IONIZED WATER" "1.5 LITERS" ([System.Drawing.Color]::FromArgb(170, 225, 245)) ([System.Drawing.Color]::FromArgb(0, 100, 200)) ([System.Drawing.Color]::FromArgb(240, 250, 255)) ([System.Drawing.Color]::FromArgb(0, 80, 160)) $false

# 4. Daewoo High-Purity Water (2L)
Create-TonicBottle "daewoo_water_2l.png" "DAEWOO" "PURE ELECTROLYTE" "2 LITERS" ([System.Drawing.Color]::FromArgb(180, 220, 255)) ([System.Drawing.Color]::FromArgb(245, 160, 0)) ([System.Drawing.Color]::FromArgb(10, 30, 80)) ([System.Drawing.Color]::FromArgb(255, 215, 0)) $false

# 5. Exide Electrolyte Adjuster (1L)
Create-TonicBottle "exide_electrolyte_1l.png" "EXIDE" "ACID ELECTROLYTE" "1 LITER" ([System.Drawing.Color]::FromArgb(240, 210, 210)) ([System.Drawing.Color]::FromArgb(200, 0, 0)) ([System.Drawing.Color]::FromArgb(180, 0, 0)) ([System.Drawing.Color]::White) $false

# 6. Hydrometer Tool
function Create-Hydrometer {
    $width = 500
    $height = 500
    $bmp = New-Object System.Drawing.Bitmap($width, $height)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.Clear([System.Drawing.Color]::Transparent)

    # Shadow
    $shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40, 0, 0, 0))
    $g.FillEllipse($shadowBrush, 140, 440, 220, 30)
    $shadowBrush.Dispose()

    # Rubber Suction Bulb (Red)
    $bulbBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(220, 30, 30))
    $g.FillEllipse($bulbBrush, 200, 60, 100, 110)
    $g.FillRectangle($bulbBrush, 235, 160, 30, 30)
    $bulbBrush.Dispose()

    # Glass Tube
    $glassBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 225, 245, 255))
    $g.FillRectangle($glassBrush, 225, 190, 50, 220)
    $glassPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(100, 150, 200), 2)
    $g.DrawRectangle($glassPen, 225, 190, 50, 220)
    $glassPen.Dispose(); $glassBrush.Dispose()

    # Float inside with color scale (Green, Yellow, Red)
    $greenBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(34, 197, 94))
    $yellowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(234, 179, 8))
    $redBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(239, 68, 68))
    $g.FillRectangle($greenBrush, 240, 230, 20, 40)
    $g.FillRectangle($yellowBrush, 240, 270, 20, 40)
    $g.FillRectangle($redBrush, 240, 310, 20, 40)
    $greenBrush.Dispose(); $yellowBrush.Dispose(); $redBrush.Dispose()

    # Rubber Nozzle / Tip
    $tipBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(50, 50, 50))
    $g.FillRectangle($tipBrush, 240, 410, 20, 40)
    $tipBrush.Dispose()

    # Tool Label Badge
    $lblBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(15, 23, 42))
    $g.FillRectangle($lblBrush, 130, 40, 240, 30)
    $lblFont = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
    $g.DrawString("BATTERY HYDROMETER", $lblFont, [System.Drawing.Brushes]::White, (New-Object System.Drawing.RectangleF(130, 40, 240, 30)), $sf)

    $outPath = Join-Path $imgDir "battery_hydrometer.png"
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
    Write-Output "Created hydrometer image"
}
Create-Hydrometer

# 7. Terminal Spray
function Create-TerminalSpray {
    $width = 500
    $height = 500
    $bmp = New-Object System.Drawing.Bitmap($width, $height)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.Clear([System.Drawing.Color]::Transparent)

    # Shadow
    $shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40, 0, 0, 0))
    $g.FillEllipse($shadowBrush, 150, 440, 200, 30)
    $shadowBrush.Dispose()

    # Can body
    $canBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Point(170, 160)),
        (New-Object System.Drawing.Point(330, 440)),
        [System.Drawing.Color]::FromArgb(30, 41, 59),
        [System.Drawing.Color]::FromArgb(71, 85, 105)
    )
    $g.FillRectangle($canBrush, 180, 160, 140, 280)
    $canBrush.Dispose()

    # Can Cap (Bright Yellow)
    $capBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(250, 204, 21))
    $g.FillRectangle($capBrush, 190, 80, 120, 80)
    $capBrush.Dispose()

    # Spray Nozzle
    $nozzleBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(200, 200, 200))
    $g.FillRectangle($nozzleBrush, 235, 60, 30, 20)
    $nozzleBrush.Dispose()

    # Can label
    $lblBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(13, 148, 136))
    $g.FillRectangle($lblBrush, 180, 220, 140, 150)
    $lblBrush.Dispose()

    $font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $subFont = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center

    $g.DrawString("TERMINAL", $font, [System.Drawing.Brushes]::White, (New-Object System.Drawing.RectangleF(180, 230, 140, 30)), $sf)
    $g.DrawString("PROTECTOR", $font, [System.Drawing.Brushes]::Yellow, (New-Object System.Drawing.RectangleF(180, 260, 140, 30)), $sf)
    $g.DrawString("ANTI-CORROSION", $subFont, [System.Drawing.Brushes]::White, (New-Object System.Drawing.RectangleF(180, 300, 140, 25)), $sf)
    $g.DrawString("SPRAY 450ML", $subFont, [System.Drawing.Brushes]::White, (New-Object System.Drawing.RectangleF(180, 330, 140, 25)), $sf)

    $outPath = Join-Path $imgDir "terminal_spray.png"
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
    Write-Output "Created spray image"
}
Create-TerminalSpray

# 8. Re-generate High-DPI crisp_banner_gosolar.png (1920x600)
function Create-UltraHDGoSolarBanner {
    $width = 1920
    $height = 600
    $bmp = New-Object System.Drawing.Bitmap($width, $height)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    
    # Deep Emerald-Cyan High Tech Solar Gradient
    $gradBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Point(0, 0)),
        (New-Object System.Drawing.Point(1920, 600)),
        [System.Drawing.Color]::FromArgb(4, 47, 46),
        [System.Drawing.Color]::FromArgb(6, 78, 59)
    )
    $g.FillRectangle($gradBrush, 0, 0, 1920, 600)
    $gradBrush.Dispose()

    # Subtle solar grid pattern
    $gridPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(25, 255, 255, 255), 2)
    for ($x = 0; $x -lt 1920; $x += 60) {
        $g.DrawLine($gridPen, $x, 0, $x, 600)
    }
    for ($y = 0; $y -lt 600; $y += 60) {
        $g.DrawLine($gridPen, 0, $y, 1920, $y)
    }
    $gridPen.Dispose()

    # Glowing Badge
    $badgeBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(234, 179, 8))
    $g.FillRectangle($badgeBrush, 120, 80, 380, 50)
    $badgeBrush.Dispose()
    
    $badgeFont = New-Object System.Drawing.Font("Arial", 16, [System.Drawing.FontStyle]::Bold)
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
    $g.DrawString("SOLAR ENERGY SPECIALISTS", $badgeFont, [System.Drawing.Brushes]::Black, (New-Object System.Drawing.RectangleF(120, 80, 380, 50)), $sf)

    # Big Heading
    $h1Font = New-Object System.Drawing.Font("Arial", 46, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("GO SOLAR • GO GREEN", $h1Font, [System.Drawing.Brushes]::White, 120, 160)
    
    $h2Font = New-Object System.Drawing.Font("Arial", 36, [System.Drawing.FontStyle]::Bold)
    $yellowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(250, 204, 21))
    $g.DrawString("Save Electricity & Power Your Life With Clean Energy", $h2Font, $yellowBrush, 120, 240)
    $yellowBrush.Dispose()

    # Description
    $bodyFont = New-Object System.Drawing.Font("Arial", 22, [System.Drawing.FontStyle]::Regular)
    $g.DrawString("Hybrid MPPT Solar Inverters, Deep Cycle Tubular & Dry Batteries in Hyderabad.`nFree Delivery & Complete Warranty Support • Qadri Enterprises, Gari Khata.", $bodyFont, [System.Drawing.Brushes]::LightCyan, 120, 320)

    # Buttons
    $btn1Brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(19, 102, 217))
    $g.FillRectangle($btn1Brush, 120, 440, 340, 75)
    $btn1Brush.Dispose()
    $btnFont = New-Object System.Drawing.Font("Arial", 20, [System.Drawing.FontStyle]::Bold)
    $g.DrawString("Shop Inverters & Solar →", $btnFont, [System.Drawing.Brushes]::White, (New-Object System.Drawing.RectangleF(120, 440, 340, 75)), $sf)

    $btn2Brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(16, 185, 129))
    $g.FillRectangle($btn2Brush, 500, 440, 360, 75)
    $btn2Brush.Dispose()
    $g.DrawString("WhatsApp: 0313-8667109", $btnFont, [System.Drawing.Brushes]::White, (New-Object System.Drawing.RectangleF(500, 440, 360, 75)), $sf)

    # Right side 3D Solar Panel Artwork
    $panelBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(14, 116, 144))
    $panelPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 255, 255), 4)
    
    $p1 = @(
        (New-Object System.Drawing.Point(1250, 120)),
        (New-Object System.Drawing.Point(1750, 160)),
        (New-Object System.Drawing.Point(1650, 480)),
        (New-Object System.Drawing.Point(1150, 420))
    )
    $g.FillPolygon($panelBrush, $p1)
    $g.DrawPolygon($panelPen, $p1)

    # Solar cells
    $cellPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(200, 255, 255, 255), 2)
    for ($i = 1; $i -le 4; $i++) {
        $ratio = $i / 5.0
        $topX = 1250 + (1750 - 1250) * $ratio
        $topY = 120 + (160 - 120) * $ratio
        $botX = 1150 + (1650 - 1150) * $ratio
        $botY = 420 + (480 - 420) * $ratio
        $g.DrawLine($cellPen, [int]$topX, [int]$topY, [int]$botX, [int]$botY)
    }

    # Sun graphic
    $sunBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(250, 204, 21))
    $g.FillEllipse($sunBrush, 1680, 50, 160, 160)
    $sunBrush.Dispose()

    $outPath = Join-Path $imgDir "crisp_banner_gosolar.png"
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
    Write-Output "Created Ultra HD Go Solar Banner (1920x600)"
}
Create-UltraHDGoSolarBanner

Write-Output "All tonic and banner assets generated successfully!"
