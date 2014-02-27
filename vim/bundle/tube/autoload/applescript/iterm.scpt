-- execute_iterm.scpt
-- last change: 19 Jan 2013
---
-- this script require an argument that represent the command to execute

on run argv

    set command to (item 1 of argv)
    
    tell application "iTerm"

        try
            set mysession to current session of current terminal
        on error
            set myterm to (make new terminal)
            tell myterm
                launch session "Default"
                set mysession to current session
            end tell
        end try

        -- execute the command
        tell mysession
            write text command
        end tell

    end tell

end run
