@{
    Name        = 'Set Taskbar to Align Left'
    Description = 'Aligns the taskbar to the left instead of the centre.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'TaskbarAl'; Type = 'DWord'; Data = 0 }
    )
}
