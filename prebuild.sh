#!/bin/bash

VER=1
baseimage="centos:8"
micont=$(buildah from ${baseimage})

buildah config --label maintainer="Fabian Salamanca <fsalamanca@ibm.com>" ${micont}
buildah config --author "Fabian Salamanca <fsalamanca@ibm.com>" ${micont}

# Install packages

buildah run ${micont} dnf -y install java-11-openjdk-devel curl wget gzip tar
buildah run ${micont} useradd -d /home/jenkins -m jenkins
buildah config --workingdir /home/jenkins ${micont}
echo "Comandos"
buildah run ${micont} pwd && wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
buildah run ${micont} pwd && tar xvfz apache-maven-3.6.3-bin.tar.gz

# Image configuration

#buildah config --port 8080

buildah commit ${micont} quay.io/fabstao/centos8-jdk11

buildah tag quay.io/fabstao/centos8-jdk11 quay.io/fabstao/centos8-jdk11:${VER}
buildah tag quay.io/fabstao/centos8-jdk11:${VER} quay.io/fabstao/centos8-jdk11:latest

echo "Subiendo imagen"
echo
buildah login quay.io
buildah push quay.io/fabstao/centos8-jdk11:${VER}
buildah push quay.io/fabstao/centos8-jdk11:latest
echo "FIN"

