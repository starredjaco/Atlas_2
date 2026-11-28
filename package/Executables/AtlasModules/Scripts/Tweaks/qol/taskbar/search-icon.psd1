@{
    Name        = 'Show Search as an Icon on the Taskbar'
    Description = 'Shows search on the taskbar as an icon instead of a search box.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        # Windows can protect these values; the search box then stays as it was.
        @{ Path = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search'; Name = 'SearchboxTaskbarMode'; Type = 'DWord'; Data = 1; AllowOsProtected = $true }
        @{ Path = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search'; Name = 'SearchboxTaskbarModeCache'; Type = 'DWord'; Data = 1; AllowOsProtected = $true }
    )
}
