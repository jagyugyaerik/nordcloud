#!/bin/bash

source config.sh

set -eou pipefail
# set -x 

SERVICE_PRINCIPAL=$(az ad sp create-for-rbac --name $AKSNAME-sp --skip-assignment -o=json)

SPAPPID=$(echo $SERVICE_PRINCIPAL | jq -r .appId)
SPPASS=$(echo $SERVICE_PRINCIPAL | jq -r .password)

VNET_ID=$(az network vnet show --resource-group $RESOURCEGROUPNAME --name $VNETNAME --query id -o tsv)
SUBNET_ID=$(az network vnet subnet show --resource-group $RESOURCEGROUPNAME --vnet-name $VNETNAME --name $SUBNETNAME --query id -o tsv)

az role assignment create --assignee $SPAPPID --scope $VNET_ID --role "Network Contributor"

az acr create \
  --resource-group $RESOURCEGROUPNAME \
  --name $ACRNAME \
  --public-network-enabled true \
  --sku Basic

az aks create \
  --resource-group $RESOURCEGROUPNAME \
  --name $AKSNAME \
  --node-count $AKSNODECOUNT \
  --network-plugin kubenet \
  --network-policy calico \
  --service-cidr 10.0.0.0/16 \
  --dns-service-ip 10.0.0.10 \
  --pod-cidr 10.244.0.0/16 \
  --docker-bridge-address 172.17.0.1/16 \
  --vnet-subnet-id $SUBNET_ID \
  --kubernetes-version 1.18.8 \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 10 \
  --location $LOCATION \
  --node-vm-size Standard_DS2_v2 \
  --service-principal $SPAPPID \
  --client-secret $SPPASS \
  --enable-addons monitoring \
  --attach-acr $ACRNAME

az aks get-credentials -n $AKSNAME -g $RESOURCEGROUPNAME
