#!/bin/bash

set -eou pipefail

source config.sh

az network vnet create \
  --resource-group $RESOURCEGROUPNAME \
  --name $VNETNAME \
  --address-prefixes 192.168.0.0/16 \
  --location $LOCATION

az network vnet subnet create \
  --resource-group $RESOURCEGROUPNAME \
  --name $SUBNETNAME \
  --vnet-name $VNETNAME \
  --address-prefix 192.168.1.0/24 \
  --service-endpoints Microsoft.SQL
