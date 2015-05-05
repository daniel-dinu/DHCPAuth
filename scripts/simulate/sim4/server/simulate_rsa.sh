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
# Simulate DHCP server operation with dhcpauth module enabled using RSA signatures
#



# The server private key file path
SERVER_PRIVATE_KEY_FILE_PATH=./../../../../generated/set2/pki/rsa/key

# The server statistics file path
SERVER_STATISTICS_FILE_PATH=./../../../../results/sim4/server/rsa


# RSA key size range
RSA_KEY_SIZE_START=512
RSA_KEY_SIZE_STOP=7680
RSA_KEY_SIZE_STEP=512



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


i=$RSA_KEY_SIZE_START
while [ $i -le $RSA_KEY_SIZE_STOP ]
do
	echo "---> Simulate server for $i bits RSA key pair <---"

	
	simulation_time $SIMULATION_DURATION

	
	server_private_key=$SERVER_PRIVATE_KEY_FILE_PATH/key_rsa_$i.pem
	server_statistics_file=$SERVER_STATISTICS_FILE_PATH/statistics_rsa_$i.csv
	

	# Copy PKI server private key
	cp $server_private_key $SERVER_PRIVATE_KEY_FILE &>> $log_file


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
	

	i=$(($i + $RSA_KEY_SIZE_STEP))
done


# Change the current directory to old current directory 
cd $current_dir
