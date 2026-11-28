@{
    Name        = 'Disable AutoRun'
    Description = 'Turns off AutoPlay, so Windows takes no action when you connect a drive, phone or camera.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers'; Name = 'DisableAutoplay'; Type = 'DWord'; Data = 1 }
        @{ Path = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\CameraAlternate'; Name = 'MSTakeNoAction'; Type = 'None' }
        @{ Path = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\StorageOnArrival'; Name = 'MSTakeNoAction'; Type = 'None' }
        @{ Path = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\CameraAlternate\ShowPicturesOnArrival'; Name = 'MSTakeNoAction'; Type = 'None' }
        @{ Path = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\StorageOnArrival'; Name = 'MSTakeNoAction'; Type = 'None' }
    )
}
