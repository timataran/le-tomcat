@echo off

rem Initialize variables
call params.bat

rem Create pkcs12 keystore
openssl pkcs12 -export -name %KEY_ALIAS% ^
  -in cert/fullchain.pem ^
  -inkey cert/domain.key ^
  -out work/tmpks.p12 ^
  -passout pass:%STORE_PASS%

del /F %JKS_FILE%

rem  Convert pkcs12 to java keystore
keytool -importkeystore ^
  -destkeystore %JKS_FILE% ^
  -srckeystore work/tmpks.p12 ^
  -srcstorepass %STORE_PASS% ^
  -srcstoretype pkcs12 ^
  -deststorepass %STORE_PASS% ^
  -alias %KEY_ALIAS%

