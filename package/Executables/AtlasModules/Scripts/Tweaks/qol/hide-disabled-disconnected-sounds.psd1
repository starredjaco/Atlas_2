@{
    Name        = 'Hide Disabled and Disconnected Devices in Sounds Panel'
    Description = 'Hides disabled and disconnected devices in the Sound control panel (mmsys.cpl).'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\SOFTWARE\Microsoft\Multimedia\Audio\DeviceCpl'; Name = 'ShowDisconnectedDevices'; Type = 'DWord'; Data = 0 }
        @{ Path = 'HKCU\SOFTWARE\Microsoft\Multimedia\Audio\DeviceCpl'; Name = 'ShowHiddenDevices'; Type = 'DWord'; Data = 0 }
    )
}
