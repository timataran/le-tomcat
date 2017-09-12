#!/bin/sh

# Initialize variables
. ./params

echo "Do authorization"
./sub-do_authorization.sh

echo "Request certificate renewal and download certificate"
java -jar acme_client.jar --command renew-certificate -a cert/account.key \
  -w work/ --csr cert/domain.csr \
  --cert-dir cert/ \
  -u $CA_SERVER \
  --with-agreement-update \
  --log-dir log/ --log-level TRACE

echo "Create java keystore with new certificate"
./sub-convert_certs.sh

echo "Done !!!!"
