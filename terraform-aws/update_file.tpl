@echo off
setlocal

rem Define variables
set "key_path={$path}"
set "remote_user=ubuntu"
set "remote_ip={$nodeip}"
set "remote_path=/etc/rancher/k3s/k3s.yaml"
set "local_path={$k3s-path}\k3s-{$nodename}.yaml"
set "old_ip=127.0.0.1"
set "new_ip=%remote_ip%"

rem Transfer the file using scp
scp -i "%key_path%" -o StrictHostKeyChecking=no -o UserKnownHostsFile=NUL -q %remote_user%@%remote_ip%:%remote_path% "%local_path%"

rem Replace the IP address in the file using PowerShell
powershell -Command "(Get-Content '%local_path%') -replace '127.0.0.1', '%new_ip%' | Set-Content '%local_path%'"

endlocal
