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

FIRST_START_DONE="${CONTAINER_STATE_DIR}/gunicorn-first-start-done"

if [ ! -e "$FIRST_START_DONE" ]; then
	touch $FIRST_START_DONE
fi

log-helper info "Setting UID/GID for nginx to ${NGINX_UID}/${NGINX_GID}"
[ "$(id -g nginx)" -eq ${NGINX_GID} ] || groupmod -g ${NGINX_GID} nginx
[ "$(id -u nginx)" -eq ${NGINX_UID} ] || usermod -u ${NGINX_UID} -g ${NGINX_GID} nginx

cd /container/service/gunicorn/assets
mv keyper /var/www
cd /var/www

[ -d ${SSH_CA_DIR} ] || mkdir ${SSH_CA_DIR}

if [ "$(ls -A /container/service/gunicorn/assets/sshca | grep -v lost+found)" ]; then
	cp /container/service/gunicorn/assets/sshca/* ${SSH_CA_DIR}
fi
[ -d ${SSH_CA_DIR}/${SSH_CA_TMP_WORK_DIR} ] || mkdir ${SSH_CA_DIR}/${SSH_CA_TMP_WORK_DIR}

if [ ! -e "$SSH_CA_DIR/$SSH_CA_HOST_KEY" ]; then
        log-helper info "CA Host Key does not exist. Generating one ..."
		ssh-keygen -t rsa -q -N "" -f ${SSH_CA_DIR}/${SSH_CA_HOST_KEY}
fi

if [ ! -e "$SSH_CA_DIR/$SSH_CA_USER_KEY" ]; then
        log-helper info "CA User Key does not exist. Generating one ..."
		ssh-keygen -t rsa -q -N "" -f ${SSH_CA_DIR}/${SSH_CA_USER_KEY}
fi

[ -d /var/log/keyper ] || mkdir /var/log/keyper
chown -R nginx:nginx /var/log/keyper /var/www/keyper ${SSH_CA_DIR}

exit 0
