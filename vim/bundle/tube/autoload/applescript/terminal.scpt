-- execute_terminal.scpt
-- last change: 19 Jan 2013
---
-- this script require an argument that represent the command to execute

on run argv

    set command to (item 1 of argv)

    tell application "Terminal"
        activate

        -- execute the command
        do script command in window 1

    end tell

    tell application "MacVim" to activate

end run
