# -*- coding: utf-8 -*-
"""
tube.utils.v
~~~~~~~~~~~~

This module defines thin wrappers around vim commands and functions.
"""

import vim


def echo(msg):
    """Display a simple feedback to the user via the command line."""
    vim.command('echom "[tube] {0}"'.format(msg.replace('"', '\"')))


