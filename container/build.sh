#!/bin/sh -ex
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
ln -s /container/tools/* /sbin/

mkdir /container/run
[ -d /container/environment/startup ] || mkdir /container/environment/startup
[ -d /container/service/gunicorn/assets ] || mkdir /container/service/gunicorn/assets
[ -d /container/service/nginx/assets/docs ] || mkdir /container/service/nginx/assets/docs
chown -R root:root /container/environment
chmod 700 /container/environment /container/environment/startup

cd /container
tar -xzf out.tar.gz
mv keyper /container/service/gunicorn/assets
mv keyper-fe /container/service/nginx/assets

apk upgrade --no-cache

# Remove useless files
rm -rf /tmp/* /var/tmp/* /container/build.sh /container/Dockerfile
rm -f /container/out.tar.gz

echo "Installing Services"
/container/tools/install-service

