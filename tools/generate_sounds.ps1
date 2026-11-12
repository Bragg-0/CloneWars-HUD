<#
.SYNOPSIS
    Synthesizes the HUD sounds and converts them to OGG.

.DESCRIPTION
    The sounds are original: pure synthesis (sine tones, sweeps and noise), no external audio file.
    The noise generator is seeded, the output is identical on every run.

    Usage (from the repository root, requires hemtt in PATH):
        pwsh tools/generate_sounds.ps1
        pwsh tools/generate_sounds.ps1 -PreviewOnly   # WAV only, in .hemttout/sounds
#>
param(
    [string]$OutDir = (Join-Path $PSScriptRoot '..\addons\ui\data\sounds'),
    [string]$WavDir = (Join-Path $PSScriptRoot '..\.hemttout\sounds'),
    [switch]$PreviewOnly
)

$ErrorActionPreference = 'Stop'
$SampleRate = 44100

New-Item -ItemType Directory -Force $WavDir | Out-Null
New-Item -ItemType Directory -Force $OutDir | Out-Null

$random = [System.Random]::new(501)

# --- Synthesis helpers -------------------------------------------------------

function New-Buffer([double]$Seconds) {
    , [double[]]::new([int]($Seconds * $SampleRate))
}

# Adds a tone sweeping from $FromHz to $ToHz, with a short attack and an exponential or linear release
function Add-Tone([double[]]$Buffer, [double]$Start, [double]$Duration, [double]$FromHz, [double]$ToHz,
                  [double]$Volume = 0.5, [double]$Decay = 0, [double]$Harmonics = 0) {
    $first = [int]($Start * $SampleRate)
    $count = [int]($Duration * $SampleRate)
    $attack = [Math]::Min(0.005 * $SampleRate, $count / 4)
    $release = [Math]::Min(0.012 * $SampleRate, $count / 3)
    $phase = 0.0
    for ($i = 0; $i -lt $count -and ($first + $i) -lt $Buffer.Length; $i++) {
        $progress = $i / $count
        $frequency = $FromHz + ($ToHz - $FromHz) * $progress
        $phase += 2 * [Math]::PI * $frequency / $SampleRate
        $envelope = 1.0
        if ($i -lt $attack) { $envelope = $i / $attack }
        if ($i -gt $count - $release) { $envelope = ($count - $i) / $release }
        if ($Decay -gt 0) { $envelope *= [Math]::Exp(-$Decay * $progress) }
        $sample = [Math]::Sin($phase)
        if ($Harmonics -gt 0) {
            # A touch of odd harmonics for a more "electronic" tone
            $sample += $Harmonics * [Math]::Sin(3 * $phase) / 3 + $Harmonics * [Math]::Sin(5 * $phase) / 5
        }
        $Buffer[$first + $i] += $sample * $envelope * $Volume
    }
}

# Adds a burst of sample-and-hold noise (lower $HoldSamples = brighter)
function Add-Noise([double[]]$Buffer, [double]$Start, [double]$Duration, [double]$Volume = 0.4, [int]$HoldSamples = 4) {
    $first = [int]($Start * $SampleRate)
    $count = [int]($Duration * $SampleRate)
    $release = [Math]::Min(0.004 * $SampleRate, $count / 3)
    $value = 0.0
    for ($i = 0; $i -lt $count -and ($first + $i) -lt $Buffer.Length; $i++) {
        if ($i % $HoldSamples -eq 0) { $value = $random.NextDouble() * 2 - 1 }
        $envelope = 1.0
        if ($i -lt $release) { $envelope = $i / $release }
        if ($i -gt $count - $release) { $envelope = ($count - $i) / $release }
        $Buffer[$first + $i] += $value * $envelope * $Volume
    }
}

