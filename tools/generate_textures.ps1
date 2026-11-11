<#
.SYNOPSIS
    Generates the HUD info block textures (weapon, grenade, heading) and converts them to PAA.

.DESCRIPTION
    The textures are original artwork drawn by this script (no external image).
    Lines are white so the game can tint them with the HUD color; the panel fill is translucent black.

    Shapes are described in "design pixels", the same unit as the layout table of
    addons/hud/functions/fnc_layout.sqf (1920x1080 canvas). Keep both in sync.

    Usage (from the repository root, requires hemtt in PATH):
        pwsh tools/generate_textures.ps1
        pwsh tools/generate_textures.ps1 -PreviewOnly   # PNG only, in .hemttout/textures
#>
param(
    [string]$OutDir = (Join-Path $PSScriptRoot '..\addons\ui\data\hud'),
    [string]$PngDir = (Join-Path $PSScriptRoot '..\.hemttout\textures'),
    [switch]$PreviewOnly
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

New-Item -ItemType Directory -Force $PngDir | Out-Null

# --- Drawing helpers ---------------------------------------------------------

function New-Canvas([int]$TexW, [int]$TexH, [double]$DesignW) {
    $bitmap = [System.Drawing.Bitmap]::new($TexW, $TexH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bitmap)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Transparent)
    $scale = $TexW / $DesignW
    $g.ScaleTransform($scale, $scale) # Draw in design pixels
    @{ Bitmap = $bitmap; G = $g }
}

function New-Path([double[]]$Coords, [bool]$Closed = $true) {
    $points = for ($i = 0; $i -lt $Coords.Length; $i += 2) {
        [System.Drawing.PointF]::new($Coords[$i], $Coords[$i + 1])
    }
    $path = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $path.AddLines([System.Drawing.PointF[]]$points)
    if ($Closed) { $path.CloseFigure() }
    $path
}

function New-Pen([int]$Alpha, [double]$Width) {
    $pen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb($Alpha, 255, 255, 255), $Width)
    $pen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
    $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen
}

# Translucent dark panel
function Add-Fill($g, $path, [int]$Alpha = 150) {
    $brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb($Alpha, 0, 0, 0))
    $g.FillPath($brush, $path)
    $brush.Dispose()
}

# Holographic line: soft halo + crisp core
function Add-Line($g, $path, [double]$Width = 1.6, [int]$Alpha = 255, [bool]$Glow = $true) {
    if ($Glow) {
        foreach ($halo in @(@(9.0, 14), @(5.5, 26), @(3.2, 46))) {
            $pen = New-Pen ([int]($halo[1] * $Alpha / 255)) ($Width + $halo[0])
            $g.DrawPath($pen, $path)
            $pen.Dispose()
        }
    }
    $pen = New-Pen $Alpha $Width
    $g.DrawPath($pen, $path)
    $pen.Dispose()
}

function Add-Rect($g, [double]$X, [double]$Y, [double]$W, [double]$H, [int]$Alpha) {
    $brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb($Alpha, 255, 255, 255))
    $g.FillRectangle($brush, [single]$X, [single]$Y, [single]$W, [single]$H)
    $brush.Dispose()
}

function Save-Texture($canvas, [string]$Name) {
    $png = Join-Path $PngDir "$Name.png"
    $canvas.G.Dispose()
    $canvas.Bitmap.Save($png, [System.Drawing.Imaging.ImageFormat]::Png)
    $canvas.Bitmap.Dispose()
    Write-Host "PNG  $png"
    if (-not $PreviewOnly) {
        $paa = Join-Path $OutDir "$Name.paa"
        if (Test-Path $paa) { Remove-Item $paa }
        & hemtt utils paa convert $png $paa | Out-Null
        if (-not (Test-Path $paa)) { throw "PAA conversion failed for $Name" }
        Write-Host "PAA  $paa"
    }
}

# --- Weapon block: 320x160 design px -> 1024x512 ------------------------------

$c = New-Canvas 1024 512 320
$g = $c.G

$outline = New-Path @(30,6, 314,6, 314,130, 290,154, 6,154, 6,30)
Add-Fill $g $outline
Add-Line $g $outline

