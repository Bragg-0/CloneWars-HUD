<#
.SYNOPSIS
    Generates the Steam Workshop showcase image (1920x1080) from the mod textures.

.DESCRIPTION
    Needs the PNG versions of the textures: run tools/generate_textures.ps1 first.
    Output: .hemttout/showcase/showcase_v4.jpg

    Usage (from the repository root):
        pwsh tools/generate_textures.ps1 -PreviewOnly
        pwsh tools/generate_showcase.ps1
#>
param(
    [string]$TextureDir = (Join-Path $PSScriptRoot '..\.hemttout\textures'),
    [string]$OutDir = (Join-Path $PSScriptRoot '..\.hemttout\showcase')
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
New-Item -ItemType Directory -Force $OutDir | Out-Null

$root = Join-Path $PSScriptRoot '..'
$bitmap = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bitmap)
$g.SmoothingMode = 'AntiAlias'
$g.InterpolationMode = 'HighQualityBicubic'
$g.TextRenderingHint = 'AntiAliasGridFit'

# --- Helpers -----------------------------------------------------------------

$hudBlue = @(0.15, 0.6, 1.0)

function Draw-Texture([string]$Path, [double]$X, [double]$Y, [double]$W, [double]$H, [double[]]$Tint = @(1, 1, 1), [double]$Alpha = 1, $Source = $null) {
    $image = [System.Drawing.Image]::FromFile($Path)
    $matrix = [System.Drawing.Imaging.ColorMatrix]::new()
    $matrix.Matrix00 = $Tint[0]; $matrix.Matrix11 = $Tint[1]; $matrix.Matrix22 = $Tint[2]; $matrix.Matrix33 = $Alpha
    $attributes = [System.Drawing.Imaging.ImageAttributes]::new()
    $attributes.SetColorMatrix($matrix)
    $destination = [System.Drawing.Rectangle]::new([int]$X, [int]$Y, [int]$W, [int]$H)
    if ($Source) {
        $g.DrawImage($image, $destination, [single]$Source[0], [single]$Source[1], [single]$Source[2], [single]$Source[3], 'Pixel', $attributes)
    } else {
        $g.DrawImage($image, $destination, 0, 0, $image.Width, $image.Height, 'Pixel', $attributes)
    }
    $image.Dispose()
}
function Hud([string]$Name) { Join-Path $TextureDir "$Name.png" }

function Draw-Text([string]$Text, [double]$X, [double]$Y, [double]$Size, [string]$Style = 'Regular', $Color = [System.Drawing.Color]::White, [string]$Align = 'Near', [double]$W = 0) {
    $font = [System.Drawing.Font]::new('Bahnschrift', [single]$Size, [System.Drawing.FontStyle]$Style, [System.Drawing.GraphicsUnit]::Pixel)
    if ($font.Name -ne 'Bahnschrift') { $font = [System.Drawing.Font]::new('Arial', [single]$Size, [System.Drawing.FontStyle]$Style, [System.Drawing.GraphicsUnit]::Pixel) }
    $brush = [System.Drawing.SolidBrush]::new($Color)
    $format = [System.Drawing.StringFormat]::new()
    $format.Alignment = [System.Drawing.StringAlignment]$Align
    if ($W -gt 0) {
        $g.DrawString($Text, $font, $brush, [System.Drawing.RectangleF]::new([single]$X, [single]$Y, [single]$W, [single]($Size * 2)), $format)
    } else {
        $g.DrawString($Text, $font, $brush, [single]$X, [single]$Y, $format)
    }
    $brush.Dispose(); $font.Dispose()
}

function Fill-Rect([double]$X, [double]$Y, [double]$W, [double]$H, $Color) {
    $brush = [System.Drawing.SolidBrush]::new($Color)
    $g.FillRectangle($brush, [single]$X, [single]$Y, [single]$W, [single]$H)
    $brush.Dispose()
}

