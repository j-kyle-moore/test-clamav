ARG BASE_REGISTRY=registry1.dso.mil
ARG BASE_IMAGE=ironbank/opensource/apache/apache2
ARG BASE_TAG=2.4.37

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

USER root

# Upgrade first
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm --nogpgcheck \
    && dnf upgrade -y --disableplugin=subscription-manager --nodocs \
#    && dnf install httpd -y \
    && dnf clean all

ARG CA_CERT_LOC=/etc/pki/ca-trust/source/anchors/
ARG CERT_BASE_DIR=/etc/pki/tls/certs/
ARG CERT_KEY_BASE_DIR=/etc/pki/tls/private/

# Copy and install CA cert
COPY certs/kmtest_ca/km_test_ca.crt $CA_CERT_LOC
RUN update-ca-trust extract

# Copy machine cert and key
COPY --chown=apache:apache certs/star-rke2-app/star-rke2-app.crt $CERT_BASE_DIR
COPY --chown=apache:apache certs/star-rke2-app/star-rke2-app.key $CERT_KEY_BASE_DIR

# link the certs to file names the container requires
RUN ln -s $CERT_BASE_DIR/star-rke2-app.crt $CERT_BASE_DIR/localhost.crt
RUN ln -s $CERT_KEY_BASE_DIR/star-rke2-app.key $CERT_KEY_BASE_DIR/localhost.key
