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
# Constants used to generate the PKI private keys, certificate signing requests and self-signed certificates
#



# The generated file path
GENERATED_FILE_PATH=./../../../../generated/set2/pki


# Generated files and directories
GENERATE_LOG_FILE=generate.log
PARAM_DIR=param
KEY_DIR=key
CSR_DIR=csr
CERT_DIR=cert


# Private key password
PASSWORD=***


# Certificate subject info
COUNTRY_NAME=RO
STATE_NAME=Romania
LOCALITY_NAME=Bucharest
ORGANIZATION_NAME=dhcpauth
ORGANIZATIONAL_UNIT_NAME=IT
COMMON_NAME=danieldinu.ro
EMAIL_ADDRESS=dhcpauth@danieldinu.ro


# Certificate signing request (CSR) subject
SUBJECT="/C=$COUNTRY_NAME/ST=$STATE_NAME/L=$LOCALITY_NAME/O=$ORGANIZATION_NAME/OU=$ORGANIZATIONAL_UNIT_NAME/CN=$COMMON_NAME/emailAddress=$EMAIL_ADDRESS"


# Self-signed certificate valability
VALABILITY=365
