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
# Display simulation start and stop time
# ... $1 - the simulation duration
#

function simulation_time()
{
	local simulation_duration=$1
	

	local start_date=$(date +"%Y-%m-%d %r")
	local stop_date=$(date --date "$simulation_duration seconds" +"%Y-%m-%d %r")

	echo -e "Simulation started at: \t\t $start_date"
	echo -e "Simulation will stop at: \t $stop_date"
}
