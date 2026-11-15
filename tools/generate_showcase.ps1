<#
.SYNOPSIS
    Generates the Steam Workshop showcase image (1920x1080): the view from inside a clone helmet.

.DESCRIPTION
    Everything is drawn by this script: a procedural sunset landscape, the Phase II visor of the mod,
    the HUD as laid out in game (see addons/hud/functions/fnc_layout.sqf) and the title.

    Needs the PNG versions of the HUD textures: run tools/generate_textures.ps1 first.
    Output: .hemttout/showcase/showcase.jpg, or showcase_<version>.jpg with -Version

    Usage (from the repository root, requires hemtt in PATH):
        pwsh tools/generate_textures.ps1 -PreviewOnly
        pwsh tools/generate_showcase.ps1
        pwsh tools/generate_showcase.ps1 -Version "4.1" -Subtitle "UPDATE"
#>
param(
    [string]$Version = "",
    [string]$Subtitle = "",
    [string]$TextureDir = (Join-Path $PSScriptRoot '..\.hemttout\textures'),
    [string]$OutDir = (Join-Path $PSScriptRoot '..\.hemttout\showcase')
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
New-Item -ItemType Directory -Force $OutDir | Out-Null

$root = Join-Path $PSScriptRoot '..'
$W = 1920; $H = 1080
$bitmap = [System.Drawing.Bitmap]::new($W, $H)
$g = [System.Drawing.Graphics]::FromImage($bitmap)
$g.SmoothingMode = 'AntiAlias'
$g.InterpolationMode = 'HighQualityBicubic'
$g.TextRenderingHint = 'AntiAliasGridFit'
$random = [System.Random]::new(1138)

# --- Helpers -----------------------------------------------------------------

function C([int]$R, [int]$G, [int]$B, [int]$A = 255) { [System.Drawing.Color]::FromArgb($A, $R, $G, $B) }

function Fill-Rect([double]$X, [double]$Y, [double]$Wd, [double]$Ht, $Color) {
    $brush = [System.Drawing.SolidBrush]::new($Color)
    $g.FillRectangle($brush, [single]$X, [single]$Y, [single]$Wd, [single]$Ht)
    $brush.Dispose()
}

function Fill-Polygon([double[]]$Coords, $Brush) {
    $points = for ($i = 0; $i -lt $Coords.Length; $i += 2) { [System.Drawing.PointF]::new($Coords[$i], $Coords[$i + 1]) }
    $g.FillPolygon($Brush, [System.Drawing.PointF[]]$points)
}

function Draw-Image([string]$Path, [double]$X, [double]$Y, [double]$Wd, [double]$Ht, [double[]]$Tint = @(1, 1, 1), [double]$Alpha = 1) {
    $image = [System.Drawing.Image]::FromFile($Path)
    $matrix = [System.Drawing.Imaging.ColorMatrix]::new()
    $matrix.Matrix00 = $Tint[0]; $matrix.Matrix11 = $Tint[1]; $matrix.Matrix22 = $Tint[2]; $matrix.Matrix33 = $Alpha
    $attributes = [System.Drawing.Imaging.ImageAttributes]::new()
    $attributes.SetColorMatrix($matrix)
    $g.DrawImage($image, [System.Drawing.Rectangle]::new([int]$X, [int]$Y, [int]$Wd, [int]$Ht), 0, 0, $image.Width, $image.Height, 'Pixel', $attributes)
    $image.Dispose()
}

function New-Font([string]$Family, [double]$Size, [string]$Style = 'Regular') {
    [System.Drawing.Font]::new($Family, [single]$Size, [System.Drawing.FontStyle]$Style, [System.Drawing.GraphicsUnit]::Pixel)
}

function Draw-Text([string]$Text, [double]$X, [double]$Y, [double]$Wd, [double]$Size, $Color, [string]$Align = 'Near', [string]$Family = 'Bahnschrift', [string]$Style = 'Regular') {
    $font = New-Font $Family $Size $Style
    $brush = [System.Drawing.SolidBrush]::new($Color)
    $format = [System.Drawing.StringFormat]::new()
    $format.Alignment = [System.Drawing.StringAlignment]$Align
    $format.LineAlignment = [System.Drawing.StringAlignment]::Center
    $g.DrawString($Text, $font, $brush, [System.Drawing.RectangleF]::new([single]$X, [single]$Y, [single]$Wd, [single]($Size * 1.5)), $format)
    $brush.Dispose(); $font.Dispose()
}

function Measure-Text([string]$Text, [double]$Size, [string]$Family = 'Bahnschrift', [string]$Style = 'Regular') {
    $font = New-Font $Family $Size $Style
    $width = $g.MeasureString($Text, $font).Width
    $font.Dispose()
    $width
}

# --- 1. Sky ------------------------------------------------------------------------

$horizon = 640
$sky = [System.Drawing.Drawing2D.LinearGradientBrush]::new([System.Drawing.Point]::new(0, 0), [System.Drawing.Point]::new(0, $horizon + 1), (C 8 16 34), (C 0 0 0))
$blend = [System.Drawing.Drawing2D.ColorBlend]::new(4)
$blend.Colors = @((C 8 16 34), (C 26 52 92), (C 120 96 120), (C 238 150 92))
$blend.Positions = @(0.0, 0.45, 0.78, 1.0)
$sky.InterpolationColors = $blend
$g.FillRectangle($sky, 0, 0, $W, $horizon + 1)
$sky.Dispose()

# Sun glow
foreach ($halo in @(@(520, 26), @(300, 48), @(150, 90), @(60, 200))) {
    $path = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $path.AddEllipse(1240 - $halo[0], ($horizon - 30) - $halo[0] * 0.6, $halo[0] * 2, $halo[0] * 1.2)
    $glow = [System.Drawing.Drawing2D.PathGradientBrush]::new($path)
    $glow.CenterColor = C 255 214 150 $halo[1]
    $glow.SurroundColors = @((C 255 180 120 0))
    $g.FillPath($glow, $path)
    $glow.Dispose(); $path.Dispose()
}

# Stars in the upper sky
for ($i = 0; $i -lt 140; $i++) {
    $x = $random.NextDouble() * $W; $y = $random.NextDouble() * 300
    $alpha = [int](40 + $random.NextDouble() * 120 * (1 - $y / 300))
    $size = 1 + $random.NextDouble() * 1.4
    Fill-Rect $x $y $size $size (C 220 230 255 $alpha)
}

# --- 2. Landscape: ridges and platforms on pillars, in layers of haze ---------------------

function Get-Ridge([double]$BaseY, [double]$Amplitude, [int]$Steps) {
    $heights = [double[]]::new($Steps + 1)
    $heights[0] = $random.NextDouble(); $heights[$Steps] = $random.NextDouble()
    $span = $Steps; $rough = 1.0
    while ($span -gt 1) {
        $half = [int]($span / 2)
        for ($i = $half; $i -lt $Steps; $i += $span) {
            $heights[$i] = ($heights[$i - $half] + $heights[[Math]::Min($i + $half, $Steps)]) / 2 + ($random.NextDouble() - 0.5) * $rough
        }
        $span = $half; $rough *= 0.55
    }
    $coords = [System.Collections.Generic.List[double]]::new()
    for ($i = 0; $i -le $Steps; $i++) {
        $coords.Add($W * $i / $Steps); $coords.Add($BaseY - $heights[$i] * $Amplitude)
    }
    $coords.Add($W); $coords.Add($H); $coords.Add(0); $coords.Add($H)
    , $coords.ToArray()
}

function Add-Platforms($Color, [double]$BaseY, [double]$Scale, [int]$Count) {
    $brush = [System.Drawing.SolidBrush]::new($Color)
    for ($i = 0; $i -lt $Count; $i++) {
        $cx = 80 + $random.NextDouble() * ($W - 160)
        $top = $BaseY - (60 + $random.NextDouble() * 70) * $Scale
        $radius = (50 + $random.NextDouble() * 70) * $Scale
        # Pillars
        foreach ($offset in -0.45, 0.45) {
            $g.FillRectangle($brush, [single]($cx + $offset * $radius - 3 * $Scale), [single]$top, [single](6 * $Scale), [single]($BaseY - $top + 40))
        }
        # Disc platform with a dome
        $g.FillEllipse($brush, [single]($cx - $radius), [single]($top - 8 * $Scale), [single]($radius * 2), [single](16 * $Scale))
        $g.FillPie($brush, [single]($cx - $radius * 0.55), [single]($top - 34 * $Scale), [single]($radius * 1.1), [single](60 * $Scale), 180, 180)
    }
    $brush.Dispose()
}

$layers = @(
    @{ Y = $horizon - 10; Amp = 120; Color = (C 120 92 120); Platforms = 0 },
    @{ Y = $horizon + 10; Amp = 80; Color = (C 82 70 102); Platforms = 4; Scale = 0.55 },
    @{ Y = $horizon + 60; Amp = 70; Color = (C 50 46 74); Platforms = 3; Scale = 0.9 },
    @{ Y = $horizon + 150; Amp = 60; Color = (C 24 24 40); Platforms = 2; Scale = 1.5 }
)
foreach ($layer in $layers) {
    # Haze between the layers: drawn before the ridge, so it only covers what is behind it
    $haze = [System.Drawing.Drawing2D.LinearGradientBrush]::new([System.Drawing.Point]::new(0, $layer.Y - 140), [System.Drawing.Point]::new(0, $layer.Y + 1), (C 0 0 0), (C 0 0 0))
    $hazeBlend = [System.Drawing.Drawing2D.ColorBlend]::new(3)
    $hazeBlend.Colors = @((C 240 165 125 0), (C 240 165 125 55), (C 240 165 125 0))
    $hazeBlend.Positions = @(0.0, 0.7, 1.0)
    $haze.InterpolationColors = $hazeBlend
    $g.FillRectangle($haze, 0, $layer.Y - 140, $W, 141)
    $haze.Dispose()

    if ($layer.Platforms -gt 0) { Add-Platforms $layer.Color $layer.Y $layer.Scale $layer.Platforms }
    $brush = [System.Drawing.SolidBrush]::new($layer.Color)
    Fill-Polygon (Get-Ridge $layer.Y $layer.Amp 64) $brush
    $brush.Dispose()
}

# Foreground: darker ground with a few rocks, fading to black under the visor
$ground = [System.Drawing.Drawing2D.LinearGradientBrush]::new([System.Drawing.Point]::new(0, 760), [System.Drawing.Point]::new(0, $H + 1), (C 0 0 0 0), (C 4 4 10 235))
$g.FillRectangle($ground, 0, 760, $W, $H - 760)
$ground.Dispose()
$rockBrush = [System.Drawing.SolidBrush]::new((C 12 12 22))
for ($i = 0; $i -lt 9; $i++) {
    $rx = $random.NextDouble() * $W; $ry = 840 + $random.NextDouble() * 120; $rw = 40 + $random.NextDouble() * 160
    Fill-Polygon @($rx, $ry, ($rx + $rw * 0.3), ($ry - $rw * 0.25), ($rx + $rw * 0.7), ($ry - $rw * 0.18), ($rx + $rw), $ry) $rockBrush
}
$rockBrush.Dispose()

# --- 3. Visor (Phase II, real proportions: full height, centered) ---------------------

$visorW = $H * 2
Draw-Image (Join-Path $OutDir 'visor_P2_frame.png') (($W - $visorW) / 2) 0 $visorW $H
Draw-Image (Join-Path $OutDir 'visor_P2_color.png') (($W - $visorW) / 2) 0 $visorW $H @(0, 0.45, 0.74)

# Vignette
$path = [System.Drawing.Drawing2D.GraphicsPath]::new()
$path.AddEllipse(-320, -240, $W + 640, $H + 480)
$vignette = [System.Drawing.Drawing2D.PathGradientBrush]::new($path)
$vignette.CenterColor = C 0 0 0 0
$vignette.SurroundColors = @((C 0 0 0 170))
$vignette.FocusScales = [System.Drawing.PointF]::new(0.55, 0.5)
$g.FillRectangle($vignette, 0, 0, $W, $H)
$vignette.Dispose(); $path.Dispose()

# --- 4. HUD, as laid out in game (fnc_layout), at 115% ---------------------------------

$s = 1.15
function XL([double]$X) { $X * $s }
function XR([double]$X) { $W - (1920 - $X) * $s }
function XC([double]$X) { $W / 2 + ($X - 960) * $s }
function Y([double]$Y) { $Y * $s }
function Hud([string]$Name) { Join-Path $TextureDir "$Name.png" }

$hudBlue = @(0.15, 0.6, 1.0)
$blue = C 40 155 255
$track = C 255 255 255 60
$white = C 255 255 255
$soft = C 190 210 230
$green = C 77 230 115
$amber = C 255 215 75
$orange = C 255 140 0

# Health (top left)
Draw-Image (Hud 'health_frame_ca') (XL 24) (Y 24) (256 * $s) (64 * $s) $hudBlue
foreach ($row in @(@('BLOOD', 0.92, '92%', 35), @('PAIN', 0.2, '20%', 57))) {
    Draw-Text $row[0] (XL 38) (Y $row[3]) (76 * $s) (14 * $s) $soft
    Fill-Rect (XL 116) (Y ($row[3] + 7)) (104 * $s) (6 * $s) $track
    Fill-Rect (XL 116) (Y ($row[3] + 7)) (104 * $s * $row[1]) (6 * $s) $blue
    Draw-Text $row[2] (XL 220) (Y $row[3]) (50 * $s) (15 * $s) $white 'Far'
}

# Radio (left, under the health block): transmitting, receiving
$radios = @(
    @('CWP-8', 'CH 1 | 100 MHz', '+CH 3 | 120', $green, @(0.3, 0.9, 0.45)),
    @('LR-12', 'CH 2 | 52.5 MHz', '', $amber, @(1, 0.85, 0.3))
)
for ($i = 0; $i -lt $radios.Count; $i++) {
    $r = $radios[$i]; $ry = 120 + 54 * $i
    Draw-Image (Hud 'radio_frame_ca') (XL 24) (Y $ry) (192 * $s) (48 * $s) $r[4]
    Draw-Text $r[0] (XL 38) (Y ($ry + 3)) (146 * $s) (14 * $s) $soft
    Draw-Text $r[2] (XL 38) (Y ($ry + 3)) (146 * $s) (14 * $s) $soft 'Far'
    Draw-Text $r[1] (XL 38) (Y ($ry + 22)) (146 * $s) (17 * $s) $white
    Fill-Rect (XL 190) (Y ($ry + 16)) (8 * $s) (18 * $s) $r[3]
}

# Compass (top center): frame, graduations, labels, squad chevrons, waypoint, heading
$heading = 318
Draw-Image (Hud 'compass_frame_ca') (XC 704) (Y 8) (512 * $s) (64 * $s) $hudBlue
$windowX = XC 720; $windowY = Y 11
function Compass-X([double]$Delta) { $windowX + (240 + $Delta * 4) * $s }
function Edge-Alpha([double]$Delta) { [Math]::Max(0, [Math]::Min(1, (62 - [Math]::Abs($Delta)) / 22)) }
for ($degree = [Math]::Ceiling(($heading - 62) / 5) * 5; $degree -le $heading + 62; $degree += 5) {
    $delta = $degree - $heading; $n = (($degree % 360) + 360) % 360
    $alpha = [int](255 * (Edge-Alpha $delta))
    if ($n % 45 -eq 0) { $tw = 2; $th = 11 } elseif ($n % 15 -eq 0) { $tw = 1.5; $th = 7; $alpha = [int]($alpha * 0.85) } else { $tw = 1; $th = 4; $alpha = [int]($alpha * 0.6) }
    Fill-Rect ((Compass-X $delta) - $tw * $s / 2) ($windowY + (30 - $th) * $s) ($tw * $s) ($th * $s) (C 255 255 255 $alpha)
    if ($n % 15 -eq 0) {
        $label = if ($n % 45 -eq 0) { @('N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW')[$n / 45] } else { "$n" }
        $size = if ($n % 45 -eq 0) { 13 } else { 10 }
        Draw-Text $label ((Compass-X $delta) - 20 * $s) ($windowY + ($(if ($n % 45 -eq 0) { -1 } else { 1 })) * $s) (40 * $s) ($size * $s) (C 255 255 255 $alpha) 'Center'
    }
}
foreach ($bearing in -28, -17, 9) {
    Draw-Image (Hud 'squad_marker_ca') ((Compass-X $bearing) - 5 * $s) ($windowY + 10 * $s) (10 * $s) (10 * $s) $hudBlue
}
Draw-Image (Hud 'compass_waypoint_ca') ((Compass-X 31) - 6 * $s) ($windowY + 9 * $s) (12 * $s) (12 * $s) @(1, 0.85, 0.3)
Draw-Text "$heading°" (XC 920) (Y 41) (80 * $s) (18 * $s) $white 'Center'

# Notifications (under the compass, width adapted to the text)
$ny = Y 80
foreach ($n in @(@('Extraction in 5 minutes', $blue), @('CT-4219 is down', $orange))) {
    $tw = (Measure-Text $n[0] (16 * $s)) + 36 * $s
    $nx = $W / 2 - $tw / 2
    Fill-Rect $nx $ny $tw (26 * $s) (C 0 0 0 150)
    Fill-Rect $nx $ny (3 * $s) (26 * $s) $n[1]
    Fill-Rect $nx ($ny + 24.5 * $s) $tw (1.5 * $s) $n[1]
    Draw-Text $n[0] $nx ($ny + 1 * $s) $tw (16 * $s) $white 'Center'
    $ny += 32 * $s
}

# Weapon (top right)
Draw-Image (Hud 'weapon_frame_ca') (XR 1608) (Y 24) (288 * $s) (144 * $s) $hudBlue
Draw-Text 'DC-15A Blaster Rifle' (XR 1638) (Y 29) (220 * $s) (16 * $s) $white
$rifle = @(4, 20, 64, 14, 68, 8, 100, 8, 104, 14, 126, 14, 126, 20, 80, 22, 74, 36, 64, 36, 68, 24, 36, 26, 30, 38, 10, 38, 14, 26, 4, 26)
$coords = for ($i = 0; $i -lt $rifle.Count; $i += 2) { (XR 1622) + $rifle[$i] * $s; (Y 58) + $rifle[$i + 1] * $s }
$rifleBrush = [System.Drawing.SolidBrush]::new((C 225 232 240 235))
Fill-Polygon ([double[]]$coords) $rifleBrush
$rifleBrush.Dispose()
Draw-Text '47' (XR 1754) (Y 50) (128 * $s) (44 * $s) $white 'Far'
Fill-Rect (XR 1622) (Y 114) (260 * $s) (5 * $s) $track
Fill-Rect (XR 1622) (Y 114) (208 * $s) (5 * $s) $blue
for ($i = 0; $i -lt 5; $i++) {
    Fill-Rect (XR (1622 + 22 * $i)) (Y 126) (18 * $s) (5 * $s) $(if ($i -lt 3) { $blue } else { C 120 128 140 })
}
Draw-Text '6' (XR 1794) (Y 117) (40 * $s) (16 * $s) $white 'Far'
Fill-Rect (XR 1844) (Y 119) (10 * $s) (18 * $s) (C 150 160 170)

# Grenade (under the weapon): green smoke
Draw-Image (Hud 'grenade_frame_ca') (XR 1768) (Y 154) (128 * $s) (64 * $s) $hudBlue
Draw-Text '2' (XR 1774) (Y 156) (54 * $s) (26 * $s) $white 'Center'
Draw-Text 'Green' (XR 1772) (Y 186) (58 * $s) (12 * $s) $soft 'Center'
Fill-Rect (XR 1851) (Y 166) (16 * $s) (30 * $s) (C 205 210 200)
Fill-Rect (XR 1853) (Y 161) (12 * $s) (6 * $s) (C 150 155 150)
Fill-Rect (XR 1840) (Y 206) (38 * $s) (3 * $s) (C 77 255 77)

# --- 5. Title -----------------------------------------------------------------------------

# Soft dark band behind the title for contrast
$band = [System.Drawing.Drawing2D.GraphicsPath]::new()
$band.AddEllipse(460, 470, 1000, 330)
$bandBrush = [System.Drawing.Drawing2D.PathGradientBrush]::new($band)
$bandBrush.CenterColor = C 4 8 16 175
$bandBrush.SurroundColors = @((C 4 8 16 0))
$g.FillPath($bandBrush, $band)
$bandBrush.Dispose(); $band.Dispose()

$title = 'CLONEWARS HUD'
$titleSize = 104
$titleWidth = Measure-Text $title $titleSize 'Bahnschrift' 'Bold'
$logoSize = 128
$blockWidth = $logoSize + 28 + $titleWidth
$left = ($W - $blockWidth) / 2
Draw-Image (Join-Path $root 'logo_ca.png') $left 515 $logoSize $logoSize
# Title with a blue glow
foreach ($glow in @(@(10, 18), @(5, 40))) {
    for ($dx = -$glow[0]; $dx -le $glow[0]; $dx += $glow[0]) {
        for ($dy = -$glow[0]; $dy -le $glow[0]; $dy += $glow[0]) {
            Draw-Text $title ($left + $logoSize + 28 + $dx) (500 + $dy) ($titleWidth + 40) $titleSize (C 40 150 255 $glow[1]) 'Near' 'Bahnschrift' 'Bold'
        }
    }
}
Draw-Text $title ($left + $logoSize + 28) 500 ($titleWidth + 40) $titleSize $white 'Near' 'Bahnschrift' 'Bold'

$tagline = if ($Version -ne "") { (@("VERSION $Version", $Subtitle) | Where-Object { $_ -ne "" }) -join "  ·  " } else { 'IMMERSIVE CLONE TROOPER HELMET HUD' }
Draw-Text $tagline 0 662 $W 30 (C 130 205 255) 'Center' 'Bahnschrift' 'Regular'
Draw-Text 'CBA  ·  ACE3  ·  TFAR  ·  ZEUS ENHANCED' 0 712 $W 22 (C 200 210 225 200) 'Center' 'Bahnschrift Light'

$g.Dispose()

$output = Join-Path $OutDir ($(if ($Version -ne "") { "showcase_$Version.jpg" } else { "showcase.jpg" }))
$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object MimeType -eq 'image/jpeg'
$quality = [System.Drawing.Imaging.EncoderParameters]::new(1)
$quality.Param[0] = [System.Drawing.Imaging.EncoderParameter]::new([System.Drawing.Imaging.Encoder]::Quality, [long]92)
$bitmap.Save($output, $codec, $quality)
$bitmap.Dispose()
Write-Host "JPG  $output"
