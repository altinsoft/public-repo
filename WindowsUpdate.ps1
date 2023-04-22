$updateSession = New-Object -ComObject "Microsoft.Update.Session"
$updateSearcher = $updateSession.CreateUpdateSearcher()

# Güncellemeleri kontrol et
$updatesToInstall = New-Object -ComObject "Microsoft.Update.UpdateColl"
$searchResult = $updateSearcher.Search("IsInstalled=0 and Type='Software' and IsHidden=0")

# İndirilmiş güncellemeleri belirle
if ($searchResult.Updates.Count -gt 0) {
    foreach ($update in $searchResult.Updates) {
        if ($update.IsDownloaded) {
            $updatesToInstall.Add($update) | Out-Null
        }
    }
} else {
    Write-Host "No updates available"
    Exit
}

# İndirilmiş güncellemeleri yükle
if ($updatesToInstall.Count -gt 0) {
    $installer = $updateSession.CreateUpdateInstaller()
    $installer.Updates = $updatesToInstall
    $installationResult = $installer.Install()
    
    if ($installationResult.ResultCode -eq 2) {
        Write-Host "Updates installed successfully"
    } else {
        Write-Host "Updates installation failed"
    }
} else {
    Write-Host "No updates were downloaded"
}
