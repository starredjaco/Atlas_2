@{
    Name        = 'Show More Details by Default on Transfers'
    Description = 'Shows the detailed view of file transfers by default, with the speed of each copy, move or delete.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager'; Name = 'EnthusiastMode'; Type = 'DWord'; Data = 1 }
    )
}