$blue = [System.Drawing.Color]::FromArgb(255, 40, 155, 255)
$lightBlue = [System.Drawing.Color]::FromArgb(255, 120, 205, 255)
$grey = [System.Drawing.Color]::FromArgb(255, 110, 120, 135)
$track = [System.Drawing.Color]::FromArgb(70, 255, 255, 255)
$green = [System.Drawing.Color]::FromArgb(255, 77, 230, 115)
$amber = [System.Drawing.Color]::FromArgb(255, 255, 215, 75)
$orange = [System.Drawing.Color]::FromArgb(255, 255, 140, 0)
$textGrey = [System.Drawing.Color]::FromArgb(255, 175, 195, 215)

# --- Background ----------------------------------------------------------------

$background = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.Point]::new(0, 0), [System.Drawing.Point]::new(1920, 1080),
    [System.Drawing.Color]::FromArgb(255, 16, 28, 46), [System.Drawing.Color]::FromArgb(255, 4, 7, 12))
$g.FillRectangle($background, 0, 0, 1920, 1080)
$background.Dispose()

# Faint grid
$gridPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(14, 120, 200, 255), 1)
for ($x = 0; $x -le 1920; $x += 60) { $g.DrawLine($gridPen, $x, 0, $x, 1080) }
for ($y = 0; $y -le 1080; $y += 60) { $g.DrawLine($gridPen, 0, $y, 1920, $y) }
$gridPen.Dispose()

# Glow behind the HUD mock-up
$glow = [System.Drawing.Drawing2D.GraphicsPath]::new()
$glow.AddEllipse(880, 60, 1100, 960)
$glowBrush = [System.Drawing.Drawing2D.PathGradientBrush]::new($glow)
$glowBrush.CenterColor = [System.Drawing.Color]::FromArgb(70, 30, 120, 220)
$glowBrush.SurroundColors = @([System.Drawing.Color]::FromArgb(0, 30, 120, 220))
$g.FillPath($glowBrush, $glow)
$glowBrush.Dispose()

# --- Left: logo, title, features --------------------------------------------------

Draw-Texture (Join-Path $root 'logo_ca.png') 110 70 330 330
Draw-Text 'CLONEWARS HUD' 112 420 84 'Bold'
Draw-Text '4.0  ·  COMPLETE REWRITE' 116 520 34 'Regular' $lightBlue

$features = @(
    'Original HUD for Phase I, Phase II, ARF and BARC helmets',
    'Compass strip with squad and waypoint',
    'Weapon, grenade and health blocks',
    'TFAR radio: channels, transmit and receive',
    'HUD notifications and squad alerts',
    'Boot sequence, hit glitch and HUD sounds',
    'Works on every screen: 16:9, 21:9, 4:3',
    'Zeus Enhanced modules, ACE3 support',
    'Fully configurable with CBA settings'
)
$y = 600
foreach ($feature in $features) {
    Fill-Rect 120 ($y + 14) 10 10 $blue
    Draw-Text $feature 146 $y 30 'Regular' $textGrey
    $y += 46
}

# --- Right: HUD mock-up (blocks drawn at 1.4x) -------------------------------------

$s = 1.4

# Compass: frame, strip window at heading 330, heading value
$cx = 1080; $cy = 70
Draw-Texture (Hud 'compass_frame_ca') $cx $cy (512 * $s) (64 * $s) $hudBlue
$heading = 330
$stripTexture = [System.Drawing.Image]::FromFile((Hud 'compass_strip_ca'))
$texPerDesign = $stripTexture.Width / 1920
$stripTexture.Dispose()
Draw-Texture (Hud 'compass_strip_ca') ($cx + 16 * $s) ($cy + 3 * $s) (480 * $s) (30 * $s) @(1, 1, 1) 1 @(($heading * 4 * $texPerDesign), 0, (480 * $texPerDesign), 32)
# Waypoint and squad marks on the strip
Draw-Texture (Hud 'compass_waypoint_ca') ($cx + (16 + 240 + 22 * 4 - 6) * $s) ($cy + 19 * $s) (12 * $s) (12 * $s) @(1, 0.85, 0.3)
foreach ($bearing in -31, -18, 40) {
    Fill-Rect ($cx + (16 + 240 + $bearing * 4) * $s) ($cy + 22 * $s) (3 * $s) (9 * $s) $blue
}
Draw-Text '330°' ($cx + 216 * $s) ($cy + 36 * $s) (18 * $s) 'Regular' ([System.Drawing.Color]::White) 'Center' (80 * $s)

