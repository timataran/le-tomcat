@echo off
rem Production Letsencrypt server
rem set "CA_SERVER=https://acme-v01.api.letsencrypt.org/directory"

rem Staging (for tests) Letsencrypt server
set "CA_SERVER=https://acme-staging.api.letsencrypt.org/directory"

set "KEYSIZE=4096"

rem Certificate params
set "COUNTRY=UA"
set "STATE=Unknown"
set "LOCATION=Unknown"
set "ORGANIZATION=Unknown"
set "UNIT=Unknown"
set "CN=some.domain.com"
set "EMAIL=admin@some.domain.com"

set "SSL_CONFIG=domain-ssl.cnf"

rem The domain names list with -d key before each name to use it as parameter of acme_client.jar
set "DOMAINS_PARAM=-d some.domain.com -d www.some.domain.com"

rem Path to tomcat root (without trailing slash)
set "TOMCAT_ROOT=d:\tomcat"

rem JKS file which is used by tomcat and other store parameters
set "JKS_FILE=d:\letomcat\.keystore"
set "STORE_PASS=my-cool-password"
set "KEY_ALIAS=somedomain"
