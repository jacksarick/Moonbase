#!/bin/bash

# This file was re-used from [beachball](https://github.com/jacksarick/beachball)

mkdir cert
cd cert
openssl genrsa -out certificate.key 4096
openssl req -new -key certificate.key -out csr.pem
openssl x509 -req -in csr.pem -signkey certificate.key -out certificate.crt