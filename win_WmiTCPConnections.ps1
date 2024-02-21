#Active TCP Network Connections - WMI ROOT\StandardCIMV2 Namespace
$connections=@(Get-WmiObject -Namespace ROOT\StandardCIMV2 -Class MSFT_NetTCPConnection -Computer ::1 | ?{$_.RemoteAddress -notin @("0.0.0.0","127.0.0.1","::1","::")} | Sort-Object -Property ProceessCreationTime -Desc) 
''
ForEach ($connection in $connections) {
    $procUser = (Get-Process -Id $connection.OwningProcess -IncludeUserName | Select-Object -exp UserName)
    $procName = ((Get-Process -Id $connection.OwningProcess | Select-Object -exp Name))
    if (!$procUser) {
        $procUser = 'NULL'
    }
    ' [{0} | {1} | {2}] - Connected {3}:{4} --> {5}:{6}' -f ($procName, $procUser, $connection.OwningProcess,  $connection.LocalAddress, $connection.LocalPort, $connection.RemoteAddress, $connection.RemotePort)
