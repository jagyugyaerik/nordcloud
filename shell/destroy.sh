#!/bin/bash

set -eou pipefail

source config.sh

az group delete --name $RESOURCEGROUPNAME

[ -d /tmp/notejam ] && rm -rf /tmp/notejam