#!/bin/bash

set -e

RELEASE_NAME="ms-cart-${TRAVIS_BRANCH}"

#DEPLOY_FAILED=$(helm list --failed "^${RELEASE_NAME}\$")
#
#echo "trying to deploy ${RELEASE_NAME} ..."
#
#if [ -n "${DEPLOY_FAILED}" ]
#then
#	echo "previous deployment failed, deleting it..."
#	helm delete --purge "${RELEASE_NAME}"
#
#    DEPLOY_EXISTS=$(helm list --all "^${RELEASE_NAME}\$")
#
#    until [ -z "${DEPLOY_EXISTS}" ]
#    do
#        echo "waiting delete deployment to finish..."
#        sleep 30
#        DEPLOY_EXISTS=$(helm list --all "^${RELEASE_NAME}\$")
#    done
#fi


echo "deployment already exists, upgrading it..."
helm upgrade --install "${RELEASE_NAME}" --namespace "static" .helm/aedius/ \
  --set images.aedius.tag=${TRAVIS_BUILD_NUMBER}