# Notifications
$nx = 1112; $ny = 190
Draw-Texture (Hud 'notification_frame_ca') $nx $ny (448 * $s) (28 * $s) @(1, 0.55, 0)
Draw-Text 'Extraction in 5 minutes' ($nx + 16 * $s) ($ny + 4 * $s) (16 * $s)
Draw-Texture (Hud 'notification_frame_ca') $nx ($ny + 32 * $s) (448 * $s) (28 * $s) @(0.3, 0.9, 0.45)
Draw-Text 'Your HUD has been repaired.' ($nx + 16 * $s) ($ny + 36 * $s) (16 * $s)

# Health block
$hx = 980; $hy = 330
Draw-Texture (Hud 'health_frame_ca') $hx $hy (256 * $s) (64 * $s) $hudBlue
Draw-Text 'BLOOD' ($hx + 14 * $s) ($hy + 11 * $s) (14 * $s) 'Regular' $textGrey
Fill-Rect ($hx + 92 * $s) ($hy + 18 * $s) (104 * $s) (6 * $s) $track
Fill-Rect ($hx + 92 * $s) ($hy + 18 * $s) (83 * $s) (6 * $s) $blue
Draw-Text '80%' ($hx + 196 * $s) ($hy + 11 * $s) (15 * $s) 'Regular' ([System.Drawing.Color]::White) 'Far' (50 * $s)
Draw-Text 'PAIN' ($hx + 14 * $s) ($hy + 33 * $s) (14 * $s) 'Regular' $textGrey
Fill-Rect ($hx + 92 * $s) ($hy + 40 * $s) (104 * $s) (6 * $s) $track
Fill-Rect ($hx + 92 * $s) ($hy + 40 * $s) (62 * $s) (6 * $s) $orange
Draw-Text '60%' ($hx + 196 * $s) ($hy + 33 * $s) (15 * $s) 'Regular' $orange 'Far' (50 * $s)

# Weapon block
$wx = 1400; $wy = 330
Draw-Texture (Hud 'weapon_frame_ca') $wx $wy (320 * $s) (160 * $s) $hudBlue
Draw-Text 'DC-15A Blaster Rifle' ($wx + 36 * $s) ($wy + 9 * $s) (18 * $s)
# Simple rifle silhouette in place of the in-game weapon picture
$rifle = [System.Drawing.Drawing2D.GraphicsPath]::new()
$points = @(
    @(20, 70), @(80, 64), @(84, 58), @(118, 58), @(122, 64), @(150, 64), @(150, 70), @(96, 72),
    @(90, 86), @(80, 86), @(84, 74), @(52, 76), @(46, 88), @(26, 88), @(30, 76), @(20, 76)
) | ForEach-Object { [System.Drawing.PointF]::new([single]($wx + $_[0] * $s), [single]($wy + $_[1] * $s)) }
$rifle.AddPolygon([System.Drawing.PointF[]]$points)
$rifleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(230, 220, 228, 238))
$g.FillPath($rifleBrush, $rifle)
$rifleBrush.Dispose()
Draw-Text '47' ($wx + 160 * $s) ($wy + 30 * $s) (60 * $s) 'Bold' ([System.Drawing.Color]::White) 'Far' (146 * $s)
Fill-Rect ($wx + 14 * $s) ($wy + 108 * $s) (292 * $s) (6 * $s) $track
Fill-Rect ($wx + 14 * $s) ($wy + 108 * $s) (234 * $s) (6 * $s) $blue
for ($i = 0; $i -lt 5; $i++) {
    Fill-Rect ($wx + (14 + 25 * $i) * $s) ($wy + 124 * $s) (20 * $s) (6 * $s) $(if ($i -lt 5) { $blue } else { $grey })
}
Draw-Text '9' ($wx + 216 * $s) ($wy + 116 * $s) (22 * $s) 'Regular' ([System.Drawing.Color]::White) 'Far' (42 * $s)
Fill-Rect ($wx + 266 * $s) ($wy + 120 * $s) (14 * $s) (20 * $s) $grey

