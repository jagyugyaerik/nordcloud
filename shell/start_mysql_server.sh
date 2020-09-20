#!/bin/bash

set -euo pipefail

docker run -d \
  --name mysql-server \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_USER=mysql \
  -e MYSQL_PASSWORD=mysql \
  -e MYSQL_DATABASE=notejam \
  -v $(pwd)/schema.sql:/opt/schema.sql:ro \
  -p 3306:3306 \
  mysql
