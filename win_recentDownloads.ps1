$d = @(Get-ChildItem C:\Users\*\Downloads\*.* -Force -EA 0 | ?{$_.LastWriteTimeUtc -gt [DateTime]::UtcNow.AddHours(-4)} | Sort LastWriteTimeUtc -Desc)
if (!$d) {
    Write-Output '[-] No files written to downloads over the last 4 hours.'
}
else {
    ForEach ($i in $d) {
        Write-Output ''
        'LastWriteTimeUtc : '+$i.LastWriteTimeUtc.DateTime
        $i.VersionInfo | Select FileName,OriginalFileName,InternalName,FileDescription,Productname,CompanyName,Comments
        Get-Content $i.FullName -Stream Zone.Identifier -Force -EA 0
        Write-Output ''
        }
}
