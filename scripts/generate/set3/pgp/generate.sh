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
# Generate PGP private and public keys
#



#
# To trade key randomness for speed use 'rngd -r /dev/urandom'
# To install rngd use 'sudo apt-get install rng-tools'
# To see the available entropy use 'cat /proc/sys/kernel/random/entropy_avail'
#


# Save the current directory
current_dir=$(pwd)


if [ "." != $(dirname $0) ]
then
	# Change the current directory to the script directory
	cd $(dirname $0)
fi


# Include run script
source ./../../common/run_script.sh


echo "-----> Generate set3 PGP <-----"


# Generate RSA private and public keys
run_script generate_rsa.sh


# Generate DSA private and public keys
run_script generate_dsa.sh


# Change the current directory to old current directory 
cd $current_dir
