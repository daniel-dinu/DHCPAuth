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
# Simulate DHCP client operation with dhcpauth module enabled using DSA signatures
#



# The client private key file path
CLIENT_PRIVATE_KEY_FILE_PATH=./../../../../generated/set1/pgp/dsa/priv

# The server certificate file path
SERVER_CERTIFICATE_FILE_PATH=./../../../../generated/set1/pki/dsa/cert

# The client statistics file path
CLIENT_STATISTICS_FILE_PATH=./../../../../results/sim1/client/dsa


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
source ./../../common/constants.sh


# Include simulation time
source ./../../common/simulation_time.sh


# Create the client statistics file directory if it does not exist
if [ ! -d $CLIENT_STATISTICS_FILE_PATH ]
then
	mkdir $CLIENT_STATISTICS_FILE_PATH
fi


# Set the simulation log file
log_file=$CLIENT_STATISTICS_FILE_PATH/$SIMULATION_LOG_FILE


# Clear log file
echo "" > $log_file


# Set dhcpauth.conf
cp $CLIENT_DHCPAUTH_CONFIGURATION_FILE $DHCPAUTH_CONFIGURATION_FILE &>> $log_file


i=$DSA_KEY_SIZE_START
while [ $i -le $DSA_KEY_SIZE_STOP ]
do
	echo "---> Simulate client for $i bits DSA key pair <---"

	
	simulation_time $SIMULATION_DURATION

	
	client_private_key=$CLIENT_PRIVATE_KEY_FILE_PATH/priv_dsa_$i.key
	server_certificate=$SERVER_CERTIFICATE_FILE_PATH/cert_dsa_$i.pem
	client_statistics_file=$CLIENT_STATISTICS_FILE_PATH/statistics_dsa_$i.csv


	# Import PGP client private key
	$GPG --import $client_private_key &>> $log_file

	# Get PGP client private key fingerprint
	key_fingerprint=$($GPG --fingerprint $KEY_NAME | grep "Key fingerprint" | cut -d "=" -f 2)

	# Set PGP client private key fingerprint in dhcpauth.conf
	sed -i "s/.*SECRET_KEY_FINGERPRINT=.*/SECRET_KEY_FINGERPRINT=$key_fingerprint/g" $DHCPAUTH_CONFIGURATION_FILE

	# Copy PKI server certificate
	cp $server_certificate $SERVER_CERTIFICATE_FILE &>> $log_file


	# Start DHCP client
	$DHCP_CLIENT $DHCP_CLIENT_INTERFACE &>> $log_file

	# Wait for simulation duration
	sleep $SIMULATION_DURATION

	# Stop DHCP client
	kill -INT $(cat $DHCP_CLIENT_PID_FILE)
	

	# Move client results file
	mv $CLIENT_STATISTICS_FILE $client_statistics_file &>> $log_file

	# Delete PGP client private & public keys
	$GPG --batch --delete-secret-and-public-key "$key_fingerprint" &>> $log_file

	# Delete PKI server certificate
	rm $SERVER_CERTIFICATE_FILE &>> $log_file


	# Wait for server to finish
	sleep $CLIENT_SIMULATION_WAIT_TIME


	i=$(($i + $DSA_KEY_SIZE_STEP))
done


# Change the current directory to old current directory 
cd $current_dir
