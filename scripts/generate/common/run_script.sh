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
# Run the given script and display the elapsed time when finish
# ... $1 - the name of the script to be runned 
#
function run_script()
{
	local script=$1	


	local start_date=$(date +%s)

	./$script

	local stop_date=$(date +%s)

	
	local difference=$(($stop_date - $start_date))
	echo "Time elapsed: $(($difference / 60)) minute(s) and $(($difference % 60)) second(s)."
}
