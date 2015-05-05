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


CLIENT_INPUT_FILE = "./../../../../processed/sim1/client_dsa.dat"
SERVER_INPUT_FILE = "./../../../../processed/sim1/server_dsa.dat"
OUTPUT_FILE = "./../../../../plots/sim1/dsa/figure4.ps"


#set title "DSA signature authentication option overhead"
set xlabel "Key size (bits)"
set ylabel "Length (bytes)"


set grid
set key left center


set xrange [1024:3072]
set xtics 1024, 1024, 3072


set style line 1 linetype 5 linewidth 1.000
set style line 2 linetype 7 linewidth 1.000
set style line 3 linetype 4 linewidth 1.000
set style line 4 linetype 6 linewidth 1.000


set terminal postscript
#set terminal svg
#set terminal pngcairo
#set terminal pdf
#set terminal pdf monochrome
#set terminal latex


set output OUTPUT_FILE


plot \
	CLIENT_INPUT_FILE using 1:6 with lp ls 1 title "DHCPREQUEST packet", \
	CLIENT_INPUT_FILE using 1:7 with lp ls 2 title "DHCPREQUEST authentication option", \
	CLIENT_INPUT_FILE using 1:8 with lp ls 3 title "DHCPACK packet", \
	CLIENT_INPUT_FILE using 1:9 with lp ls 4 title "DHCPACK authentication option"
