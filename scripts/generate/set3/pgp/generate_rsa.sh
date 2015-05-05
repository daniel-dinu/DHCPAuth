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
# Generate RSA private and public keys
#



# Generated file directory
GENERATED_FILE_DIR=rsa


# RSA key size
RSA_KEY_SIZE=2048


# File pattern range
FILE_PATTERN_START=0
FILE_PATTERN_STOP=100
FILE_PATTERN_STEP=1



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


i=$FILE_PATTERN_START
while [ $i -le $FILE_PATTERN_STOP ]
do
	echo "---> Generate $RSA_KEY_SIZE bits RSA PGP key pair $i <---"


	n=$((1000 + i)) 
	n=${n#1}
	
	private_key_file=$GENERATED_PRIVATE_KEY_FILE_PATH/priv_rsa_$n.key
	public_key_file=$GENERATED_PUBLIC_KEY_FILE_PATH/pub_rsa_$n.key
	owner_trust_file=$GENERATED_OWNER_TRUST_FILE_PATH/owner_rsa_$n.trust


	# Generate GPG script
	echo "Key-Type: RSA" > $GENRATE_KEY_SCRIPT
	echo "Key-Length: $RSA_KEY_SIZE" >> $GENRATE_KEY_SCRIPT
	echo "Key-Usage: sign" >> $GENRATE_KEY_SCRIPT
	echo "Expire-Date: $VALABILITY" >> $GENRATE_KEY_SCRIPT
	echo "Name-Real: key$i" >> $GENRATE_KEY_SCRIPT
	echo "Name-Email: $EMAIL_ADDRESS" >> $GENRATE_KEY_SCRIPT
	echo "Name-Comment: $COMMENT" >> $GENRATE_KEY_SCRIPT
	echo "Passphrase: $PASSPHRASE" >> $GENRATE_KEY_SCRIPT

	
	# Generate the key pair
	$GPG --batch --gen-key $GENRATE_KEY_SCRIPT &>> $LOG_FILE

	# Export the private key
	$GPG --yes --export-secret-keys --armor --output $private_key_file &>> $LOG_FILE

	# Export the public key
	$GPG --yes --export --armor --output $public_key_file &>> $LOG_FILE

	# Export the owner trust
	$GPG --export-ownertrust > $owner_trust_file

	# Delete the generated key pair
	key_fingerprint=$($GPG --fingerprint $REAL_NAME | grep "Key fingerprint" | cut -d "=" -f 2)
	$GPG --batch --delete-secret-and-public-key "$key_fingerprint" &>> $LOG_FILE


	# Delete generated GPG script
	rm -f $GENRATE_KEY_SCRIPT

	
	i=$(($i + $FILE_PATTERN_STEP))
done


# Change the current directory to old current directory 
cd $current_dir
