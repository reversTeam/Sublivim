# -*- coding: utf-8 -*-
"""
tube.utils.misc
~~~~~~~~~~~~~~~

This module defines various utilities.
"""

import re
import vim
from itertools import groupby

from tube.utils import settings


def expand_chars(raw_str, target, repl): # {{{
    """Expand the character (target) in a string (raw_str) with another
    string (repl) .

        If n consecutive target characters are found they are replaced with
        n - 1 target characters, and no expansion is done.
    """
    if target not in raw_str:
        return raw_str

    out = ''
    for char_group in [''.join(g) for k, g in groupby(raw_str)]:
        if char_group == target:
            if repl:
                out += repl
            else:
                out += ''
        elif char_group.startswith(target):
            out += char_group[:-1]
        else:
            out += char_group

    return out


def expand_functions(raw_str):
    """Inject the return value of a function in the string where the
        function is specified as #{function_name}.

        The function is a vim function.
        FIX: not so awesome code
    """
    def escape(a):
        """Escape user input."""
        if a[0] == "'" and a[-1] == "'":
            a = '"' + a[1:-1]  + '"'

        if a[0] == '"' and a[-1] == '"' and len(a) > 1:
            r = a[1:-1].replace('\\', '\\\\').replace('"', '\\"')
            return a[0] + r + a[-1]

        elif re.match("\d+(\.\d+)?", a):  # is number
            return a

        else:
            raise ValueError

    def callf(match):
        """Call the matched function and inject its return value."""
        fun_name = match.group('fun')
        args = match.group('args')
        args_separator = settings.get('funargs_separator')

        if args:
            argv = [escape(a.strip())
                    for a in args.split(args_separator)]
        else:
            argv = []

        if fun_name:
            if '1' == vim.eval("exists('*{0}')".format(fun_name)):
                try:
                    raw = vim.eval("call('{0}',[{1}])".format(
                        fun_name, ','.join(argv)))
                    return raw.replace('\\', '\\\\')

                except vim.error:
                    pass
            else:
                raise NameError  # unkwown function

    return re.sub('#{(?P<fun>\w*)(\((?P<args>.*)\))?}', callf, raw_str)
