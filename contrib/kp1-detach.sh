#!/bin/bash
#############################################################################
# Contributed by Philip Ingram                                              #
#############################################################################

# readlink works if script invoked by symbolic link
this_script=$(readlink -f "$0")
this_dir="$(dirname "${this_script}")"

# initiate logging and check sudo capable
log_sudo () {
  # checks user can use sudo
  # sets up log file
  # shows start time

  set +x #echo off. Use set -x to turn echo on

  local start_secs
  local runid
  local r0
  local r1 

  # check being run with sudo
  # note that 'root' is not a member of the sudo group
  # must therefore test for id 0 before texting group membership
  
  if [[ $(id -u) -eq 0 ]]
  then
    echo "this script will run as root when required"
    echo "please rerun from an account with 'sudo' privileges"
    echo "_without_ using 'sudo' to ensure correct file ownership"
    exit 98
  else # not running as root
# there are blanks on each side of $(groups) and of sudo
# this simplifies the test 
    if ! [[ " $(groups) " == *' sudo '* ]]
    then
      echo "This account is not a member of the 'sudo' group"
      echo 'Please rerun from a suitable account'
      exit 99
    fi # member of 'sudo' group, not running as root, OK
  fi
  
  start_secs=$(date +"%s")
  runid=$(date +"%y%m%d%H%M%S")
  r0=$(echo "$0" | sed 's:^.*/\(.*\):\1:' )
  r1="$r0-"$runid".log"
  echo "log file is $PWD/logs/$r1"

  # Create log directory if needed
  mkdir -p "$PWD/logs"
  # route all output to log file
  exec &> >(tee -a "$PWD/logs/$r1")

  # report script name
  echo "bash source is <${BASH_SOURCE[0]}>"
  script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  echo "script_dir is <$script_dir>"
  script_full_name="$(realpath "$0")"
  echo "script_full_name is <$script_full_name>"
  echo "script starts at: $runid"
}

log_sudo

LDAP_ORGANIZATION_NAME='keyper test'
LDAP_DOMAIN='lan'
sudo docker volume create slapd.d
sudo docker volume create openldap-data
sudo docker volume create ssh-keys
sudo docker volume create certs

sudo docker run -p 8080:80 -p 8443:443 -p 2389:389 -p 2636:636 \
--hostname octopod21.lan \
--mount source=slapd.d,target=/etc/openldap/slapd.d \
--mount source=openldap-data,target=/var/lib/openldap/openldap-data \
--mount source=ssh-keys,target=/etc/sshca \
--mount source=certs,target=/etc/nginx/certs \
--detach \
-it dbsentry/keyper

