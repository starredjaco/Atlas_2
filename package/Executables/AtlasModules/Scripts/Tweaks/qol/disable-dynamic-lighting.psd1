@{
    Name        = 'Disable Dynamic Lighting'
    Description = 'Turns off Dynamic Lighting, which lets Windows control the RGB lighting on compatible devices.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\Software\Microsoft\Lighting'; Name = 'AmbientLightingEnabled'; Type = 'DWord'; Data = 0 }
    )
}
