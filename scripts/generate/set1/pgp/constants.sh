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
# Constants used to generate the PGP private and public keys
#



# The generated file path
GENERATED_FILE_PATH=./../../../../generated/set1/pgp


# Generated files and directories
GENERATE_LOG_FILE=generate.log
GPG_SCRIPT_FILE=gen_key_script.gpg
PRIVATE_KEY_DIR=priv
PUBLIC_KEY_DIR=pub
OWNER_TRUST_DIR=trust


# GNU Privacy Guard (GnuPG or GPG)
GPG=gpg


# Key pair valability
VALABILITY=365


# User information
REAL_NAME=dhcpauth
EMAIL_ADDRESS=dhcpauth@danieldinu.ro
COMMENT=test


# Secret key passphrase
PASSPHRASE=***