# Double line on the top-left cut corner
Add-Line $g (New-Path @(12,34, 34,12) $false) 1.2 200 $false
# Accent bar on the right edge
Add-Line $g (New-Path @(314,44, 314,96) $false) 4.5
# Separator under the weapon name, with a small end marker
Add-Line $g (New-Path @(40,34, 304,34) $false) 1 110 $false
Add-Rect $g 296 31.5 8 5 220
# Ammo bar track
Add-Rect $g 14 108 292 6 38
# Hatching next to the bottom-right cut corner
foreach ($offset in 0, 7, 14) {
    Add-Line $g (New-Path @((292 - $offset),148, (300 - $offset),140) $false) 1.2 150 $false
}
# Notches on the left edge
Add-Rect $g 6 60 5 2 230
Add-Rect $g 6 70 5 2 230
Add-Rect $g 6 80 5 2 230

Save-Texture $c 'weapon_frame_ca'

# --- Grenade block: 128x64 design px -> 512x256 -------------------------------

$c = New-Canvas 512 256 128
$g = $c.G

$outline = New-Path @(18,5, 123,5, 123,47, 111,59, 5,59, 5,17)
Add-Fill $g $outline
Add-Line $g $outline

# Divider between count and icon
Add-Line $g (New-Path @(61,14, 61,50) $false) 1 110 $false
# Accent bar on the left edge
Add-Line $g (New-Path @(5,26, 5,50) $false) 3.5
# Double line on the top-left cut corner
Add-Line $g (New-Path @(10,19, 20,9) $false) 1 200 $false

Save-Texture $c 'grenade_frame_ca'

# --- Heading block: 192x48 design px -> 512x128 -------------------------------

$c = New-Canvas 512 128 192
$g = $c.G

$outline = New-Path @(22,6, 170,6, 186,24, 170,42, 22,42, 6,24)
Add-Fill $g $outline
Add-Line $g $outline

# Heading marker (top center) and side ticks
$marker = New-Path @(90,6, 102,6, 96,13)
$brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
$g.FillPath($brush, $marker)
$brush.Dispose()
Add-Line $g (New-Path @(14,24, 24,24) $false) 1.2 200 $false
Add-Line $g (New-Path @(168,24, 178,24) $false) 1.2 200 $false
Add-Line $g (New-Path @(80,42, 112,42) $false) 3.5

Save-Texture $c 'dir_frame_ca'

# The visor crack (crack_ca.paa) is not generated: the hand-picked texture is kept as is.

# --- ACE menu icons: on / off switches, 512x512 -------------------------------

function New-Switch([bool]$On) {
    $c = New-Canvas 512 512 512
    $g = $c.G
    $pill = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $pill.AddArc(76, 166, 180, 180, 90, 180)
    $pill.AddArc(256, 166, 180, 180, 270, 180)
    $pill.CloseFigure()
    if ($On) {
        $brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 70, 190, 90))
        $g.FillPath($brush, $pill)
        $brush.Dispose()
        $knobX = 276
    } else {
        $pen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 200, 200, 200), 22)
        $g.DrawPath($pen, $pill)
        $pen.Dispose()
        $knobX = 106
    }
    $brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $g.FillEllipse($brush, $knobX, 191, 130, 130)
    $brush.Dispose()
    $c
}

$OutDir = Join-Path $OutDir '..'
Save-Texture (New-Switch $true) 'on_ca'
Save-Texture (New-Switch $false) 'off_ca'

# --- Mod logo -----------------------------------------------------------------
# logo_ca (transparent, 1024) is used by mod.cpp and the ACE menu,
# logo_co.jpg (dark background, 1536) is the Steam Workshop picture.

