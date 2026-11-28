@{
    Name        = 'Set Unpinned Control Center Items'
    Description = 'Unpins rarely used buttons, such as Cast and Nearby Sharing, from Quick Settings.'
    OnUpgrade   = 'Once'
    Since       = '0.4.1'
    Registry    = @(
        @{ Path = 'HKCU\Control Panel\Quick Actions\Control Center\Unpinned'; Name = 'Microsoft.QuickAction.Cast'; Type = 'None' }
        @{ Path = 'HKCU\Control Panel\Quick Actions\Control Center\Unpinned'; Name = 'Microsoft.QuickAction.NearShare'; Type = 'None' }
        @{ Path = 'HKCU\Control Panel\Quick Actions\Control Center\QuickActionsStateCapture'; Name = 'Toggles'; Type = 'String'; Data = 'Toggles,Microsoft.QuickAction.BlueLightReduction:false,Microsoft.QuickAction.Accessibility:false,Microsoft.QuickAction.ProjectL2:false' }
    )
    # Reload the user's shell only after the signed-in user's HKCU pass succeeds.
    PostUserRegistryRefresh = 'ExplorerRefresh'
}
