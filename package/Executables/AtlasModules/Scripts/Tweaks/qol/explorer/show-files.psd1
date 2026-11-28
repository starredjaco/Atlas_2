@{
    Name        = 'Configure Explorer to Show All Files with File Extensions'
    Description = 'Shows hidden files and file name extensions in File Explorer, so disguised files such as invoice.pdf.exe are easier to spot.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'Hidden'; Type = 'DWord'; Data = 1 }
        @{ Path = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'HideFileExt'; Type = 'DWord'; Data = 0 }
    )
}
