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


CLIENT_INPUT_FILE = "./../../../../processed/sim5/client_dsa.dat"
SERVER_INPUT_FILE = "./../../../../processed/sim5/server_dsa.dat"
OUTPUT_FILE = "./../../../../plots/sim5/dsa/figure3.ps"


#set title "DSA signature processing time on DHCP server"
set xlabel "Number of PKI certificates/PGP public keys"
set ylabel "Time (milliseconds)"


set grid
set key at 100, 15


set style line 1 linetype 5 linewidth 1.000
set style line 2 linetype 7 linewidth 1.000
set style line 3 linetype 4 linewidth 1.000
set style line 4 linetype 6 linewidth 1.000
set style line 5 linetype 9 linewidth 1.000


set terminal postscript
#set terminal svg
#set terminal pngcairo
#set terminal pdf
#set terminal pdf monochrome
#set terminal latex


set output OUTPUT_FILE


plot \
	SERVER_INPUT_FILE using 1:2 with lp ls 5 title "DHCPREQUEST + DHCPACK", \
	SERVER_INPUT_FILE using 1:4 with lp ls 3 title "DHCPREQUEST authentication option", \
	SERVER_INPUT_FILE using 1:3 with lp ls 4 title "DHCPACK authentication option"
