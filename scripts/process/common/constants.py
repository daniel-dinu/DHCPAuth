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


# CSV file access mode
CSV_FILE_ACCESS_MODE = 'r'


# CSV file format
CSV_DELIMITER = ','
CSV_QUOTECHAR = '"'


# The number of rows to be ignored at the beginning and at the end of the CSV file
IGNORE_ROWS = 5


# CSV columns
TOTAL_TIME_COLUMN_INDEX = 0

AUTH_SIGN_TIME_COLUMN_INDEX = 1
AUTH_VERIFY_TIME_COLUMN_INDEX = 2

SIGN_PACKET_LENGTH_COLUMN_INDEX = 3
SIGN_AUTH_LENGTH_COLUMN_INDEX = 4

VERIFY_PACKET_LENGTH_COLUMN_INDEX = 5
VERIFY_AUTH_LENGTH_COLUMN_INDEX = 6


# Error messages
CONVERT_TOTAL_TIME_ERROR_MESSAGE = "Error on line {} of file '{}': could not convert 'total time' data '{}' to float!"

CONVERT_AUTH_SIGN_TIME_ERROR_MESSAGE = "Error on line {} of file '{}': could not convert 'auth sign time' data '{}' " \
                                       "to float!"

CONVERT_AUTH_VERIFY_TIME_ERROR_MESSAGE = "Error on line {} of file '{}': could not convert 'auth verify time' data " \
                                         "'{}' to float!"

CONVERT_SIGN_PACKET_LENGTH_ERROR_MESSAGE = "Error on line {} of file '{}': could not convert 'sign packet length' " \
                                           "data '{}' to int!"
SIGN_PACKET_LENGTH_ERROR_MESSAGE = "Error on line {} of file '{}': current 'sign packet length' value '{}' does not " \
                                   "match the previous one '{}'!"

CONVERT_SIGN_AUTH_LENGTH_ERROR_MESSAGE = "Error on line {} of file '{}': could not convert 'sign auth length' data " \
                                         "'{}' to int!"
SIGN_AUTH_LENGTH_ERROR_MESSAGE = "Error on line {} of file '{}': current 'sign auth length' value '{}' does not " \
                                 "match the previous one '{}'!"

CONVERT_VERIFY_PACKET_LENGTH_ERROR_MESSAGE = "Error on line {} of file '{}': could not convert 'verify packet " \
                                             "length' data '{}' to int!"
VERIFY_PACKET_LENGTH_ERROR_MESSAGE = "Error on line {} of file '{}': current 'verify packet length' value '{}' " \
                                     "does not match the previous one '{}'!"

CONVERT_VERIFY_AUTH_LENGTH_ERROR_MESSAGE = "Error on line {} of file '{}': could not convert 'verify auth length' " \
                                           "data '{}' to int!"
VERIFY_AUTH_LENGTH_ERROR_MESSAGE = "Error on line {} of file '{}': current 'verify auth length' value '{}' does not " \
                                   "match the previous one '{}'!"


# DAT file
DAT_FILE_HEADER_ACCESS_MODE = 'w'
DAT_FILE_HEADER = "{} \n"

DAT_FILE_ROW_ACCESS_MODE = 'a'
DAT_FILE_ROW = "{} "
DAT_FILE_NEW_LINE = "\n"


# DAT file header
CLIENT_KEY_SIZE_DAT_FILE_HEADER = '# KEY_SIZE SIGN_TOTAL_TIME VERIFY_TOTAL_TIME AUTH_SIGN_TIME AUTH_VERIFY_TIME ' \
                                  'SIGN_PACKET_LENGTH SIGN_AUTH_LENGTH VERIFY_PACKET_LENGTH VERIFY_AUTH_LENGTH'
SERVER_KEY_SIZE_DAT_FILE_HEADER = '# KEY_SIZE TOTAL_TIME AUTH_SIGN_TIME AUTH_VERIFY_TIME SIGN_PACKET_LENGTH ' \
                                  'SIGN_AUTH_LENGTH VERIFY_PACKET_LENGTH VERIFY_AUTH_LENGTH'

CLIENT_ELLIPTIC_CURVE_DAT_FILE_HEADER = '# ELLIPTIC_CURVE SIGN_TOTAL_TIME VERIFY_TOTAL_TIME AUTH_SIGN_TIME ' \
                                        'AUTH_VERIFY_TIME SIGN_PACKET_LENGTH SIGN_AUTH_LENGTH VERIFY_PACKET_LENGTH ' \
                                        'VERIFY_AUTH_LENGTH'
SERVER_ELLIPTIC_CURVE_DAT_FILE_HEADER = '# ELLIPTIC_CURVE TOTAL_TIME AUTH_SIGN_TIME AUTH_VERIFY_TIME ' \
                                        'SIGN_PACKET_LENGTH SIGN_AUTH_LENGTH VERIFY_PACKET_LENGTH VERIFY_AUTH_LENGTH'

CLIENT_NUMBER_OF_KEYS_DAT_FILE_HEADER = '# NUMBER_OF_KEYS SIGN_TOTAL_TIME VERIFY_TOTAL_TIME AUTH_SIGN_TIME ' \
                                        'AUTH_VERIFY_TIME SIGN_PACKET_LENGTH SIGN_AUTH_LENGTH VERIFY_PACKET_LENGTH ' \
                                        'VERIFY_AUTH_LENGTH'
SERVER_NUMBER_OF_KEYS_DAT_FILE_HEADER = '# NUMBER_OF_KEYS TOTAL_TIME AUTH_SIGN_TIME AUTH_VERIFY_TIME ' \
                                        'SIGN_PACKET_LENGTH SIGN_AUTH_LENGTH VERIFY_PACKET_LENGTH VERIFY_AUTH_LENGTH'


# File paths
CLIENT_DAT_FILE_FORMAT = './../../processed/{}/client_{}.dat'
SERVER_DAT_FILE_FORMAT = './../../processed/{}/server_{}.dat'

CLIENT_RESULTS_FILE_FORMAT = './../../results/{0}/client/{1}/statistics_{1}_{2}.csv'
SERVER_RESULTS_FILE_FORMAT = './../../results/{0}/server/{1}/statistics_{1}_{2}.csv'

SIM1_FILE = 'sim1'
SIM2_FILE = 'sim2'
SIM3_FILE = 'sim3'
SIM4_FILE = 'sim4'
SIM5_FILE = 'sim5'

RSA_FILE = 'rsa'
DSA_FILE = 'dsa'
EC_FILE = 'ec'
