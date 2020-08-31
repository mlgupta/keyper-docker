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

# Build and install flask modules/libraries
cd /container/service/gunicorn/assets/keyper
rm -rf env/*
python3 -m venv env
. env/bin/activate
pip install -r requirements.txt


# Build Vue frontend app
cd /container/service/nginx/assets/keyper-fe
npm install
npm run build
