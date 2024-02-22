#Last 4 Hours of Downloaded Files - VersionInfo + LastWriteTimeUtc + Zone.Identifier - Most Recent First
$d = @(Get-ChildItem C:\Users\*\Downloads\*.* -Force -EA 0 | ?{$_.LastWriteTimeUtc -gt [DateTime]::UtcNow.AddHours(-4)} | Sort LastWriteTimeUtc -Desc)
ForEach ($i in $d) {
    Write-Output ''
    'LastWriteTimeUtc : '+$i.LastWriteTimeUtc.DateTime
    $i.VersionInfo | Select FileName,OriginalFileName,InternalName,FileDescription,Productname,CompanyName,Comments
    Get-Content $i.FullName -Stream Zone.Identifier -Force -EA 0
    Write-Output ''
    }
