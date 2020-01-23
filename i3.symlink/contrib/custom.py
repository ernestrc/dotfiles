#!/usr/bin/env python
# -*- coding: utf-8 -*-

# This script is a simple wrapper which prefixes each i3status line with custom
# information. It is a python reimplementation of:
# http://code.stapelberg.de/git/i3status/tree/contrib/wrapper.pl
#
# To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/i3status/contrib/wrapper.py
# In the 'bar' section.
#
# In its current version it will display the cpu frequency governor, but you
# are free to change it to display whatever you like, see the comment in the
# source code below.
#
# © 2012 Valentin Haenel <valentin.haenel@gmx.de>
#
# This program is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License (WTFPL), Version
# 2, as published by Sam Hocevar. See http://sam.zoy.org/wtfpl/COPYING for more
# details.

import sys
import json
import subprocess

def server_active(name, port):
    """ Get if there is a server listening on port """
    if subprocess.call('nc -zv 127.0.0.1 ' + port, shell=True) == 0:
        return {'full_text' : name + ": yes", 'name' : name, 'color' : '##00ff9f'}
    else:
        return {'full_text' : name + ": no", 'name' : name, 'color' : '#fe0000'}

def bluetooth_powered():
    proc = subprocess.run(['sh','-c', 'bluetoothctl show | grep Powered | awk -F\'Powered:\' \'{print $2}\''], capture_output=True)
    line = proc.stdout
    if proc.returncode != 0 or not line:
        return {'full_text' : "bluetooth: n/a", 'name' : 'bluetooth'}
    line = line.decode('utf-8').rstrip()
    color = None
    if line == ' no':
        color = '#fe0000'
    else:
        color = '#00ff9f'
    return {'full_text' : "bluetooth:" + line, 'name' : 'bluetooth', 'color' : color}

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        # insert information into the start of the json, but could be anywhere
        # CHANGE THIS LINE TO INSERT SOMETHING ELSE
        j.insert(0, bluetooth_powered())
        # and echo back new encoded json
        # print_line(prefix+json.dumps(j).replace('#00ff9f', '#CA76EF').replace('#fe0000', '#F76564'))
        print_line(prefix+json.dumps(j).replace('#00ff9f', '#21F06B').replace('#fe0000', '#FF00FF'))
