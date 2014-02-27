" autoload/tube.vim

" Init
" ----------------------------------------------------------------------------

let s:current_folder = expand("<sfile>:p:h")
py import vim, sys
py sys.path.insert(0, vim.eval("s:current_folder"))
py import tube.core
py tube_plugin = tube.core.Tube()


" Wrappers
" ----------------------------------------------------------------------------

function! tube#RunCommand(start, end, args)
    py tube_plugin.run_command(int(vim.eval('a:start')), int(vim.eval('a:end')), vim.eval('a:args'))
endfunction

function! tube#RunCommandClear(start, end, args)
    py tube_plugin.run_command(int(vim.eval('a:start')), int(vim.eval('a:end')), vim.eval('a:args'), clear=True)
endfunction

function! tube#RunLastCommand()
    py tube_plugin.run_last_command()
endfunction

function! tube#CdIntoVimCwd()
    py tube_plugin.cd_into(vim.eval("getcwd()"))
endfunction

function! tube#InterruptRunningCommand()
    py tube_plugin.interrupt_term()
endfunction

function! tube#CloseTerminalWindow()
    py tube_plugin.close_term()
endfunction

function! tube#Alias(start, end, args)
    py tube_plugin.run_alias(int(vim.eval('a:start')), int(vim.eval('a:end')), vim.eval('a:args'))
endfunction

function! tube#AliasClear(start, end, args)
    py tube_plugin.run_alias(int(vim.eval('a:start')), int(vim.eval('a:end')), vim.eval('a:args'), clear=True)
endfunction

function! tube#ShowAliases()
    py tube_plugin.show_aliases()
endfunction
