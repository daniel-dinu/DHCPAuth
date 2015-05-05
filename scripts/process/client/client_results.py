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

import csv

from common import constants


def validate(file, row_number, current_total_time, current_auth_sign_time, current_auth_verify_time,
             previous_sign_packet_length, current_sign_packet_length, previous_sign_auth_length,
             current_sign_auth_length, previous_verify_packet_length, current_verify_packet_length,
             previous_verify_auth_length, current_verify_auth_length):
    """
    Validate the given CSV row
    :param file: The file that contains the given row
    :param row_number: The row number
    :param current_total_time: The current total time
    :param current_auth_sign_time: The current auth sign time
    :param current_auth_verify_time: The current auth verify time
    :param previous_sign_packet_length: The previous sign packet length
    :param current_sign_packet_length: The current sign packet length
    :param previous_sign_auth_length: The previous sign auth length
    :param current_sign_auth_length: The current sign auth length
    :param previous_verify_packet_length: The previous verify packet length
    :param current_verify_packet_length: The current verify packet length
    :param previous_verify_auth_length: The previous verify auth length
    :param current_verify_auth_length: The current verify auth length
    :return: True if the given CSV row is valid; False otherwise
    """

    try:
        float(current_total_time)
    except ValueError:
        print(constants.CONVERT_TOTAL_TIME_ERROR_MESSAGE.format(file, row_number, current_total_time))
        return False

    try:
        auth_sign_time = float(current_auth_sign_time)
    except ValueError:
        print(constants.CONVERT_AUTH_SIGN_TIME_ERROR_MESSAGE.format(row_number, file, current_auth_sign_time))
        return False

    try:
        auth_verify_time = float(current_auth_verify_time)
    except ValueError:
        print(constants.CONVERT_AUTH_VERIFY_TIME_ERROR_MESSAGE.format(row_number, file, current_auth_verify_time))
        return False

    try:
        value = int(current_sign_packet_length)
    except ValueError:
        print(constants.CONVERT_SIGN_PACKET_LENGTH_ERROR_MESSAGE.format(row_number, file, current_sign_packet_length))
        return False

    if 0 != previous_sign_packet_length and 0 != value and previous_sign_packet_length != value:
        print(constants.SIGN_PACKET_LENGTH_ERROR_MESSAGE.format(row_number, file, value, previous_sign_packet_length))
        return False

    try:
        value = int(current_sign_auth_length)
    except ValueError:
        print(constants.CONVERT_SIGN_AUTH_LENGTH_ERROR_MESSAGE.format(row_number, file, current_sign_auth_length))
        return False

    if 0 != previous_sign_auth_length and 0 != value and previous_sign_auth_length != value:
        print(constants.SIGN_AUTH_LENGTH_ERROR_MESSAGE.format(row_number, file, value, previous_sign_auth_length))
        return False

    try:
        value = int(current_verify_packet_length)
    except ValueError:
        print(constants.CONVERT_VERIFY_PACKET_LENGTH_ERROR_MESSAGE.format(row_number, file,
                                                                          current_verify_packet_length))
        return False

    if 0 != previous_verify_packet_length and 0 != value and previous_verify_packet_length != value:
        print(constants.VERIFY_PACKET_LENGTH_ERROR_MESSAGE.format(row_number, file, value,
                                                                  previous_verify_packet_length))
        return False

    try:
        value = int(current_verify_auth_length)
    except ValueError:
        print(constants.CONVERT_VERIFY_AUTH_LENGTH_ERROR_MESSAGE.format(row_number, file, current_verify_auth_length))
        return False

    if 0 != previous_verify_auth_length and 0 != value and previous_verify_auth_length != value:
        print(constants.VERIFY_AUTH_LENGTH_ERROR_MESSAGE.format(row_number, file, value, previous_verify_auth_length))
        return False

    return True


def process(file):
    """
    Process the given client results  CSV file
    :param file: The client results CSV file
    :return: The result of processing the given file: mean total sign time, mean total verify time, mean auth sign time,
    mean auth verify time, sign packet length, sign auth length, verify packet length and verify auth length
    """

    total_sign_time = float(0)
    total_verify_time = float(0)

    auth_sign_time = float(0)
    auth_verify_time = float(0)

    sign_packet_length = 0
    sign_auth_length = 0

    verify_packet_length = 0
    verify_auth_length = 0

    count_sign = 0
    count_verify = 0

    with open(file, constants.CSV_FILE_ACCESS_MODE) as csv_file:
        reader = csv.reader(csv_file, delimiter=constants.CSV_DELIMITER, quotechar=constants.CSV_QUOTECHAR)

        rows = list(reader)
        total_rows = len(rows)

        for i, row in enumerate(rows):

            # If not first row (CSV header) or ignored rows
            if 0 != i and 2 * constants.IGNORE_ROWS < i < total_rows - 2 * constants.IGNORE_ROWS:

                valid = validate(file, i,
                                 row[constants.TOTAL_TIME_COLUMN_INDEX],
                                 row[constants.AUTH_SIGN_TIME_COLUMN_INDEX],
                                 row[constants.AUTH_VERIFY_TIME_COLUMN_INDEX],
                                 sign_packet_length, row[constants.SIGN_PACKET_LENGTH_COLUMN_INDEX],
                                 sign_auth_length, row[constants.SIGN_AUTH_LENGTH_COLUMN_INDEX],
                                 verify_packet_length, row[constants.VERIFY_PACKET_LENGTH_COLUMN_INDEX],
                                 verify_auth_length, row[constants.VERIFY_AUTH_LENGTH_COLUMN_INDEX])

                if valid:
                    sign_packet_length_value = int(row[constants.SIGN_PACKET_LENGTH_COLUMN_INDEX])
                    sign_auth_length_value = int(row[constants.SIGN_AUTH_LENGTH_COLUMN_INDEX])

                    verify_packet_length_value = int(row[constants.VERIFY_PACKET_LENGTH_COLUMN_INDEX])
                    verify_auth_length_value = int(row[constants.VERIFY_AUTH_LENGTH_COLUMN_INDEX])

                    auth_sign_time_value = float(row[constants.AUTH_SIGN_TIME_COLUMN_INDEX])
                    auth_verify_time_value = float(row[constants.AUTH_VERIFY_TIME_COLUMN_INDEX])

                    if 0 != sign_packet_length_value and 0 != sign_auth_length_value:
                        total_sign_time += float(row[constants.TOTAL_TIME_COLUMN_INDEX])
                        auth_sign_time += auth_sign_time_value

                        sign_packet_length = sign_packet_length_value
                        sign_auth_length = sign_auth_length_value

                        count_sign += 1
                    else:
                        if 0 != verify_packet_length_value and 0 != verify_auth_length_value:
                            total_verify_time += float(row[constants.TOTAL_TIME_COLUMN_INDEX])
                            auth_verify_time += auth_verify_time_value

                            verify_packet_length = verify_packet_length_value
                            verify_auth_length = verify_auth_length_value

                            count_verify += 1

    if 0 != count_sign:
        total_sign_time /= count_sign
        auth_sign_time /= count_sign

    if 0 != count_verify:
        total_verify_time /= count_verify
        auth_verify_time /= count_verify

    result = \
        (
            total_sign_time,
            total_verify_time,

            auth_sign_time,
            auth_verify_time,

            sign_packet_length,
            sign_auth_length,

            verify_packet_length,
            verify_auth_length
        )

    return result
