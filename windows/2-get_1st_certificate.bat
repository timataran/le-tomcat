@echo off

rem Initialize variables
call params.bat

echo "Remove old cert files"
del /F cert\domain.key cert\domain.csr
 
echo "Generage a private domain key"
call openssl genrsa -out cert\domain.key %KEYSIZE%

echo "Generage a Certificate Signing Request (CSR)"
call openssl req -config %SSL_CONFIG% -new ^
  -key cert\domain.key -sha256 -nodes ^
  -subj "/C=%COUNTRY%/ST=%STATE%/L=%LOCATION%/O=%ORGANIZATION%/OU=%UNIT%/CN=%CN%/emailAddress=%EMAIL%" ^
  -outform PEM -out cert\domain.csr

echo "Do authorization"
call sub-do_authorization.bat

echo "Generate certificate and download it"
java -jar acme_client.jar --command generate-certificate ^
  -a cert\account.key ^
  -w work ^
  --csr cert\domain.csr ^
  --cert-dir cert ^
  -u %CA_SERVER%
  --with-agreement-update ^
  --log-dir log --log-level TRACE

echo "Create java keystore with new certificate"
call sub-convert_certs.bat

echo "Done !!!!"