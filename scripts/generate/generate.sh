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
# Generate PKI & PGP key pairs
#



# Save the current directory
current_dir=$(pwd)


if [ "." != $(dirname $0) ]
then
	# Change the current directory to the script directory
	cd $(dirname $0)
fi


# Include run script
source ./common/run_script.sh


# Generate PKI set 1 key pairs
run_script ./set1/pki/generate.sh


# Generate PGP set 1 key pairs
run_script ./set1/pgp/generate.sh


# Generate PKI set 2 key pairs
run_script ./set2/pki/generate.sh


# Generate PKI set 3 key pairs
run_script ./set3/pki/generate.sh


# Generate PGP set 3 key pairs
run_script ./set3/pgp/generate.sh


# Change the current directory to old current directory 
cd $current_dir