function Add-Logo($g) {
    $blue = [System.Drawing.Color]::FromArgb(255, 0, 114, 189)
    $light = [System.Drawing.Color]::FromArgb(255, 110, 205, 255)

    function Add-ColorLine($path, [double]$Width, $Color, [bool]$Glow = $true) {
        if ($Glow) {
            foreach ($halo in @(@(46.0, 16), @(26.0, 30), @(12.0, 55))) {
                $pen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb($halo[1], $Color), ($Width + $halo[0]))
                $pen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
                $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
                $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
                $g.DrawPath($pen, $path)
                $pen.Dispose()
            }
        }
        $pen = [System.Drawing.Pen]::new($Color, $Width)
        $pen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
        $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
        $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
        $g.DrawPath($pen, $path)
        $pen.Dispose()
    }

    # Frame: same cut-corner panel as the HUD blocks
    $frame = New-Path @(250,100, 924,100, 924,774, 774,924, 100,924, 100,250)
    Add-Fill $g $frame 215
    Add-ColorLine $frame 14 $blue
    Add-ColorLine (New-Path @(150,290, 290,150) $false) 8 $light $false
    Add-ColorLine (New-Path @(924,330, 924,560) $false) 30 $light
    foreach ($offset in 0, 44, 88) {
        Add-ColorLine (New-Path @((770 - $offset),880, (826 - $offset),824) $false) 8 $blue $false
    }
    foreach ($y in 440, 490, 540) {
        $brush = [System.Drawing.SolidBrush]::new($light)
        $g.FillRectangle($brush, 100, $y, 34, 12)
        $brush.Dispose()
    }

    # Angular T visor
    $visor = New-Path @(205,400, 819,400, 795,505, 598,528, 566,735, 458,735, 426,528, 229,505)
    Add-ColorLine $visor 10 $blue
    $gradient = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        [System.Drawing.PointF]::new(0, 395), [System.Drawing.PointF]::new(0, 740), $light, $blue)
    $g.FillPath($gradient, $visor)
    $gradient.Dispose()
    Add-ColorLine $visor 5 ([System.Drawing.Color]::White) $false

    # Heading marker above the visor
    $marker = New-Path @(482,300, 542,300, 512,338)
    $brush = [System.Drawing.SolidBrush]::new($light)
    $g.FillPath($brush, $marker)
    $brush.Dispose()
    Add-ColorLine (New-Path @(330,319, 440,319) $false) 6 $blue $false
    Add-ColorLine (New-Path @(584,319, 694,319) $false) 6 $blue $false
}

$root = Join-Path $PSScriptRoot '..'

# Transparent version
$c = New-Canvas 1024 1024 1024
Add-Logo $c.G
$c.G.Dispose()
$logoPng = Join-Path $root 'logo_ca.png'
$c.Bitmap.Save($logoPng, [System.Drawing.Imaging.ImageFormat]::Png)
$c.Bitmap.Dispose()
Write-Host "PNG  $logoPng"
if (-not $PreviewOnly) {
    foreach ($paa in (Join-Path $root 'logo_ca.paa'), (Join-Path $root 'addons\ui\data\logo_ca.paa')) {
        if (Test-Path $paa) { Remove-Item $paa }
        & hemtt utils paa convert $logoPng $paa | Out-Null
        if (-not (Test-Path $paa)) { throw "PAA conversion failed for $paa" }
        Write-Host "PAA  $paa"
    }
}

# Workshop version: dark background
$c = New-Canvas 1536 1536 1024
$background = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(0, 0), [System.Drawing.PointF]::new(0, 1024),
    [System.Drawing.Color]::FromArgb(255, 14, 22, 34), [System.Drawing.Color]::FromArgb(255, 4, 6, 10))
$c.G.FillRectangle($background, 0, 0, 1024, 1024)
$background.Dispose()
Add-Logo $c.G
$c.G.Dispose()
$logoJpg = Join-Path $root 'logo_co.jpg'
$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object MimeType -eq 'image/jpeg'
$quality = [System.Drawing.Imaging.EncoderParameters]::new(1)
$quality.Param[0] = [System.Drawing.Imaging.EncoderParameter]::new([System.Drawing.Imaging.Encoder]::Quality, [long]92)
$c.Bitmap.Save($logoJpg, $codec, $quality)
$c.Bitmap.Dispose()
Write-Host "JPG  $logoJpg"

# --- Health block: 256x64 design px -> 512x128 --------------------------------
# Mirror of the weapon block style (top left of the screen).

$OutDir = Join-Path $PSScriptRoot '..\addons\ui\data\hud'

$c = New-Canvas 512 128 256
$g = $c.G

$outline = New-Path @(5,5, 238,5, 251,18, 251,59, 18,59, 5,46)
Add-Fill $g $outline
Add-Line $g $outline

# Accent bar on the left edge
Add-Line $g (New-Path @(5,14, 5,38) $false) 3.5
# Double line on the top-right cut corner
Add-Line $g (New-Path @(236,10, 246,20) $false) 1 200 $false
# Bar tracks (two rows)
Add-Rect $g 92 18 104 6 38
Add-Rect $g 92 40 104 6 38
# Hatching next to the bottom-left cut corner
foreach ($offset in 0, 6) {
    Add-Line $g (New-Path @((22 + $offset),55, (28 + $offset),49) $false) 1 150 $false
}

Save-Texture $c 'health_frame_ca'
