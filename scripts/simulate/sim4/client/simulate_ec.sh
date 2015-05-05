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
# Simulate DHCP client operation with dhcpauth module enabled using EC signatures
#



# The server certificate file path
SERVER_CERTIFICATE_FILE_PATH=./../../../../generated/set2/pki/ec/cert

# The client statistics file path
CLIENT_STATISTICS_FILE_PATH=./../../../../results/sim4/client/ec


# Elliptic curves (EC) used
ELLIPTIC_CURVES=(secp112r1 secp112r2 secp128r1 secp128r2 secp160k1 secp160r1 secp160r2 secp192k1 secp224k1 secp224r1 secp256k1 secp384r1 secp521r1 prime192v1 prime192v2 prime192v3 prime239v1 prime239v2 prime239v3 prime256v1 sect113r1 sect113r2 sect131r1 sect131r2 sect163k1 sect163r1 sect163r2 sect193r1 sect193r2 sect233k1 sect233r1 sect239k1 sect283k1 sect283r1 sect409k1 sect409r1 sect571k1 sect571r1 c2pnb163v1 c2pnb163v2 c2pnb163v3 c2pnb176v1 c2tnb191v1 c2tnb191v2 c2tnb191v3 c2pnb208w1 c2tnb239v1 c2tnb239v2 c2tnb239v3 c2pnb272w1 c2pnb304w1 c2tnb359v1 c2pnb368w1 c2tnb431r1 wap-wsg-idm-ecid-wtls1 wap-wsg-idm-ecid-wtls3 wap-wsg-idm-ecid-wtls4 wap-wsg-idm-ecid-wtls5 wap-wsg-idm-ecid-wtls6 wap-wsg-idm-ecid-wtls7 wap-wsg-idm-ecid-wtls8 wap-wsg-idm-ecid-wtls9 wap-wsg-idm-ecid-wtls10 wap-wsg-idm-ecid-wtls11 wap-wsg-idm-ecid-wtls12)



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


for i in ${ELLIPTIC_CURVES[@]}
do
	echo "---> Simulate client for $i EC key pair <---"

	
	simulation_time $SIMULATION_DURATION

	
	server_certificate=$SERVER_CERTIFICATE_FILE_PATH/cert_ec_$i.pem
	client_statistics_file=$CLIENT_STATISTICS_FILE_PATH/statistics_ec_$i.csv


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

	# Delete PKI server certificate
	rm $SERVER_CERTIFICATE_FILE &>> $log_file

	
	# Wait for server to finish
	sleep $CLIENT_SIMULATION_WAIT_TIME
done


# Change the current directory to old current directory 
cd $current_dir
