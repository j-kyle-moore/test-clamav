#!/bin/bash
#https://two-oes.medium.com/working-with-openssl-and-dns-alternative-names-367f06a23841
#when creating by copying into terminal window:
#export HOST=rke2agent2

#when running as a bash script, chmod this file to 775 and run with a ./create_certs.sh instead of sh create_certs.sh
DOMAIN=km.test
HOST=docker

#Create CA:
#openssl genrsa -out /etc/pki/tls/certs/kmtest_ca/km_test_ca.key 4096
#openssl req -new -x509 -key /etc/pki/tls/certs/kmtest_ca/km_test_ca.key -days 3650 -out /etc/pki/tls/certs/kmtest_ca/km_test_ca.crt -config <( cat /etc/pki/tls/certs/kmtest_ca/openssl_kmtest_ca_answer_file.txt )
#openssl x509 -noout -text -in /etc/pki/tls/certs/kmtest_ca/km_test_ca.crt

#Create Host Cert Request:
openssl genrsa -out /etc/pki/tls/certs/${HOST}/${HOST}.key 4096
openssl req -new -key /etc/pki/tls/certs/${HOST}/${HOST}.key -out /etc/pki/tls/certs/${HOST}/${HOST}.csr -config <(cat /etc/pki/tls/certs/${HOST}/openssl_${HOST}_answer_file.txt)

#Verify the CSR:
#openssl req -in /etc/pki/tls/certs/${HOST}.csr -noout -text
openssl req -in /etc/pki/tls/certs/${HOST}/${HOST}.csr -noout -text | grep DNS

#Sign the CSR:
openssl x509 -req -in /etc/pki/tls/certs/${HOST}/${HOST}.csr -CA /etc/pki/tls/certs/kmtest_ca/km_test_ca.crt -CAkey /etc/pki/tls/certs/kmtest_ca/km_test_ca.key -CAcreateserial -out /etc/pki/tls/certs/${HOST}/${HOST}.crt -days 3650 -extensions 'req_ext' -extfile <(cat /etc/pki/tls/certs/${HOST}/openssl_${HOST}_answer_file.txt)

#Verify the certificate:
#openssl x509 -noout -text -in /etc/pki/tls/certs/${HOST}.crt
openssl x509 -noout -text -in /etc/pki/tls/certs/${HOST}/${HOST}.crt | grep DNS

#Create the certificate bundle:
cat /etc/pki/tls/certs/${HOST}/${HOST}.crt /etc/pki/tls/certs/kmtest_ca/km_test_ca.crt > /etc/pki/tls/certs/${HOST}/${HOST}.ca_bundle.crt

#Verify the certificate bundle:
openssl verify -CAfile /etc/pki/tls/certs/kmtest_ca/km_test_ca.crt /etc/pki/tls/certs/${HOST}/${HOST}.ca_bundle.crt

#update the OS Registry
cp /etc/pki/tls/certs/kmtest_ca/km_test_ca.crt /etc/pki/ca-trust/source/anchors/${HOST}.ca_bundle.crt
update-ca-trust extract
