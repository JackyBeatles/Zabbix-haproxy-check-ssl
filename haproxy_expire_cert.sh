#!/bin/bash
DOMAIN=$1
CERT_PATH={PATH_SSL}
CERT=$(date --date="$(openssl x509 -enddate -noout -in "$CERT_PATH$DBNAME.pem" | cut -d= -f 2)" --iso-8601)
DIFF=$(($(($(date -d "$CERT" "+%s") - $(date  "+%s"))) / 86400))
echo $DIFF 