# Grenade block, green smoke
$gx = 1400 + (192 * $s); $gy = 330 + (170 * $s)
Draw-Texture (Hud 'grenade_frame_ca') $gx $gy (128 * $s) (64 * $s) $hudBlue
Draw-Text '2' ($gx + 8 * $s) ($gy + 12 * $s) (30 * $s) 'Regular' ([System.Drawing.Color]::White) 'Center' (50 * $s)
Fill-Rect ($gx + 78 * $s) ($gy + 14 * $s) (16 * $s) (30 * $s) $green
Fill-Rect ($gx + 80 * $s) ($gy + 9 * $s) (12 * $s) (6 * $s) ([System.Drawing.Color]::FromArgb(255, 160, 200, 170))
Fill-Rect ($gx + 72 * $s) ($gy + 54 * $s) (38 * $s) (3 * $s) $green

# Radio rows: transmitting, receiving
$rx = 1400 + (128 * $s); $ry = $gy + 74 * $s
$radios = @(
    @('CWP-8', 'CH 1 | 100 MHz', '+CH 3 | 120', $green),
    @('LR Backpack', 'CH 2 | 52.5 MHz', '', $amber)
)
foreach ($radio in $radios) {
    Draw-Texture (Hud 'radio_frame_ca') $rx $ry (192 * $s) (48 * $s) @(($radio[3].R / 255), ($radio[3].G / 255), ($radio[3].B / 255))
    Draw-Text $radio[0] ($rx + 14 * $s) ($ry + 4 * $s) (14 * $s) 'Regular' $textGrey
    Draw-Text $radio[2] ($rx + 14 * $s) ($ry + 4 * $s) (14 * $s) 'Regular' $textGrey 'Far' (146 * $s)
    Draw-Text $radio[1] ($rx + 14 * $s) ($ry + 22 * $s) (18 * $s) 'Bold'
    Fill-Rect ($rx + 166 * $s) ($ry + 16 * $s) (8 * $s) (18 * $s) $radio[3]
    $ry += 54 * $s
}

# Squad markers, in perspective (near to far)
Draw-Texture (Hud 'squad_marker_ca') 1010 480 72 72 $hudBlue
Draw-Texture (Hud 'squad_marker_ca') 1150 500 52 52 $hudBlue
Draw-Texture (Hud 'squad_marker_ca') 1262 512 38 38 @(1, 0.55, 0)
Draw-Text 'Squad markers' 990 570 24 'Regular' $textGrey 'Center' 330

# --- Footer --------------------------------------------------------------------------

Draw-Text 'Requires CBA_A3  ·  Optional: ACE3, TFAR, Zeus Enhanced' 112 1020 24 'Regular' $grey

$g.Dispose()

$output = Join-Path $OutDir 'showcase_v4.jpg'
$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object MimeType -eq 'image/jpeg'
$quality = [System.Drawing.Imaging.EncoderParameters]::new(1)
$quality.Param[0] = [System.Drawing.Imaging.EncoderParameter]::new([System.Drawing.Imaging.Encoder]::Quality, [long]92)
$bitmap.Save($output, $codec, $quality)
$bitmap.Dispose()
Write-Host "JPG  $output"
