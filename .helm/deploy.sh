#!/bin/bash

set -e

RELEASE_NAME="ms-cart-${TRAVIS_BRANCH}"

DEPLOY_EXISTS=$(helm ls --all "^${RELEASE_NAME}\$")
DEPLOY_FAILED=$(helm ls --failed "^${RELEASE_NAME}\$")

echo "trying to deploy ${RELEASE_NAME} ..."

if [ -n "${DEPLOY_FAILED}" ]
then
	echo "previous deployment failed, deleting it..."
	helm delete --purge "${RELEASE_NAME}"

    DEPLOY_EXISTS=$(helm ls --all "^${RELEASE_NAME}\$")

    until [ -z "${DEPLOY_EXISTS}" ]
    do
        echo "waiting delete deployment to finish..."
        sleep 30
        DEPLOY_EXISTS=$(helm ls --all "^${RELEASE_NAME}\$")
    done
fi

if [ -n "${DEPLOY_EXISTS}" ]
then
	echo "deployment already exists, upgrading it..."
	helm upgrade "${RELEASE_NAME}" --namespace "static" .helm/aedius/ \
		--set images.aedius.tag=${TRAVIS_BUILD_NUMBER}
else
	echo "deployment doesn't exist yet, installing it..."
	helm install --name "${RELEASE_NAME}" --namespace "static" .helm/aedius/ \
		--set images.aedius.tag=${TRAVIS_BUILD_NUMBER}
fi