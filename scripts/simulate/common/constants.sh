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
# Constants used to simuate the DHCP client & server operation with dhcpauth module enabled
#



# Simulation log file
SIMULATION_LOG_FILE=sim.log


# Simulation duration in seconds
SIMULATION_DURATION=1800


# Server simulation wait time in seconds
SERVER_SIMULATION_WAIT_TIME=11

# Client simulation wait time in seconds
CLIENT_SIMULATION_WAIT_TIME=10


# GNU Privacy Guard (GnuPG or GPG)
GPG=gpg


# Client PGP key name
KEY_NAME=dhcpauth


# Server PKI private key
SERVER_PRIVATE_KEY_FILE=/var/db/key/key.pem

# Server PKI certificate
SERVER_CERTIFICATE_FILE=/var/db/cert/cert.pem


# DHCP client
DHCP_CLIENT=./../../../../source/dhcp-4.2.7/client/dhclient

# DHCP client interface
DHCP_CLIENT_INTERFACE=eth0

# DHCP server
DHCP_SERVER=./../../../../source/dhcp-4.2.7/server/dhcpd


# DHCP client PID file
DHCP_CLIENT_PID_FILE=/var/run/dhclient.pid

# DHCP server PID file
DHCP_SERVER_PID_FILE=/var/run/dhcpd.pid


# DHCP auth configuration file
DHCPAUTH_CONFIGURATION_FILE=/etc/dhcpauth.conf

# The client dhcpauth.conf file
CLIENT_DHCPAUTH_CONFIGURATION_FILE=dhcpauth.conf

# The server dhcpauth.conf file
SERVER_DHCPAUTH_CONFIGURATION_FILE=dhcpauth.conf


# Client statistics file
CLIENT_STATISTICS_FILE=/var/db/statistics_client.csv

# Server statistics file
SERVER_STATISTICS_FILE=/var/db/statistics_server.csv
