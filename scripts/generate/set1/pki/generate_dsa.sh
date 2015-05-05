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
# Generate DSA private keys, certificate signing requests and self-signed certificates
#



# Generated file directory
GENERATED_FILE_DIR=dsa


# DSA key size range
DSA_KEY_SIZE_START=1024
DSA_KEY_SIZE_STOP=3072
DSA_KEY_SIZE_STEP=1024



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


i=$DSA_KEY_SIZE_START
while [ $i -le $DSA_KEY_SIZE_STOP ]
do
	echo "---> Generate $i bits DSA PKI key pair <---"

	
	param_file=$GENERATED_PARAM_FILE_PATH/param_dsa_$i.pem
	key_file=$GENERATED_KEY_FILE_PATH/key_dsa_$i.pem
	csr_file=$GENERATED_CSR_FILE_PATH/csr_dsa_$i.csr
	cert_file=$GENERATED_CERT_FILE_PATH/cert_dsa_$i.pem


	# Generate DSA parameters
	openssl dsaparam -out $param_file $i &>> $LOG_FILE

	# Generate DSA private key
	openssl gendsa -aes256 -passout pass:$PASSWORD -out $key_file $param_file &>> $LOG_FILE

	# Generate certificate signing request (CSR)
	openssl req -new -key $key_file -passin pass:$PASSWORD -subj $SUBJECT -out $csr_file &>> $LOG_FILE

	# Generate self-signed certificate
	openssl x509 -req -days $VALABILITY -in $csr_file -signkey $key_file -passin pass:$PASSWORD -out $cert_file &>> $LOG_FILE

	
	i=$(($i + $DSA_KEY_SIZE_STEP))
done


# Change the current directory to old current directory 
cd $current_dir
