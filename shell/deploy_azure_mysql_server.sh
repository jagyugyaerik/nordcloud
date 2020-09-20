#!/bin/bash

set -euo pipefail

source config.sh


# Craete sql server
az mysql server create \
  --resource-group $RESOURCEGROUPNAME \
  --name $SERVERNAME \
  --location $LOCATION \
  --admin-user $ROOTUSER \
  --admin-password $ROOTPASSWORD \
  --sku-name GP_Gen5_2 \
  --version 5.7 \
  --ssl-enforcement Disabled

# Crate firewall rules
az mysql server firewall-rule create \
  --resource-group $RESOURCEGROUPNAME \
  --server $SERVERNAME \
  --name AllowAllIP \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 0.0.0.0

# Create vnet rule
az mysql server vnet-rule create \
  --name $VNETNAME-rule \
  --resource-group $RESOURCEGROUPNAME \
  --server-name $SERVERNAME \
  --vnet-name $VNETNAME \
  --subnet $SUBNETNAME
