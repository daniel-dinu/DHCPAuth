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
# Create the required directory structure
#
function create_directory_structure()
{
	# Log file
	LOG_FILE=$GENERATED_FILE_PATH/$GENERATED_FILE_DIR/$GENERATE_LOG_FILE

	# GPG script file
	GENRATE_KEY_SCRIPT=$GENERATED_FILE_PATH/$GENERATED_FILE_DIR/$GPG_SCRIPT_FILE

	# Generated private key file path
	GENERATED_PRIVATE_KEY_FILE_PATH=$GENERATED_FILE_PATH/$GENERATED_FILE_DIR/$PRIVATE_KEY_DIR

	# Generated public key file path 
	GENERATED_PUBLIC_KEY_FILE_PATH=$GENERATED_FILE_PATH/$GENERATED_FILE_DIR/$PUBLIC_KEY_DIR

	# Owner trust file path 
	GENERATED_OWNER_TRUST_FILE_PATH=$GENERATED_FILE_PATH/$GENERATED_FILE_DIR/$OWNER_TRUST_DIR


	# Create the generated file directory if it does not exist
	if [ ! -d $GENERATED_FILE_PATH/$GENERATED_FILE_DIR ]
	then
		mkdir $GENERATED_FILE_PATH/$GENERATED_FILE_DIR
	fi


	# Create the generated private key directory if it does not exist
	if [ ! -d $GENERATED_PRIVATE_KEY_FILE_PATH ]
	then
		mkdir $GENERATED_PRIVATE_KEY_FILE_PATH
	fi
	

	# Create the generated public key directory if it does not exist
	if [ ! -d $GENERATED_PUBLIC_KEY_FILE_PATH ]
	then
		mkdir $GENERATED_PUBLIC_KEY_FILE_PATH
	fi


	# Create the owner trust directory if it does not exist
	if [ ! -d $GENERATED_OWNER_TRUST_FILE_PATH ]
	then
		mkdir $GENERATED_OWNER_TRUST_FILE_PATH
	fi


	# Clear the log file
	echo "" > $LOG_FILE
}
