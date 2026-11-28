@{
    Name        = 'Disable Accessibility Tool Shortcut'
    Description = 'Turns off the shortcut that opens accessibility tools with the Windows logo key and Volume Up, labelled "Make touch and tablets easier to use".'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\Control Panel\Accessibility\SlateLaunch'; Name = 'LaunchAT'; Type = 'DWord'; Data = 0 }
    )
}
