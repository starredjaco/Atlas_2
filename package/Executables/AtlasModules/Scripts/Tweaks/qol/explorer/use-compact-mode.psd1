@{
    Name        = 'Use Compact Mode'
    Description = 'Uses compact view in File Explorer, which reduces the space between items.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'UseCompactMode'; Type = 'DWord'; Data = 1 }
    )
}
