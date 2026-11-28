# Atlas.Tweaks domain: tweak gating (Option / Arch / OnUpgrade / OnRebase / Since / MinBuild / MaxBuild).

function ConvertTo-AtlasTweakVersion {
    <#
    .SYNOPSIS
        Returns the major.minor.patch part of an Atlas version as a [version], ignoring
        a pre-release or build suffix, or $null when the text isn't a version.
    #>
    param([AllowNull()][string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return $null
    }
    $match = [regex]::Match($Value.Trim(), '^(\d+)\.(\d+)\.(\d+)(?:[-+].*)?$')
    if (-not $match.Success) {
        return $null
    }
    return [version]::new([int]$match.Groups[1].Value, [int]$match.Groups[2].Value, [int]$match.Groups[3].Value)
}

function Get-AtlasTweakSkipReason {
    <#
    .SYNOPSIS
        Returns a human-readable reason why a tweak does not apply to the current
        install context, or $null when it applies.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$Tweak,

        [psobject]$Context
    )

    $context = if ($PSBoundParameters.ContainsKey('Context')) {
        $Context
    }
    else {
        Get-AtlasContext
    }

    if ($Tweak.ContainsKey('Option') -and $Tweak['Option']) {
        $option = [string]$Tweak['Option']
        $optionSelected = if ($null -ne $context.PSObject.Properties['IsInstallStateBacked'] -and
            [bool]$context.IsInstallStateBacked) {
            @($context.Options) -ccontains $option
        }
        else {
            Test-AtlasOption -Name $option
        }
        if (-not $optionSelected) {
            return "option '$option' was not selected"
        }
    }

    if ($Tweak.ContainsKey('Arch') -and $Tweak['Arch']) {
        $arch = ([string]$Tweak['Arch']).ToUpperInvariant()
        if ($arch -eq 'ARM64' -and -not $context.IsArm64) {
            return 'requires an ARM64 machine'
        }
        if ($arch -eq 'X64' -and $context.IsArm64) {
            return 'requires an x64 machine'
        }
    }

    $onUpgrade = 'Both'
    if ($Tweak.ContainsKey('OnUpgrade') -and $Tweak['OnUpgrade']) {
        $onUpgrade = [string]$Tweak['OnUpgrade']
    }
    # A Rebase repeats the fresh-install tweaks that declare OnRebase = 'Run'.
    $rebase = $null -ne $context.PSObject.Properties['IsRebase'] -and [bool]$context.IsRebase
    $runsOnRebase = $Tweak.ContainsKey('OnRebase') -and [string]$Tweak['OnRebase'] -ceq 'Run'
    if ($onUpgrade -eq 'Skip' -and $context.IsUpgrade -and -not ($rebase -and $runsOnRebase)) {
        return 'skipped on upgrade installs'
    }
    if ($onUpgrade -eq 'Only' -and -not $context.IsUpgrade) {
        return 'runs only on upgrade installs'
    }
    # A preference applies once: on a fresh install, or on the update that first
    # includes it. After that the setting is the user's, and later updates leave it.
    if ($onUpgrade -eq 'Once' -and $context.IsUpgrade) {
        $since = ConvertTo-AtlasTweakVersion -Value ([string]$Tweak['Since'])
        $fromProperty = $context.PSObject.Properties['FromVersion']
        $fromText = if ($null -ne $fromProperty) { [string]$fromProperty.Value } else { '' }
        $from = ConvertTo-AtlasTweakVersion -Value $fromText
        if ($null -eq $since) {
            return "its Since version '$($Tweak['Since'])' isn't an Atlas version"
        }
        if ($null -eq $from) {
            return 'a preference applied once, and the Atlas version this update starts from is unknown'
        }
        if ($from -ge $since) {
            return "a preference applied once, which Atlas $fromText already included"
        }
    }


    # Windows build gating (inclusive). A build of 0 means the number could not be read;
    # the gate is then not enforced rather than silently skipping every gated tweak.
    if ($context.WindowsBuild -gt 0) {
        if ($Tweak.ContainsKey('MinBuild') -and $Tweak['MinBuild'] -and $context.WindowsBuild -lt [int]$Tweak['MinBuild']) {
            return "requires Windows build $($Tweak['MinBuild']) or newer"
        }
        if ($Tweak.ContainsKey('MaxBuild') -and $Tweak['MaxBuild'] -and $context.WindowsBuild -gt [int]$Tweak['MaxBuild']) {
            return "requires Windows build $($Tweak['MaxBuild']) or older"
        }
    }

    return $null
}

function Test-AtlasTweakApplicable {
    <#
    .SYNOPSIS
        Returns whether a tweak (loaded from its .psd1) applies to the current install
        context, evaluating its Option, Arch, OnUpgrade/OnRebase/Since and MinBuild/MaxBuild gates.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$Tweak,

        [psobject]$Context
    )

    $parameters = @{ Tweak = $Tweak }
    if ($PSBoundParameters.ContainsKey('Context')) {
        $parameters['Context'] = $Context
    }
    return ($null -eq (Get-AtlasTweakSkipReason @parameters))
}
