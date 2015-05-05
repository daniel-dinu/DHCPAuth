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
    Process sim4 results
    :return:
    """

    process_rsa()
    process_dsa()
    process_ec()


def process_rsa():
    """
    Process sim4 RSA results
    :return:
    """

    client_dat_file = constants.CLIENT_DAT_FILE_FORMAT.format(constants.SIM4_FILE, constants.RSA_FILE)
    server_dat_file = constants.SERVER_DAT_FILE_FORMAT.format(constants.SIM4_FILE, constants.RSA_FILE)

    dat_file.add_header(client_dat_file, constants.CLIENT_KEY_SIZE_DAT_FILE_HEADER)
    dat_file.add_header(server_dat_file, constants.SERVER_KEY_SIZE_DAT_FILE_HEADER)

    for i in range(512, 7680 + 1, 512):
        client_results_file = constants.CLIENT_RESULTS_FILE_FORMAT.format(constants.SIM4_FILE, constants.RSA_FILE, i)
        server_results_file = constants.SERVER_RESULTS_FILE_FORMAT.format(constants.SIM4_FILE, constants.RSA_FILE, i)

        client_result = client_results.process(client_results_file)
        server_result = server_results.process(server_results_file)

        dat_file.add_row(client_dat_file, i, client_result)
        dat_file.add_row(server_dat_file, i, server_result)


def process_dsa():
    """
    Process sim4 DSA results
    :return:
    """

    client_dat_file = constants.CLIENT_DAT_FILE_FORMAT.format(constants.SIM4_FILE, constants.DSA_FILE)
    server_dat_file = constants.SERVER_DAT_FILE_FORMAT.format(constants.SIM4_FILE, constants.DSA_FILE)

    dat_file.add_header(client_dat_file, constants.CLIENT_KEY_SIZE_DAT_FILE_HEADER)
    dat_file.add_header(server_dat_file, constants.SERVER_KEY_SIZE_DAT_FILE_HEADER)

    for i in range(512, 7680 + 1, 512):
        client_results_file = constants.CLIENT_RESULTS_FILE_FORMAT.format(constants.SIM4_FILE, constants.DSA_FILE, i)
        server_results_file = constants.SERVER_RESULTS_FILE_FORMAT.format(constants.SIM4_FILE, constants.DSA_FILE, i)

        client_result = client_results.process(client_results_file)
        server_result = server_results.process(server_results_file)

        dat_file.add_row(client_dat_file, i, client_result)
        dat_file.add_row(server_dat_file, i, server_result)


def process_ec():
    """
    Process sim4 EC results
    :return:
    """

    client_dat_file = constants.CLIENT_DAT_FILE_FORMAT.format(constants.SIM4_FILE, constants.EC_FILE)
    server_dat_file = constants.SERVER_DAT_FILE_FORMAT.format(constants.SIM4_FILE, constants.EC_FILE)

    dat_file.add_header(client_dat_file, constants.CLIENT_ELLIPTIC_CURVE_DAT_FILE_HEADER)
    dat_file.add_header(server_dat_file, constants.SERVER_ELLIPTIC_CURVE_DAT_FILE_HEADER)

    elliptic_curves = \
        (
            'secp112r1',
            'secp112r2',
            'secp128r1',
            'secp128r2',
            'secp160k1',
            'secp160r1',
            'secp160r2',
            'secp192k1',
            'secp224k1',
            'secp224r1',
            'secp256k1',
            'secp384r1',
            'secp521r1',
            'prime192v1',
            'prime192v2',
            'prime192v3',
            'prime239v1',
            'prime239v2',
            'prime239v3',
            'prime256v1',
            'sect113r1',
            'sect113r2',
            'sect131r1',
            'sect131r2',
            'sect163k1',
            'sect163r1',
            'sect163r2',
            'sect193r1',
            'sect193r2',
            'sect233k1',
            'sect233r1',
            'sect239k1',
            'sect283k1',
            'sect283r1',
            'sect409k1',
            'sect409r1',
            'sect571k1',
            'sect571r1',
            'c2pnb163v1',
            'c2pnb163v2',
            'c2pnb163v3',
            'c2pnb176v1',
            'c2tnb191v1',
            'c2tnb191v2',
            'c2tnb191v3',
            'c2pnb208w1',
            'c2tnb239v1',
            'c2tnb239v2',
            'c2tnb239v3',
            'c2pnb272w1',
            'c2pnb304w1',
            'c2tnb359v1',
            'c2pnb368w1',
            'c2tnb431r1',
            'wap-wsg-idm-ecid-wtls1',
            'wap-wsg-idm-ecid-wtls3',
            'wap-wsg-idm-ecid-wtls4',
            'wap-wsg-idm-ecid-wtls5',
            'wap-wsg-idm-ecid-wtls6',
            'wap-wsg-idm-ecid-wtls7',
            'wap-wsg-idm-ecid-wtls8',
            'wap-wsg-idm-ecid-wtls9',
            'wap-wsg-idm-ecid-wtls10',
            'wap-wsg-idm-ecid-wtls11',
            'wap-wsg-idm-ecid-wtls12',
        )

    for i in elliptic_curves:
        client_results_file = constants.CLIENT_RESULTS_FILE_FORMAT.format(constants.SIM4_FILE, constants.EC_FILE, i)
        server_results_file = constants.SERVER_RESULTS_FILE_FORMAT.format(constants.SIM4_FILE, constants.EC_FILE, i)

        client_result = client_results.process(client_results_file)
        server_result = server_results.process(server_results_file)

        dat_file.add_row(client_dat_file, i, client_result)
        dat_file.add_row(server_dat_file, i, server_result)
