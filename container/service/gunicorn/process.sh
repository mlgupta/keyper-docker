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

sv check /container/run/process/slapd
log-helper info "gunicorn: Starting"
exec su -s nginx /bin/sh -c "cd /var/www/keyper; . env/bin/activate; gunicorn -w 4 'app:create_app()' --bind 127.0.0.1:8000 --user=nginx --group=nginx"
log-helper info "gunicorn: Started"
