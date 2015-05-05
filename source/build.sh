#!/bin/bash

#
#  Copyright (C) 2013-2015 Daniel Dinu <contact@danieldinu.ro>
#
#  DHCPAuth is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  DHCPAuth is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#


#
# Build DHCP with DHCPAuth module
# 	./build.sh [-h|--help] [{-p|--patch}=[0|1|2|3]]
#
#	Options:
#		-h, --help
#			Display help information
#		-p, --patch
#			Specifies which patch to use
#				0 - no patch
#				1 - PKI patch
#				2 - PGP patch
#				3 - PKI + PGP patch
#				Default: 3
#


# Constants
ISC_DHCP=dhcp-4.2.7

# No patch
PATCH_0=0
# PKI patch
PATCH_1=1
# PGP patch
PATCH_2=2
# PKI + PGP patch
PATCH_3=3

SCRIPT_PATCH=$PATCH_3


# Functions
function display_help()
{
	echo " Build DHCP with DHCPAuth module"
	echo " 	./build.sh [-h|--help] [{-p|--patch}=[0|1|2|3]]"
	echo ""
	echo "	Options:"
	echo "		-h, --help"
	echo "			Display help information"
	echo "		-p, --patch"
	echo "			Specifies which patch to use"
	echo "				0 - no patch"
	echo "				1 - PKI patch"
	echo "				2 - PGP patch"
	echo "				3 - PKI + PGP patch"
	echo "				Default: 3"

	exit
}

function build()
{
	tar xvzf ./../dhcp/$ISC_DHCP/$ISC_DHCP.tar.gz -C ./

	case $SCRIPT_PATCH in
		$PATCH_0)
			# No patch
			;;
		$PATCH_1)
			# PKI patch
			patch -p0 < ./../patch/DHCPAuth-patch/$ISC_DHCP/pki/dhcpauth_pki.patch
			;;
		$PATCH_2)
			# PGP patch
			patch -p0 < ./../patch/DHCPAuth-patch/$ISC_DHCP/pgp/dhcpauth_pgp.patch
			;;
		$PATCH_3|*)
			# PKI + PGP patch
			patch -p0 < ./../patch/DHCPAuth-patch/$ISC_DHCP/pki+pgp/patch/dhcpauth.patch
			;;
	esac

	cd $ISC_DHCP

	./configure

	make clean

	make
}


# Save the current directory
current_dir=$(pwd)


if [ "." != $(dirname $0) ]
then
	# Change the current directory to the script directory
	cd $(dirname $0)
fi


# Parse script arguments
for i in "$@"
do
	case $i in
		-h=*|--help=*)
			display_help
			;;
		-p=*|--patch=*)
			SCRIPT_PATCH="${i#*=}"
			shift
			;;
		*)
			echo "Unknown script argument '$i'!"
			display_help
			;;
	esac
done


# Build
build


# Change the current directory to old current directory 
cd $current_dir
