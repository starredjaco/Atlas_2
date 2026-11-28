@{
    Name        = 'Add ''End task'' to the taskbar'
    Description = 'Adds End task to the right-click menu of apps on the taskbar.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings'; Name = 'TaskbarEndTask'; Type = 'DWord'; Data = 1 }
    )
}
