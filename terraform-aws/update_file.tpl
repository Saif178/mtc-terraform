@echo off
setlocal

rem Define variables
set "key_path={$path}"
set "remote_user=ubuntu"
set "remote_ip={$nodeip}"
set "remote_path=/etc/rancher/k3s/k3s.yaml"
set "local_path={$k3s-path}\k3s-{$nodename}.yaml"
set "old_ip=127.0.0.1"
set "new_ip={$nodeip}"

rem Transfer the file using scp
scp -i "%key_path%" -o StrictHostKeyChecking=no -o UserKnownHostsFile=NUL -q %remote_user%@%remote_ip%:%remote_path% "%local_path%"

rem Replace the IP address in the file
set "temp_file=%local_path%.tmp"
(for /f "delims=" %%i in (%local_path%) do @echo %%i) > "%temp_file%"
move /y "%temp_file%" "%local_path%"

rem Replace IP address
powershell -Command "(Get-Content '%local_path%') -replace '%old_ip%', '%new_ip%' | Set-Content '%local_path%'"

endlocal
