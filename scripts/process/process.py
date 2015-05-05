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


__author__ = 'Daniel Dinu'

from simulation import sim1
from simulation import sim2
from simulation import sim3
from simulation import sim4
from simulation import sim5


# Process sim1 results
sim1.process()

# Process sim2 results
sim2.process()

# Process sim3 results
sim3.process()

# Process sim4 results
sim4.process()

# Process sim5 results
sim5.process()
