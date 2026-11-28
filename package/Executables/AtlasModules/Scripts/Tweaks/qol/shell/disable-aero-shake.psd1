@{
    Name        = 'Disable Aero Shake'
    Description = 'Turns off Aero Shake, which minimises all other windows when you shake a window and is easy to trigger by accident.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'DisallowShaking'; Type = 'DWord'; Data = 1 }
    )
}
