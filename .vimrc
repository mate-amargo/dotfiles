"                    .
"    ##############..... ##############
"    ##############......##############
"      ##########..........##########
"      ##########........##########
"      ##########.......##########
"      ##########.....##########..                _
"      ##########....##########.....       __   _(_)_ __ ___  _ __ ___
"    ..##########..##########.........     \ \ / / | '_ ` _ \| '__/ __|
"  ....##########.#########.............    \ V /| | | | | | | | | (__
"    ..################JJJ............       \_/ |_|_| |_| |_|_|  \___|
"      ################.............
"      ##############.JJJ.JJJJJJJJJJ
"      ############...JJ...JJ..JJ  JJ
"      ##########....JJ...JJ..JJ  JJ
"      ########......JJJ..JJJ JJJ JJJ
"      ######    .........
"                  .....
"                    .
"

set nocompatible " This option is set if vimrc exists, i.e. it's not really necesary

syntax enable
filetype plugin indent on

" This specifies where in Insert mode the <BS> is allowed to delete
" the white space at the start of the line, a line break and the
" character before where Insert mode started.
set backspace=indent,eol,start

set history=100

" Peristent undo
set undofile
set undodir=~/.vim/undo

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

set ruler
set showcmd

set splitright

set wildmenu " Display all matching files when we tab complete

" Tab settings
set tabstop=2     " Number of spaces that a <Tab> in the file counts
set softtabstop=2 " Number of spaces that a <Tab> counts for while performing
									" editing operations like inserting a <Tab> or using <BS>
set shiftwidth=2  " Amount that >> indents
set noexpandtab   " (no)expandtab = (don't )replace tabs with spaces

set linebreak " Wrap long lines
set display=truncate " Show @@@ in the last line if it is truncated, instead of hiding the whole line.

set hidden " Don't warn when changing buffers with unsaved changes

set number
set relativenumber
set cursorline

set incsearch "show partial matches for a search phrase
set hlsearch

set clipboard=unnamedplus "allows yanking to (or pasting from) the system clipboard

" Latex Macros
" map \e Ypki\begin{<Esc>ea}<Esc>j^i\end{<Esc>ea}<Esc>
" map \t i\texttt{}<Esc>

" Tab character to      → u2192
" and EOL to            ↲ u21b2
" and space to          ⎵ u23b5
set listchars=tab:→\ ,eol:↲,space:⎵

" Different cursors for different modes
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

let &t_SI = "\<Esc>[6 q" "SI = INSERT mode
let &t_SR = "\<Esc>[4 q" "SR = REPLACE mode
let &t_EI = "\<Esc>[2 q" "EI = NORMAL mode (ELSE)

abbr ture true
abbr flase false

set spelllang=es,en_us

" Netrw settings
let g:netrw_banner=0        " disable banner, bring back up with I
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'  " Hide filenames starting with a dot
																								" gh toggles hidden filenames
let g:netrw_winsize = 0 " set default window size to be always equal
let g:netrw_preview = 1 " open splits to the right

" vim-plug plugin manager
call plug#begin('~/.vim/plugged')

	Plug 'vim-airline/vim-airline'					" Cool status bar
	Plug 'vim-airline/vim-airline-themes'		" bar themes
	"Plug 'sjl/badwolf'											" Colorscheme
	Plug 'morhetz/gruvbox'									" Colorscheme
	Plug 'nathanaelkane/vim-indent-guides'	" Visual indents
	Plug 'lervag/vimtex'										" Latex Integration
	Plug 'SirVer/ultisnips'									" Snippets engine
	Plug 'honza/vim-snippets'								" Actual snippets
	Plug 'preservim/nerdtree'								" File browser
	Plug 'preservim/nerdcommenter'					" Vim plugin for intensely nerdy commenting powers
	Plug 'ycm-core/YouCompleteMe'						" Code completion engine
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Markdown Preview
	Plug 'chrisbra/Colorizer'               " Color Highlight

" terryma/vim-multiple-cursors " True Sublime Text style multiple selections for Vim

call plug#end()

" Airline plugin config
set t_Co=256
let g:airline_powerline_fonts = 1

" Indent-Guides config
let g:indent_guides_enable_on_vim_startup = 0 " Autostart
let g:indent_guides_default_mapping = 0				" Remove the <leader>ig default mapping

" UltiSnips config
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" YouCompleteMe config
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
let g:ycm_autoclose_preview_window_after_completion=1

" Colorschemes
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark="hard"
hi Normal guibg=NONE ctermbg=NONE
hi TabLineFill guibg=NONE ctermbg=NONE
hi TabLine guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
let g:airline_theme='gruvbox'
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black ctermbg=darkgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=white ctermbg=gray

"if empty(v:servername) && exists('*remote_startserver')
"	call remote_startserver('VIM')
"endif

" Latex settings
"set conceallevel=2		" Hidden unless it has a replacement character
"set concealcursor=nvc " Conceal characters in Normal, Visual, Command
"let g:tex_conceal="abdmgs"
"	a = accents/ligatures
"	b = bold and italic
"	d = delimiters
"	m = math symbols
"	g = Greek
"	s = superscripts/subscripts
let g:vimtex_compiler_latexmk = {
	\ 'options' : [
	\ '-pdf',
	\ '-shell-escape',
	\ '-verbose',
	\ '-file-line-error',
	\ '-synctex=1',
	\ '-interaction=nonstopmode',
	\ ],
	\}

" Haskell settings
autocmd FileType haskell setlocal ts=2 sts=2 sw=2 expandtab

" Python settings
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab fileformat=unix
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.c,*.h match BadWhitespace /\s\+$/

" Commands
command TrailingRemove %s/\s\+$//e
command AccentsConvert %s/\\'a/á/g | %s/\\'e/é/g | %s/\\'i/í/g | %s/\\'o/ó/g | %s/\\'u/ú/g

" Keybindings
let mapleader=" "
let maplocalleader=" "
map <F2> :set nu rnu! <CR>
map <leader><F2> :set nonu nornu <CR>
map <F3> :set nohlsearch! <CR>
map <F4> :set list! <CR>
map <F5> :set expandtab! <CR> :set expandtab? <CR>
map <F6> :set spell! <CR>
map <F7> :NERDTreeToggle<CR>
map <F8> :IndentGuidesToggle<CR>
" Left/Right = Previous/Next tabpage
map OD :tabp<CR>
map OC :tabn<CR>
imap OD <esc>:tabp<CR>
imap OC <esc>:tabn<CR>
" Up/Down = First/Last tabpage
map OA :tabfirst<CR>
map OB :tablast<CR>
imap OA <esc>:tabfirst<CR>
imap OB <esc>:tablast<CR>
" Ctrl-Up/Down = Previous/Next buffer
map [1;5A :bp<CR>
map [1;5A :bp<CR>
imap [1;5B <esc>:bn<CR>
imap [1;5B <esc>:bn<CR>

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
