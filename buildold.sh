#!/bin/bash

baseimage="docker.io/openshift/jenkins-agent-maven-35-centos7:v3.11"
micont=$(buildah from ${baseimage})

# Install packages

buildah run ${micont} cat /usr/local/bin/run-jnlp-client >> example.sh
