#!/bin/sh
# *************************************
# (C) 2020 IBM
# Fabian Salamanca <fsalamanca@ibm.com>
# *************************************

if [ -z ${JENKINS_HOME} ]; then
	JENKINS_HOME=/home/jenkins
fi

JAR="${JENKINS_HOME}/remoting.jar"

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo
echo "JENKINS Service:port  |  HOME"
echo "${JENKINS_SERVICE_HOST}  : ${JENKINS_SERVICE_PORT}    |  ${JENKINS_HOME}"
echo
echo "JENKINS Tunnel - Jenkins URL"
echo "${JENKINS_TUNNEL}  |   ${JENKINS_URL}"
echo
echo "JENKINS Secret"
echo ${JENKINS_SECRET}

if [ ! -z ${JENKINS_SERVICE_HOST} ]; then
	JENKINS_URL="http://${JENKINS_SERVICE_HOST}:${JENKINS_SERVICE_PORT}"
	echo " curl: ${JENKINS_URL}/jnlpJars/remoting.jar -o ${JAR}"
	curl -sS ${JENKINS_URL}/jnlpJars/remoting.jar -o ${JAR}
	echo "Remoting downloaded"

fi
java -jar ${JAR} #${JENKINS_URL} ${JENKINS_SECRET}

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"