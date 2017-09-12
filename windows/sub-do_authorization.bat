@echo off

rem Initialize variables
call params.bat

echo "Remove old challenge files"
del /F /Q work\well-known\challenge\*

echo "Request challenges and download them"
java -jar acme_client.jar --command authorize-domains ^
  -a cert\account.key -w work %DOMAINS_PARAM% ^
  --well-known-dir work\well-known\challenge ^
  --with-agreement-update ^
  --one-dir-for-well-known ^
  -u %CA_SERVER% ^
  --log-dir log --log-level TRACE

echo "Copy challenges to tomcat"
set "CHALLENGE_LOCATION=%TOMCAT_ROOT%\webapps\ROOT\.well-known\acme-challenge"
mkdir %CHALLENGE_LOCATION%
del /F /Q %CHALLENGE_LOCATION%\*
copy work\well-known\challenge\* %CHALLENGE_LOCATION%

echo "Verify the challenges"
java -jar acme_client.jar --command verify-domains ^
  -a cert\account.key ^
  -w work %DOMAINS_PARAM% ^
  -u %CA_SERVER% ^
  --with-agreement-update ^
  --log-dir log --log-level TRACE