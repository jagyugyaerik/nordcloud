#!/bin/bash

./deploy_resource_group.sh
./deploy_vnet.sh
./deploy_aks_cluster.sh
./deploy_azure_mysql_server.sh
./upload_sql_schema.sh
./build_notejam_image.sh
./deploy_note_jam.sh
