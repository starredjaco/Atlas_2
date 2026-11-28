@{
    Name        = 'Don''t Show Office Files'
    Description = 'Stops Home in File Explorer showing files from Office.com.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer'; Name = 'ShowCloudFilesInQuickAccess'; Type = 'DWord'; Data = 0 }
    )
}
