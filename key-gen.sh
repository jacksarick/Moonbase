#!/bin/bash

MINIMAL=false
SETPASSWORD=false

while getopts "dp:" option
do
  case "${option}" in
		d)
			DEFAULTS=true
			;;
		p)
			SETPASSWORD=${OPTARG}
			;;
  esac
done


if [ "$DEFAULTS" == false ]; then
	# Read keyfile
	echo "Please enter keyfile location (same as config.yml)"
	echo -n "If none is entered, default './user/login.key': "
	read KEYFILE
	if [ "$KEYFILE" == "" ]; then
		KEYFILE='./user/login.key'
	fi
else
	echo "Using default keyfile location './user/login.key' "
	KEYFILE='./user/login.key'
fi

if [ "$SETPASSWORD" != false ]; then
	echo "Using argument password "
	PASSWORD=$SETPASSWORD
else
	# Read new password
	echo -n "Please enter new password: "
	read -s PASSWORD
	echo ""

	# Fail on empty
	if [ "$PASSWORD" == "" ]; then
		echo "Can't use empty password"
		exit 128
	fi

	# Read new re-password
	echo -n "Please re-enter new password: "
	read -s REPASSWORD
	echo ""

	# Fail on empty or different
	if [ "$REPASSWORD" == "" ] || [ "$REPASSWORD" != "$PASSWORD" ]; then
		echo "Can't use empty password"
		exit 128
	fi

	echo "Password confirmed"
fi
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo -n $(echo -n $PASSWORD | md5sum | awk '{print $1}') > $KEYFILE
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo -n $(md5 -qs $PASSWORD) > $KEYFILE
fi
echo "Password change successful"
