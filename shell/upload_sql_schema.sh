#!/bin/bash

set eou pipefail

source config.sh

MYSQL_HOST=$(az mysql server show --name $SERVERNAME --resource-group $RESOURCEGROUPNAME --query 'fullyQualifiedDomainName' -o=tsv)

kubectl create configmap "mysql-schema" --from-file="../mysql/mysql_57_schema.sql"

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: mysql-client
spec:
  restartPolicy: Never
  containers:
  - name: mysql-client
    image: mysql
    args:
    - bash
    - "-c"
    - "mysql -h$MYSQL_HOST -u$ROOTUSER@$SERVERNAME -p$ROOTPASSWORD < /opt/mysql_57_schema.sql"
    volumeMounts:
    - name: mysql-schema
      mountPath: /opt
      readOnly: true
  volumes:
    - name: mysql-schema
      configMap:
        name: mysql-schema 
---
EOF

# sleep 30

# kubectl delete pod mysql-client
# kubectl delete configmap mysql-schema
