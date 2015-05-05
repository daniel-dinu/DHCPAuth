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


CLIENT_INPUT_FILE = "./../../../../processed/sim4/client_ec.dat"
SERVER_INPUT_FILE = "./../../../../processed/sim4/server_ec.dat"
OUTPUT_FILE = "./../../../../plots/sim4/ec/figure4.ps"


#set title "EC signature authentication option overhead"
set xlabel "Elliptic curve"
set ylabel "Length (bytes)"


set grid
set key left center


set xtics rotate


set style line 1 linetype 1 linewidth 1.000
set style line 2 linetype 2 linewidth 1.000
set style line 3 linetype 3 linewidth 1.000
set style line 4 linetype 4 linewidth 1.000
set style line 5 linetype 5 linewidth 1.000
set style line 6 linetype 6 linewidth 1.000
set style line 7 linetype 7 linewidth 1.000


set terminal postscript
#set terminal svg
#set terminal pngcairo
#set terminal pdf
#set terminal pdf monochrome
#set terminal latex


set output OUTPUT_FILE


plot \
	CLIENT_INPUT_FILE using 8:xtic(1) with lp ls 4 title "DHCPACK packet", \
	CLIENT_INPUT_FILE using 9:xtic(1) with lp ls 6 title "DHCPACK authentication option"
