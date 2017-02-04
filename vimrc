set nocompatible

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Variable configuration for Sublivim
let sbv_theme='molokai'
" Open NERDTree with vim
let sbv_open_nerdtree_to_start=1
" Open Nerd Panel with a new tab
let sbv_open_nerdtree_with_new_tab=1
" Enabled / Disabled placeholder chars
let sbv_display_placeholder=1
" Charactere placeholder for tabulation [2 char]
let sbv_tab_placeholder='»·'
" Charactere placeholder for space [1 char]
let sbv_space_placeholder='·'
" Enabled / Disabled space space for access in your vimrc
let sbv_quick_access_config=0
" Enabled / Disabled swap file
let sbv_swap_file=0
" Enabled / Disabled Shortcut
let sbv_smart_shortcut=1
" Indentation type [tab || space]
let sbv_indentation_type="tab"
" Indentation length
let sbv_indentation_length=4
" Relative numbers
let sbv_enable_numbers=1

let g:tube_terminal = "xterm"
let current_compiler = "gcc"

let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -Wall -Werror -Wextra'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_c_include_dirs = ['../../../include', '../../include','../include','./include']

let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1

let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-l>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<F6>'

let g:current_path_for_nerd_init=expand('%:p:h')

let g:ctrlp_map = '<C-f>'
let g:ctrlp_cmd = 'CtrlP'

call pathogen#infect()
call pathogen#helptags()

set encoding=utf-8
set mouse=a
set ai
set nu
set cc=80
set t_Co=256

set cursorline
set whichwrap+=<,>,h,l,[,]

hi CursorLine term=bold cterm=bold guibg=Grey40

set splitright

noremap <C-h> :GundoToggle<CR>

noremap <C-k>				:!(make)<CR>
noremap <C-g>				:NERDTreeToggle<CR>

inoremap <C-k>				<Esc>:help key-notation<CR>

inoremap <C-v>				<Esc>pi
inoremap <C-c>				<Esc>yi
inoremap <C-x>				<Esc>xi
inoremap <C-u>				<Esc><C-r>i
inoremap <C-a>				<Esc>gg<S-v>G

noremap <C-u>				<C-r>
noremap <C-p>				:!(open /System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app)<CR>
noremap <C-n>				:!norminette **/*.{c,h}<CR>
noremap <C-v>				p
noremap <C-c>				y
noremap <C-x>				x
noremap <C-a>				gg<S-v>G

set autochdir

set backspace=indent,eol,start

source ~/.Sublivim/config_perso

execute "set tabstop=". sbv_indentation_length
execute "set shiftwidth=". sbv_indentation_length
execute "set softtabstop=". sbv_indentation_length

if sbv_indentation_type == "space"
	set expandtab
endif


if !empty(sbv_smart_shortcut)
	noremap <C-w>				:q!<CR>
	inoremap <C-w>				<Esc>:q!<CR>

	noremap <S-Tab>				:tabprevious<CR>
	noremap <Tab>				:tabnext<CR>
	noremap <C-r>				:NERDTreeToggle<CR>:e<CR>:NERDTreeToggle<CR>

	noremap <C-d>				:vs 
	noremap <S-d>				:split 
	noremap <C-t>				:tabedit 
	inoremap <C-t>				<Esc>:tabedit 

	noremap <S-Right>			<C-w><Right>
	noremap <S-Left>			<C-w><Left>
	noremap <S-Up>				<C-w><Up>
	noremap <S-Down>			<C-w><Down>
	noremap <silent>	<C-s>	:w!<CR>
	noremap <silent>	<C-q>	:qa<CR>

	noremap +		:vertical resize +1<CR>
	noremap -		:vertical resize -1<CR>
	noremap ~		<C-w>=

	inoremap <silent>	<C-s>	<Esc>:w!<CR>
	inoremap <silent>	<C-q>	<Esc>:qa<CR>

	vnoremap <Tab>				>
	vnoremap <S-Tab>			<
endif

if !empty(sbv_quick_access_config)
	noremap <Space><Space>		:tabedit ~/.vimrc<CR>
endif

syntax on
if !empty(sbv_theme)
	execute "colorscheme ".  sbv_theme
endif

if empty(sbv_swap_file)
	set noswapfile
endif

if !empty(sbv_display_placeholder)
	execute "set list listchars=tab:". sbv_tab_placeholder .",trail:". sbv_space_placeholder
endif

let g:enable_numbers = sbv_enable_numbers

autocmd VimEnter * call s:actionForOpen(sbv_open_nerdtree_to_start)
function! s:actionForOpen(openNerdTree)
	let filename = expand('%:t')
	if !empty(a:openNerdTree)
		NERDTree
	endif
	if !empty(filename)
		wincmd l
	endif
endfunction

autocmd BufCreate * call s:addingNewTab(sbv_open_nerdtree_with_new_tab)
function! s:addingNewTab(openNerdTree)
	let filename = expand('%:t')
	if winnr('$') < 2 && exists('t:NERDTreeBufName') == 0
		if !empty(a:openNerdTree)
			NERDTree
		endif
		if !empty(filename)
			wincmd l
		endif
	endif
endfunction

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
function! s:CloseIfOnlyNerdTreeLeft()
	if exists("t:NERDTreeBufName")
		if bufwinnr(t:NERDTreeBufName) != -1
			if winnr("$") == 1
				q
			endif
		endif
	endif
endfunction

