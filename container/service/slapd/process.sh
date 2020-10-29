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

log-helper info "openldap: Starting"
#exec /usr/sbin/slapd -F /etc/openldap/slapd.d -h "ldap:/// ldaps:///" -u ldap -g ldap -d "$LDAP_LOG_LEVEL"
#exec /usr/sbin/slapd -h "ldap:/// ldaps:///" -u ldap -g ldap -d "$LDAP_LOG_LEVEL"
exec /usr/sbin/slapd -h "ldap:/// ldaps:///" -u nginx -g nginx -d "$LDAP_LOG_LEVEL"
log-helper info "openldap: Started"
