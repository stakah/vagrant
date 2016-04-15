#!/bin/sh

# Provision OpenSSL Certificates
# https://blog.didierstevens.com/2008/12/30/howto-make-your-own-cert-with-openssl/

echo ${0}

# First we generate a 4096-bit long RSA key for our root CA and store it in file ca.key
openssl genrsa -out ca.key 4096 -config openssl.config 2>/dev/null

# Next, we create our self-signed root CA certificate ca.crt; you’ll need to provide an identity for your root CA
openssl req -new -x509 -days 1826 -key ca.key -out ca.crt -config openssl.config 2>/dev/null

# Next step: create our subordinate CA that will be used for the actual signing. First, generate the key

openssl genrsa -out ia.key 4096 -config openssl.config 2>/dev/null

# Then, request a certificate for this subordinate CA:

openssl req -new -key ia.key -out ia.csr -config openssl.config 2>/dev/null

# Next step: process the request for the subordinate CA certificate and get it signed by the root CA.

openssl x509 -req -days 730 -in ia.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out ia.crt 2>/dev/null

# To use this subordinate CA key for Authenticode signatures with Microsoft’s signtool, you’ll have to package the keys and certs in a PKCS12 file:

# openssl pkcs12 -export -out ia.p12 -inkey ia.key -in ia.crt -chain -CAfile ca.crt