function Save-Sound([double[]]$Buffer, [string]$Name) {
    $wav = Join-Path $WavDir "$Name.wav"
    $stream = [System.IO.File]::Create($wav)
    $writer = [System.IO.BinaryWriter]::new($stream)
    $dataSize = $Buffer.Length * 2
    # 16-bit mono PCM header
    $writer.Write([System.Text.Encoding]::ASCII.GetBytes('RIFF'))
    $writer.Write([int](36 + $dataSize))
    $writer.Write([System.Text.Encoding]::ASCII.GetBytes('WAVEfmt '))
    $writer.Write([int]16); $writer.Write([int16]1); $writer.Write([int16]1)
    $writer.Write([int]$SampleRate); $writer.Write([int]($SampleRate * 2))
    $writer.Write([int16]2); $writer.Write([int16]16)
    $writer.Write([System.Text.Encoding]::ASCII.GetBytes('data'))
    $writer.Write([int]$dataSize)
    foreach ($sample in $Buffer) {
        $clamped = [Math]::Max(-1.0, [Math]::Min(1.0, $sample))
        $writer.Write([int16]($clamped * 32000))
    }
    $writer.Dispose()
    $stream.Dispose()
    Write-Host "WAV  $wav"
    if (-not $PreviewOnly) {
        $ogg = Join-Path $OutDir "$Name.ogg"
        if (Test-Path $ogg) { Remove-Item $ogg }
        & hemtt utils audio convert $wav $ogg | Out-Null
        if (-not (Test-Path $ogg)) { throw "OGG conversion failed for $Name" }
        Write-Host "OGG  $ogg"
    }
}

# --- Boot: soft rising sweep with three ascending blips -----------------------

$b = New-Buffer 0.95
Add-Tone $b 0.00 0.70 180 900 0.16 1.5 0.4
Add-Tone $b 0.08 0.07 660 660 0.32 0 0.3
Add-Tone $b 0.26 0.07 880 880 0.32 0 0.3
Add-Tone $b 0.44 0.07 1175 1175 0.32 0 0.3
Add-Tone $b 0.62 0.28 1568 1568 0.30 4 0.2
Add-Noise $b 0.00 0.05 0.10 2
Save-Sound $b 'boot'

# --- Shutdown: falling sweep with two descending blips ------------------------

$b = New-Buffer 0.6
Add-Tone $b 0.00 0.07 1175 1175 0.30 0 0.3
Add-Tone $b 0.12 0.07 784 784 0.30 0 0.3
Add-Tone $b 0.22 0.36 700 110 0.26 3 0.5
Save-Sound $b 'shutdown'

# --- Glitch: gated static with a low buzz --------------------------------------

$b = New-Buffer 0.36
$time = 0.0
while ($time -lt 0.32) {
    $length = 0.012 + $random.NextDouble() * 0.045
    if ($random.NextDouble() -lt 0.7) {
        Add-Noise $b $time $length (0.22 + $random.NextDouble() * 0.2) (1 + $random.Next(10))
    }
    $time += $length + $random.NextDouble() * 0.02
}
Add-Tone $b 0.00 0.30 95 70 0.20 2 1
Add-Tone $b 0.05 0.03 2400 1800 0.10
Add-Tone $b 0.19 0.02 3100 2600 0.08
Save-Sound $b 'glitch'

# --- Warning (low ammo): two short beeps ---------------------------------------

$b = New-Buffer 0.26
Add-Tone $b 0.00 0.08 988 988 0.34 0 0.3
Add-Tone $b 0.13 0.08 988 988 0.34 0 0.3
Save-Sound $b 'warning'

# --- Alert (empty magazine, cracked HUD): three fast beeps and a low one -------

$b = New-Buffer 0.5
Add-Tone $b 0.00 0.05 1397 1397 0.34 0 0.4
Add-Tone $b 0.08 0.05 1397 1397 0.34 0 0.4
Add-Tone $b 0.16 0.05 1397 1397 0.34 0 0.4
Add-Tone $b 0.26 0.20 698 660 0.34 2 0.5
Save-Sound $b 'alert'

# --- Confirm (HUD repaired): two rising notes ----------------------------------

$b = New-Buffer 0.4
Add-Tone $b 0.00 0.09 880 880 0.32 0 0.3
Add-Tone $b 0.11 0.26 1319 1319 0.32 4 0.2
Save-Sound $b 'confirm'
