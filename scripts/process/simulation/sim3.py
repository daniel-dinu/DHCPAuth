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

from client import client_results
from common import constants
from common import dat_file
from server import server_results


def process():
    """
    Process sim3 results
    :return:
    """

    process_rsa()
    process_dsa()



def process_rsa():
    """
    Process sim3 RSA results
    :return:
    """

    client_dat_file = constants.CLIENT_DAT_FILE_FORMAT.format(constants.SIM3_FILE, constants.RSA_FILE)
    server_dat_file = constants.SERVER_DAT_FILE_FORMAT.format(constants.SIM3_FILE, constants.RSA_FILE)

    dat_file.add_header(client_dat_file, constants.CLIENT_KEY_SIZE_DAT_FILE_HEADER)
    dat_file.add_header(server_dat_file, constants.SERVER_KEY_SIZE_DAT_FILE_HEADER)

    for i in range(1024, 4096 + 1, 32):
        client_results_file = constants.CLIENT_RESULTS_FILE_FORMAT.format(constants.SIM3_FILE, constants.RSA_FILE, i)
        server_results_file = constants.SERVER_RESULTS_FILE_FORMAT.format(constants.SIM3_FILE, constants.RSA_FILE, i)

        client_result = client_results.process(client_results_file)
        server_result = server_results.process(server_results_file)

        dat_file.add_row(client_dat_file, i, client_result)
        dat_file.add_row(server_dat_file, i, server_result)


def process_dsa():
    """
    Process sim3 DSA results
    :return:
    """

    client_dat_file = constants.CLIENT_DAT_FILE_FORMAT.format(constants.SIM3_FILE, constants.DSA_FILE)
    server_dat_file = constants.SERVER_DAT_FILE_FORMAT.format(constants.SIM3_FILE, constants.DSA_FILE)

    dat_file.add_header(client_dat_file, constants.CLIENT_KEY_SIZE_DAT_FILE_HEADER)
    dat_file.add_header(server_dat_file, constants.SERVER_KEY_SIZE_DAT_FILE_HEADER)

    for i in range(1024, 3072 + 1, 1024):
        client_results_file = constants.CLIENT_RESULTS_FILE_FORMAT.format(constants.SIM3_FILE, constants.DSA_FILE, i)
        server_results_file = constants.SERVER_RESULTS_FILE_FORMAT.format(constants.SIM3_FILE, constants.DSA_FILE, i)

        client_result = client_results.process(client_results_file)
        server_result = server_results.process(server_results_file)

        dat_file.add_row(client_dat_file, i, client_result)
        dat_file.add_row(server_dat_file, i, server_result)
