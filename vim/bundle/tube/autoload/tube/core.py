# -*- coding: utf-8 -*-
"""
tube.core
~~~~~~~~~

This module defines the Tube class. This class provides all
main functionalities for the Tube plugin.
"""

import os
import vim

from tube.utils import v
from tube.utils import misc
from tube.utils import settings


class Tube:

    def __init__(self):
        self.last_command = ''
        self.term = settings.get('terminal').lower()
        scpt_loc = os.path.dirname(vim.eval('globpath(&rtp, "autoload/tube.vim")')) + "/applescript/"
        self.BASE_CMD = "osascript " + scpt_loc + self.term + ".scpt"
        self.BASE_CMD_INLINE = "osascript -e"

    def run_command(self, start, end, command, clear=False):
        """To Run the command as the given command"""
        self.last_command = command

        if command and settings.get('bufname_expansion', bool):
            command = misc.expand_chars(command, '%', vim.current.buffer.name)

        if command and settings.get('selection_expansion', bool):
            command = misc.expand_chars(
                command, '@', '\r'.join(vim.current.buffer[start-1:end]))

        if command and settings.get('function_expansion', bool):
            try:
                command = misc.expand_functions(command)
            except NameError:  # the function does not exist
                v.echo('unknown function')
                return
            except ValueError:  # bad arguments
                v.echo('bad arguments')
                return

        if not command or settings.get('always_clear_screen', bool):
            clear = True

        self.run(command, clear=clear)

    def run_alias(self, start, end, alias, clear=False):
        """Lookup a command given its alias and execute it."""
        command = settings.get('aliases').get(alias)
        if command:
            self.run_command(start, end, command, clear)
        else:
            v.echo("'{}' alias not found".format(alias))

    def run_last_command(self):
        """Execute the last executed command."""
        if self.last_command:
            self.run_command(1, 1, self.last_command)
        else:
            v.echo('no last command to execute')

    def run(self, command, clear=False):
        """Send the command to the terminal of choiche."""
        command = command.replace('\\', '\\\\').replace('"', '\\"')
        os.popen('{} "{}"'.format(
            self.BASE_CMD, 'clear;' if clear else '' + command.strip()))

    def cd_into(self, path):
        """To `cd` into the give path."""
        self.run_command(1, 1, "cd {}".format(path))

    def interrupt_term(self):
        """To interrupt the running command in the terminal window."""
        scpt = """
            tell application "{}" to activate
            tell application "System Events"
                keystroke "c" using control down
            end tell
            tell application "MacVim" to activate"""
        os.popen("{} '{}'".format(self.BASE_CMD_INLINE, scpt.format(self.term)))

    def focus_term(self):
        """To give focus to the terminal window."""
        scpt = 'tell application "{}" to activate'.format(self.term)
        os.popen("{} '{}'".format(self.BASE_CMD_INLINE, scpt))

    def close_term(self):
        """To close the terminal window."""
        scpt = 'tell application "{}" to quit'.format(self.term)
        os.popen("{} '{}'".format(self.BASE_CMD_INLINE, scpt))

    def show_aliases(self):
        """To show all defined aliases."""
        aliases = settings.get('aliases')
        if aliases:
            print('+ aliases')
            for i, alias in enumerate(aliases):
                conn = '└─ ' if i == len(aliases)-1 else '├─ '
                print(conn + alias + ': ' + aliases[alias])
        else:
            v.echo('no aliases found')
