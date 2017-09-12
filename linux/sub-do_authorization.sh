#!/bin/sh

# Initialize variables
. ./params

echo "Remove old challenge files"
rm -f work/well-known/challenge/*

echo "Request challenges and download them"
java -jar acme_client.jar --command authorize-domains -a cert/account.key \
  -w work/ $DOMAINS_PARAM \
  --well-known-dir work/well-known/challenge \
  --with-agreement-update \
  --one-dir-for-well-known \
  -u $CA_SERVER \
  --log-dir log/ --log-level TRACE

echo "Copy challenges to tomcat"
CHALLENGE_LOCATION=$TOMCAT_ROOT/webapps/ROOT/.well-known/acme-challenge
mkdir -p $CHALLENGE_LOCATION
rm -f $CHALLENGE_LOCATION/*
cp work/well-known/challenge/* $CHALLENGE_LOCATION/

echo Verify the challenges
java -jar acme_client.jar --command verify-domains -a cert/account.key \
  -w work/ $DOMAINS_PARAM \
  -u $CA_SERVER \
  --with-agreement-update \
  --log-dir log/ --log-level TRACE
