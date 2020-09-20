#!/bin/bash

set -eou pipefail

docker run -ti --rm \
  --name notejam \
  -e MYSQL_HOST=172.17.0.2 \
  -p 8080:5000 \
  jagyugyaerik/notejam-flask:dev
