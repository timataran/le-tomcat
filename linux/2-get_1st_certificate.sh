#!/bin/sh

# Initialize variables
. ./params

echo "Remove old cert files"
rm cert/domain.key cert/domain.csr

echo "Generate a private domain key"
openssl genrsa -out cert/domain.key $KEYSIZE

echo "Generate a Certificate Signing Request (CSR)"
openssl req -config $SSL_CONFIG -new -key cert/domain.key -sha256 -nodes \
        -subj "/C=$COUNTRY/ST=$STATE/L=$LOCATION/O=$ORGANIZATION/OU=$UNIT/CN=$CN/emailAddress=$EMAIL" \
                -outform PEM -out cert/domain.csr

echo "Do authorization"
./sub-do_authorization.sh

echo "Generate certificate and download it"
java -jar acme_client.jar --command generate-certificate -a cert/account.key \
  -w work/ --csr cert/domain.csr \
    --cert-dir cert/ \
    -u $CA_SERVER \
    --with-agreement-update \
    --log-dir log/ --log-level TRACE

echo "Create java keystore with new certificate"
./sub-convert_certs.sh

echo "Done !!!!"
