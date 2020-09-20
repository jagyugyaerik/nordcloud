#!/bin/bash

set -eou pipefail

source config.sh

az group create --name $RESOURCEGROUPNAME --location $LOCATION
