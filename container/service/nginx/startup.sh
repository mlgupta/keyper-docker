#!/bin/bash -e
#############################################################################
#                       Confidentiality Information                         #
#                                                                           #
# This module is the confidential and proprietary information of            #
# DBSentry Corp.; it is not to be copied, reproduced, or transmitted in any #
# form, by any means, in whole or in part, nor is it to be used for any     #
# purpose other than that for which it is expressly provided without the    #
# written permission of DBSentry Corp.                                      #
#                                                                           #
# Copyright (c) 2020-2021 DBSentry Corp.  All Rights Reserved.              #
#                                                                           #
#############################################################################

FIRST_START_DONE="${CONTAINER_STATE_DIR}/nginx-first-start-done"

if [ ! -e "$FIRST_START_DONE" ]; then
	touch $FIRST_START_DONE
fi

cd /container/service/nginx/assets
mv keyper-fe /var/www
mv scripts /var/www
mv docs /var/www
cd /var/www
chown -R nginx:nginx keyper-fe scripts docs

cd /var/www/scripts
sed -i "s/{{HOSTNAME}}/${HOSTNAME}/g" auth.sh.txt

cd /container/service/nginx/assets/etc/conf.d
mv default.conf /etc/nginx/conf.d

[ -d /etc/nginx/certs ] || mkdir /etc/nginx/certs
cp /container/service/nginx/assets/certs/* /etc/nginx/certs

LDAP_TLS_CRT_PATH=/etc/nginx/certs/$LDAP_TLS_CRT_FILENAME
LDAP_TLS_KEY_PATH=/etc/nginx/certs/$LDAP_TLS_KEY_FILENAME

if [ ! -e "$LDAP_TLS_CRT_PATH" ]; then
        log-helper info "Certificate/key do not exist. Generating a self signed certificate ..."
        openssl req -newkey rsa:2048 -nodes -keyout $LDAP_TLS_KEY_PATH -x509 -days 3650 -out $LDAP_TLS_CRT_PATH -subj "/CN=${HOSTNAME}"
fi

chown -R nginx:nginx /etc/nginx/conf.d/default.conf /etc/nginx/certs

[ -d /run/nginx ] || mkdir /run/nginx

exit 0
