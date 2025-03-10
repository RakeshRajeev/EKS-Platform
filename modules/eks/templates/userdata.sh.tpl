MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
set -ex
/etc/eks/bootstrap.sh ${cluster_name} \
  --b64-cluster-ca '${cluster_ca_data}' \
  --apiserver-endpoint '${cluster_endpoint}' \
  --dns-cluster-ip 10.100.0.10

--//--
