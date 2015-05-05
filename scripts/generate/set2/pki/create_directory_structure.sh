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

	# Generated param file path
	GENERATED_PARAM_FILE_PATH=$GENERATED_FILE_PATH/$GENERATED_FILE_DIR/$PARAM_DIR

	# Generated key file path
	GENERATED_KEY_FILE_PATH=$GENERATED_FILE_PATH/$GENERATED_FILE_DIR/$KEY_DIR

	# Generated certificate signing request (CSR) file path
	GENERATED_CSR_FILE_PATH=$GENERATED_FILE_PATH/$GENERATED_FILE_DIR/$CSR_DIR

	# Generated certificate file path 
	GENERATED_CERT_FILE_PATH=$GENERATED_FILE_PATH/$GENERATED_FILE_DIR/$CERT_DIR


	# Create the generated file directory if it does not exist
	if [ ! -d $GENERATED_FILE_PATH/$GENERATED_FILE_DIR ]
	then
		mkdir $GENERATED_FILE_PATH/$GENERATED_FILE_DIR
	fi


	# Create the generated param directory if it does not exist
	if [ ! -d $GENERATED_PARAM_FILE_PATH ]
	then
		mkdir $GENERATED_PARAM_FILE_PATH
	fi


	# Create the generated key directory if it does not exist
	if [ ! -d $GENERATED_KEY_FILE_PATH ]
	then
		mkdir $GENERATED_KEY_FILE_PATH
	fi


	# Create the generated certificate signing request (CSR) directory if it does not exist
	if [ ! -d $GENERATED_CSR_FILE_PATH ]
	then
		mkdir $GENERATED_CSR_FILE_PATH
	fi
	

	# Create the generated certificate directory if it does not exist
	if [ ! -d $GENERATED_CERT_FILE_PATH ]
	then
		mkdir $GENERATED_CERT_FILE_PATH
	fi


	# Clear the log file
	echo "" > $LOG_FILE
}
