" Initialize plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'joshdick/onedark.vim'

Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'

Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
call plug#end()


set exrc
set secure
set number
set nowrap
set cursorline
set splitright
set splitbelow
set pastetoggle=<F3>


if (has("termguicolors"))
  set termguicolors
endif


" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui_running"))
    augroup colorset
        autocmd!
        let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
        autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
    augroup END
endif

let g:onedark_terminal_italics=1
colorscheme onedark


" Mappings
inoremap <Home> <C-o>^
nnoremap <Home> ^
nnoremap <silent><expr> <leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
nnoremap <F8> :TagbarToggle<CR>


" Set Python interpreter path
let g:python3_host_prog='/home/ggonz/.pyenv/versions/3.7.2/envs/neovim/bin/python'


" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

" ALE
let g:ale_linters = {
\ 'python': ['flake8']
\}
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_fix_on_save = 1

" AutoPairs
au FileType htmldjango let b:AutoPairs = { '(':')', '[':']', '{':'}', '%':'%', '"':'"', "'":"'" }

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <silent><expr> <C-Space>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#manual_complete()
function! s:check_back_space() abort "{{{
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Gitgutter
let g:gitgutter_map_keys = 0

" Polyglot
let g:polyglot_disabled = ['python']
let g:polyglot_disabled = ['python-indent']

" NERDTree
map <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '.*__pycache__.*']


" Code style
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set list
set listchars=tab:›-,space:·,nbsp:␣,trail:~

" Set style options dynamically
function! SetStyleOptions(size, ...)
    let &tabstop = a:size
    let &softtabstop = a:size
    let &shiftwidth = a:size

    let l:expandtab = a:0 > 0 ? a:1 : 1
    let l:smarttab = a:0 > 1 ? a:2 : 1
    let l:showlist = a:0 > 2 ? a:3 : 1

    if expandtab == 0
        setlocal noexpandtab
    endif

    if smarttab == 0
        setlocal nosmarttab
    endif

    if showlist == 1
        setlocal list
    endif
endfunction

" Frontend
augroup filetype_frontend
    autocmd!
    autocmd FileType css call SetStyleOptions(2)
    autocmd FileType scss call SetStyleOptions(2)
    autocmd FileType html call SetStyleOptions(2)
    autocmd FileType htmldjango call SetStyleOptions(2)
    autocmd FileType javascript call SetStyleOptions(2)
augroup END

" C-like
augroup filetype_clike
    autocmd!
    autocmd FileType c call SetStyleOptions(8, 0, 0)
    autocmd FileType cpp call SetStyleOptions(8, 0, 0)
    autocmd FileType go call SetStyleOptions(8, 0, 0)
augroup END

" Another filetypes
augroup filetype_another
    autocmd!
    autocmd FileType dockerfile call SetStyleOptions(2)
augroup END
