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
# Simulate DHCP server operation with dhcpauth module enabled using DSA signatures
#



# The server private key file path
SERVER_PRIVATE_KEY_FILE_PATH=./../../../../generated/set3/pki/dsa/key

# The client public key file path
CLIENT_PUBLIC_KEY_FILE_PATH=./../../../../generated/set3/pgp/dsa/pub

# The owner trust file path
CLIENT_TRUST_FILE_PATH=./../../../../generated/set3/pgp/dsa/trust

# The server statistics file path
SERVER_STATISTICS_FILE_PATH=./../../../../results/sim5/server/dsa


# DSA key size
DSA_KEY_SIZE=2048


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
source ./../../common/constants.sh


# Include simulation time
source ./../../common/simulation_time.sh


# Create the server statistics file directory if it does not exist
if [ ! -d $SERVER_STATISTICS_FILE_PATH ]
then
	mkdir $SERVER_STATISTICS_FILE_PATH
fi


# Set the simulation log file
log_file=$SERVER_STATISTICS_FILE_PATH/$SIMULATION_LOG_FILE


# Clear log file
echo "" > $log_file


# Set dhcpauth.conf
cp $SERVER_DHCPAUTH_CONFIGURATION_FILE $DHCPAUTH_CONFIGURATION_FILE &>> $log_file


i=$FILE_PATTERN_START
while [ $i -le $FILE_PATTERN_STOP ]
do
	echo "---> Simulate server for $DSA_KEY_SIZE bits DSA key pair $i <---"

	
	simulation_time $SIMULATION_DURATION


	n=$((1000 + i)) 
	n=${n#1}
	
	server_private_key=$SERVER_PRIVATE_KEY_FILE_PATH/key_dsa_$n.pem
	client_public_key=$CLIENT_PUBLIC_KEY_FILE_PATH/pub_dsa_$n.key
	owner_trust_file=$CLIENT_TRUST_FILE_PATH/owner_dsa_$n.trust
	server_statistics_file=$SERVER_STATISTICS_FILE_PATH/statistics_dsa_$n.csv


	# Copy PKI server private key
	cp $server_private_key $SERVER_PRIVATE_KEY_FILE &>> $log_file

	# Import PGP client public key
	$GPG --import $client_public_key &>> $log_file

	# Update the client public key trust level
	$GPG --import-ownertrust $owner_trust_file


	# Start DHCP server
	$DHCP_SERVER &>> $log_file

	# Wait for simulation duration
	sleep $SIMULATION_DURATION

	# Stop DHCP server
	kill -INT $(cat $DHCP_SERVER_PID_FILE)
	

	# Move server results file
	mv $SERVER_STATISTICS_FILE $server_statistics_file &>> $log_file

	# Delete PKI server private key
	rm $SERVER_PRIVATE_KEY_FILE &>> $log_file


	# Wait for client to finish
	sleep $SERVER_SIMULATION_WAIT_TIME

	
	i=$(($i + $FILE_PATTERN_STEP))
done


# Delete PGP client public keys
i=$FILE_PATTERN_START
while [ $i -le $FILE_PATTERN_STOP ]
do
	$GPG --yes --batch --delete-keys "$KEY_NAME" &>> $log_file

	i=$(($i + $FILE_PATTERN_STEP))
done


# Change the current directory to old current directory 
cd $current_dir
