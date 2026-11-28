@{
    Name        = 'Show More Pins in Start'
    Description = 'Shows more pins in Start and fewer recommendations.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'Start_Layout'; Type = 'DWord'; Data = 1 }
    )
}
