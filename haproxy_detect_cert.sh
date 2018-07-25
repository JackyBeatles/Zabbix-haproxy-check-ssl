#!/bin/bash

CERT_PATH={PATH_SSL}
FIRST_ELEMENT=1
function check_first_element {
    if [[ $FIRST_ELEMENT -ne 1 ]]; then
        printf ","
    fi
    FIRST_ELEMENT=0
}
printf '{'
printf ' "data":['
for pem in $CERT_PATH*.pem; do

      CERT=$(date --date="$(openssl x509 -enddate -noout -in "$pem" | cut -d= -f 2)" --iso-8601)
      DOMAIN=` echo   $pem  | sed 's,'$CERT_PATH',,g'`
      DOMAIN=` echo   $DOMAIN  | sed 's,.pem,,g'`
      DIFF=$(($(($(date -d "$CERT" "+%s") - $(date  "+%s"))) / 86400))
      #echo $CERT $FILE $DIFF 
        check_first_element
        printf "{"
        printf "\"{#DOMAINS}\":\"$DOMAIN\""
        printf "}"
done 
printf ' ]'
printf '}'