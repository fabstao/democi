#!/bin/bash

VER=6
baseimage="quay.io/fabstao/centos8-jdk11"
micont=$(buildah from ${baseimage})

buildah config --label maintainer="Fabian Salamanca <fsalamanca@ibm.com>" ${micont}
buildah config --author "Fabian Salamanca <fsalamanca@ibm.com>" ${micont}

# Install packages

buildah copy ${micont} ./check.sh /usr/bin

# Image configuration

buildah config --user jenkins ${micont}
buildah config --entrypoint /usr/bin/check.sh ${micont}
#buildah config --port 8080

buildah commit ${micont} quay.io/fabstao/tslave2

buildah tag quay.io/fabstao/tslave2 quay.io/fabstao/tslave2:${VER}
buildah tag quay.io/fabstao/tslave2:${VER} quay.io/fabstao/tslave2:latest

echo "Subiendo imagen"
echo
buildah login quay.io
buildah push quay.io/fabstao/tslave2:${VER}
buildah push quay.io/fabstao/tslave2:latest
echo "FIN"

