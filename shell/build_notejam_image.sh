#!/bin/bash

set -eou pipefail

source config.sh

az acr login --name $ACRNAME
AZURE_ACR_HOST=$(az acr show --name $ACRNAME --query 'loginServer' -o tsv)

git clone -b nordcloud https://github.com/jagyugyaerik/notejam /tmp/notejam
docker build -t $AZURE_ACR_HOST/$IMAGE_NAME:$IMAGE_TAG /tmp/notejam/flask

docker push $AZURE_ACR_HOST/$IMAGE_NAME:$IMAGE_TAG

docker rmi $AZURE_ACR_HOST/$IMAGE_NAME:$IMAGE_TAG
