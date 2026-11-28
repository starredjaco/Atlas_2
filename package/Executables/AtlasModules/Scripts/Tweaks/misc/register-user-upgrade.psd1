@{
    Name        = 'Register user upgrade migration'
    Description = 'Updates the other accounts to the installed version at their next sign-in, keeping their desktop layout. On a PC with no other account, it removes the sign-in entry instead.'
    OnUpgrade   = 'Only'
    Script      = 'register-user-upgrade.ps1'
}
