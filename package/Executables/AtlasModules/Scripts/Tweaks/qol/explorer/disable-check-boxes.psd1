@{
    Name        = 'Disable Use Check Boxes to Select Items'
    Description = 'Turns off check boxes for selecting items in File Explorer.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'AutoCheckSelect'; Type = 'DWord'; Data = 0 }
    )
}
