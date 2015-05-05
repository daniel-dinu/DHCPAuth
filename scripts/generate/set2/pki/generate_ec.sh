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
# Generate EC private keys, certificate signing requests and self-signed certificates
#



# Generated file directory
GENERATED_FILE_DIR=ec

# Elliptic curves (EC) used
# Use 'openssl ecparam -list_curves' to print a list of all currently available curve 'short names'
ELLIPTIC_CURVES=(secp112r1 secp112r2 secp128r1 secp128r2 secp160k1 secp160r1 secp160r2 secp192k1 secp224k1 secp224r1 secp256k1 secp384r1 secp521r1 prime192v1 prime192v2 prime192v3 prime239v1 prime239v2 prime239v3 prime256v1 sect113r1 sect113r2 sect131r1 sect131r2 sect163k1 sect163r1 sect163r2 sect193r1 sect193r2 sect233k1 sect233r1 sect239k1 sect283k1 sect283r1 sect409k1 sect409r1 sect571k1 sect571r1 c2pnb163v1 c2pnb163v2 c2pnb163v3 c2pnb176v1 c2tnb191v1 c2tnb191v2 c2tnb191v3 c2pnb208w1 c2tnb239v1 c2tnb239v2 c2tnb239v3 c2pnb272w1 c2pnb304w1 c2tnb359v1 c2pnb368w1 c2tnb431r1 wap-wsg-idm-ecid-wtls1 wap-wsg-idm-ecid-wtls3 wap-wsg-idm-ecid-wtls4 wap-wsg-idm-ecid-wtls5 wap-wsg-idm-ecid-wtls6 wap-wsg-idm-ecid-wtls7 wap-wsg-idm-ecid-wtls8 wap-wsg-idm-ecid-wtls9 wap-wsg-idm-ecid-wtls10 wap-wsg-idm-ecid-wtls11 wap-wsg-idm-ecid-wtls12)



# Save the current directory
current_dir=$(pwd)


if [ "." != $(dirname $0) ]
then
	# Change the current directory to the script directory
	cd $(dirname $0)
fi


# Include constants
source constants.sh


# Include create directory structure
source create_directory_structure.sh


create_directory_structure


for i in ${ELLIPTIC_CURVES[@]}
do
	echo "---> Generate $i EC PKI key pair <---"

	
	key_file=$GENERATED_KEY_FILE_PATH/key_ec_$i.pem
	csr_file=$GENERATED_CSR_FILE_PATH/csr_ec_$i.csr
	cert_file=$GENERATED_CERT_FILE_PATH/cert_ec_$i.pem

	
	# Generate EC private key
	openssl ecparam -genkey -out $key_file -name $i &>> $LOG_FILE

	# Encrypt EC private key
	openssl ec -aes256 -passout pass:$PASSWORD -in $key_file -out $key_file &>> $LOG_FILE

	# Generate certificate signing request (CSR)
	openssl req -new -key $key_file -passin pass:$PASSWORD -subj $SUBJECT -out $csr_file &>> $LOG_FILE

	# Generate self-signed certificate
	openssl x509 -req -days $VALABILITY -in $csr_file -signkey $key_file -passin pass:$PASSWORD -out $cert_file &>> $LOG_FILE
done


# Change the current directory to old current directory 
cd $current_dir
