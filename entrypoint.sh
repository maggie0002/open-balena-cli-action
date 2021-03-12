#!/bin/bash
set -e

# Swith to given paths
if [ -d "${GITHUB_WORKSPACE}" ]; then
  cd ${GITHUB_WORKSPACE}
fi

if [ -d "${INPUT_APPLICATION_PATH}" ]; then
  cd ${INPUT_APPLICATION_PATH}
fi

# Error out of no API Token is available
if [[ "${INPUT_BALENA_API_TOKEN}" == "" ]]; then
  echo "Error: Please set the environment variable INPUT_BALENA_API_TOKEN with a Balena API token"
  exit 1
fi

# Write server api address to settings
if [[ "${INPUT_OPEN_BALENA_ADDRESS}" != "" ]]; then
  echo "balenaUrl: \"${INPUT_OPEN_BALENA_ADDRESS}\"" > ~/.balenarc.yml
fi

if [[ "${INPUT_ROOT_CERT}" != "" ]]; then
  echo ${INPUT_ROOT_CERT} > ca.crt
  cp ca.crt /usr/local/share/ca-certificates/ca.crt
  update-ca-certificates
fi
export "NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/ca.crt"
# Log in to Balena
balena login --token ${INPUT_BALENA_API_TOKEN} > /dev/null
balena ${INPUT_BALENA_COMMAND}
