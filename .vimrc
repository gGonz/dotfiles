""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  VIM Config                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NeoBundle ---------------------------------------------------------------- {{{
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
    if &compatible
        set nocompatible               " Be iMproved
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'klen/python-mode'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
" }}}



" Visual settings ---------------------------------------------------------- {{{
syntax on
colorscheme molokai

set number
set laststatus=2
set t_Co=256
set cursorline
set nowrap
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
"set guifont=Ubuntu\ Mono\ derivative\ Powerline
set encoding=utf-8

" Better Syntatic error colors
highlight SyntasticError ctermbg=89 guibg=89
highlight SyntasticWarning ctermbg=89 guibg=89
highlight SyntasticStyleError ctermbg=89 guibg=89
highlight SyntasticStyleWarning ctermbg=89 guibg=89

" Highlight line excess at colum 80
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=Red guibg=Red
    autocmd FileType python match Excess /\%80v.*/
augroup END
" }}}



" Mappings ----------------------------------------------------------------- {{{
imap <Home> <C-o>^
nmap <Home> ^
" }}}


" Code style --------------------------------------------------------------- {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=80
set smarttab
set expandtab
" }}}



" Plugins ------------------------------------------------------------------ {{{
" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme="badwolf"

" AutoPairs
au FileType htmldjango let b:AutoPairs = {
    \ '(':')', '[':']', '{':'}', '%':'%', '"':'"', "'":"'" }

" jedi-vim
let g:jedi#show_call_signatures = 0

" NERDTree
map <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '.*__pycache__.*']

" python-mode
let g:pymode_folding = 0
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_options_colorcolumn = 0

" Syntastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_check_on_open = 1
let g:syntastic_style_error_symbol = "->"
let g:syntastic_style_warning_symbol = "->"
" }}}



" Other settings ----------------------------------------------------------- {{{
set splitright
set splitbelow
set pastetoggle=<F3>

" Auto-reload settings when .vimrc is updated
augroup myvimrc
    au!
    au BufWritePost .vimrc so $MYVIMRC |
        \ if has('gui running') | sp $MYGVIMRC | endif
augroup END
" }}}
