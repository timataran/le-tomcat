#!/bin/bash

# Initialize variables
. ./params

# Create client key
openssl genrsa -out cert/account.key $KEYSIZE

# Run acme_client "register" command
java -jar ./acme_client.jar --command register -a cert/account.key \
     --with-agreement-update --email $EMAIL \
     -u $CA_SERVER \
     --log-dir log/ --log-level TRACE