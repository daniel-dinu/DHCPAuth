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

from common import constants


def add_header(file, header):
    """
    Add the given header to the given DAT file
    :param file: The DAT file
    :param header: The header to be added
    :return:
    """

    f = open(file, constants.DAT_FILE_HEADER_ACCESS_MODE)

    f.write(constants.DAT_FILE_HEADER.format(header))

    f.close()


def add_row(file, row_header, row):
    """
    Add the given row to the given DAT file
    :param file: The DAT file
    :param row_header: The row header to be added
    :param row: The row to be added
    :return:
    """

    f = open(file, constants.DAT_FILE_ROW_ACCESS_MODE)

    f.write(constants.DAT_FILE_ROW.format(row_header))

    for i in row:
        f.write(constants.DAT_FILE_ROW.format(i))

    f.write(constants.DAT_FILE_NEW_LINE)

    f.close()
