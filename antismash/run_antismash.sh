#!/bin/sh
'''exec' ./antismash/bin/python  "$0" "$@"
' '''
# -*- coding: utf-8 -*-
import re
import sys
from antismash.__main__ import entrypoint
if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', '', sys.argv[0])
    sys.exit(entrypoint())
