set nocompatible

filetype plugin on
set omnifunc=syntaxcomplete#Complete

let g:tube_terminal = "xterm"
let current_compiler = "gcc"

let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1

let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-l>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<F6>'

call pathogen#infect()
call pathogen#helptags()

syntax on
colorscheme molokai

set encoding=utf-8
set mouse=a
set ai
set nu
set cc=80
set ts=4
set t_Co=256
set shiftwidth=4

set noswapfile

set splitright

set list listchars=tab:»·,trail:·

noremap <Space><Space>		:tabedit ~/.vimrc<CR>

noremap <C-h> :GundoToggle<CR>

noremap <C-w>				:q!<CR>
noremap <S-Tab>				:tabprevious<CR>
noremap <Tab>				:tabnext<CR>
noremap <C-r>				:NERDTreeToggle<CR>:e<CR>:NERDTreeToggle<CR>
noremap <C-d>				:vs 
noremap <S-d>				:split 
noremap <C-t>				:tabedit 
noremap <C-k>				:!(make)<CR>
noremap <C-g>				:NERDTreeToggle<CR>

inoremap <C-w>				<Esc>:q!<CR>
inoremap <C-k>				<Esc>:help key-notation<CR>
inoremap <C-r>				<Esc>:NERDTreeToggle<CR>
inoremap <C-t>				<Esc>:tabedit 

noremap <S-Right>			<C-w><Right>
noremap <S-Left>			<C-w><Left>
noremap <S-Up>				<C-w><Up>
noremap <S-Down>			<C-w><Down>

inoremap <C-v>				<Esc>pi
inoremap <C-c>				<Esc>yi
inoremap <C-x>				<Esc>xi
inoremap <C-u>				<Esc><C-r>i
noremap <C-u>				<C-r>
noremap <C-n>				:!(~/.vim/shells/norminator *)<CR>
noremap <C-p>				:!(open /System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app)<CR>

noremap <C-v>				p
noremap <C-c>				y
noremap <C-x>				x

set backspace=indent,eol,start

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" " buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
	if exists("t:NERDTreeBufName")
		if bufwinnr(t:NERDTreeBufName) != -1
			if winnr("$") == 1
				q
			endif
		endif
	endif
endfunction
