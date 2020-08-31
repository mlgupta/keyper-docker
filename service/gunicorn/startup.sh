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

cd /container/service/gunicorn/assets
mv keyper /var/www
cd /var/www
chown -R nginx:nginx keyper

[ -d /var/log/keyper ] || mkdir /var/log/keyper
chown nginx:nginx /var/log/keyper

exit 0
