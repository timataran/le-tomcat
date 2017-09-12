@echo off

rem Initialize variables
call params.bat

echo "Do authorization"
call sub-do_authorization.bat

echo "Request certificate renewal and download certificate"
java -jar acme_client.jar --command renew-certificate ^
  -a cert\account.key ^
  -w work ^
  --csr cert\domain.csr ^
  --cert-dir cert ^
  -u %CA_SERVER% ^
  --with-agreement-update ^
  --log-dir log --log-level TRACE

echo "Create java keystore with new certificate"
call sub-convert_certs.bat

echo "Done !!!!"