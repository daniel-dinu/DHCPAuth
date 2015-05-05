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


CLIENT_INPUT_FILE = "./../../../../processed/sim2/client_rsa.dat"
SERVER_INPUT_FILE = "./../../../../processed/sim2/server_rsa.dat"
OUTPUT_FILE = "./../../../../plots/sim2/rsa/figure1.ps"


#set title "RSA signature processing time"
set xlabel "Key size (bits)"
set ylabel "Time (milliseconds)"


set grid
set key left top


set xrange [1024:4096]
set xtics 1024, 256, 4096


set style line 1 linetype 9 linewidth 1.000
set style line 2 linetype 11 linewidth 1.000
set style line 3 linetype 8 linewidth 1.000
set style line 4 linetype 10 linewidth 1.000
set style line 5 linetype 5 linewidth 1.000
set style line 6 linetype 4 linewidth 1.000
set style line 7 linetype 6 linewidth 1.000


set terminal postscript
#set terminal svg
#set terminal pngcairo
#set terminal pdf
#set terminal pdf monochrome
#set terminal latex


set output OUTPUT_FILE


plot \
	CLIENT_INPUT_FILE using 1:3 with lp ls 2 title "Client PKI Verify Total", \
	CLIENT_INPUT_FILE using 1:5 with lp ls 4 title "Client PKI Verify Auth", \
	SERVER_INPUT_FILE using 1:2 with lp ls 5 title "Server PKI Sign Total", \
	SERVER_INPUT_FILE using 1:3 with lp ls 6 title "Server PKI Sign Auth"
