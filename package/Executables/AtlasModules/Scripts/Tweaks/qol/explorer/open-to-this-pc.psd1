@{
    Name        = 'Open File Explorer to This PC'
    Description = 'Opens File Explorer to This PC instead of Quick Access.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'LaunchTo'; Type = 'DWord'; Data = 1 }
    )
}
