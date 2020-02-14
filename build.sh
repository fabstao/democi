#!/bin/bash

baseimage="centos:8"
micont=$(buildah from ${baseimage})

buildah config --label maintainer="Fabian Salamanca <fsalamanca@ibm.com>" ${micont}
buildah config --author "Fabian Salamanca <fsalamanca@ibm.com>" ${micont}

# Install packages

buildah run ${micont} dnf -y install java-11-openjdk-devel curl maven
buildah run ${micont} useradd -d /home/jenkins -m jenkins

buildah copy ${micont} ./check.sh /usr/bin

# Image configuration

buildah config --user jenkins ${micont}
buildah config --entrypoint /usr/bin/check.sh ${micont}
buildah config --workingdir /home/jenkins ${micont}
#buildah config --port 8080

buildah commit ${micont} quay.io/fabstao/tslave2

podman tag quay.io/fabstao/tslave2 quay.io/fabstao/tslave2:2
podman tag quay.io/fabstao/tslave2:2 quay.io/fabstao/tslave2:latest

echo "Subiendo imagen"
echo
podman push quay.io/fabstao/tslave2:2
podman push quay.io/fabstao/tslave2:latest
echo "FIN"

