# Companion of register-user-upgrade.psd1.
$ErrorActionPreference = 'Stop'

# Update-AtlasUser brings every other account up to date at its next sign-in; the
# installing account's own pass runs during the install. With no other account, the
# sign-in entry would only start PowerShell at every sign-in, so it's removed instead.
$runPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
$runName = 'AtlasUserUpgrade'
$installingSid = [string](Get-AtlasContext).InteractiveUserSid
$profileListPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList'
$otherAccounts = @(Get-ChildItem -LiteralPath $profileListPath -ErrorAction Stop | Where-Object {
        $_.PSChildName -match '^S-1-(5-21|12-1)-\d+-\d+-\d+-\d+$' -and $_.PSChildName -cne $installingSid
    })

if ($otherAccounts.Count -eq 0) {
    Remove-AtlasRegistryValue -Path $runPath -Name $runName
    Write-AtlasLog -Message 'No other account needs this update at sign-in, so the AtlasUserUpgrade sign-in entry is removed.'
    return
}

Set-AtlasRegistryValue -Path $runPath -Name $runName -Type ExpandString `
    -Data '"%windir%\System32\wscript.exe" "%windir%\AtlasModules\Scripts\Entry\Invoke-AtlasUserUpgradeHidden.vbs"'
Write-AtlasLog -Message "$($otherAccounts.Count) other account(s) get this update at their next sign-in."
