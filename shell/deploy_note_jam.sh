#!/bin/bash

set -eou pipefail

source config.sh

AZURE_ACR_HOST=$(az acr show --name $ACRNAME --query 'loginServer' -o tsv)
MYSQL_HOST=$(az mysql server show --name $SERVERNAME --resource-group $RESOURCEGROUPNAME --query 'fullyQualifiedDomainName' -o=tsv)

helm install notejam ../helm/notejam \
  --set image.repository=$AZURE_ACR_HOST/$IMAGE_NAME \
  --set image.tag=$IMAGE_TAG \
  --set mysqlHost=$MYSQL_HOST \
  --set mysqlUser="$ROOTUSER@$SERVERNAME" \
  --set mysqlPassword=$ROOTPASSWORD \
  --set service.type=LoadBalancer

echo "Waiting for external IP allocation"
sleep 60

NOTEJAM_EXTERNAL_IP=$(kubectl get svc notejam -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo
echo "*********************************************"
echo "You can reach noteajm at $NOTEJAM_EXTERNAL_IP"
echo "*********************************************"
echo