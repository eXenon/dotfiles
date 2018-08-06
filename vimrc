" General options
let mapleader = "\<Space>"
let g:netrw_liststyle = 3 " File explorer style

" Neovim plugins - may not be compatible with classical vim
call plug#begin('~/.config/nvim/plugs')
highlight Pmenu ctermfg=black ctermbg=white

" Vim plugs
Plug 'cocopon/iceberg.vim'
Plug 'morhetz/gruvbox'
Plug 'elixir-editors/vim-elixir'
Plug 'thinca/vim-ref'
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }
Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ElmCast/elm-vim'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
let g:highlighter#auto_update = 2

" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Flake8
let g:flake8_show_in_gutter = 1
autocmd FileType python map <buffer> <C-F> :call Flake8()<CR>

" Initialize plugs
call plug#end()

filetype plugin on
set syntax=on

" Always show powerline
set laststatus=2

" Use 256 colors
set t_Co=256

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Buffer management
set runtimepath^=~/.vim/bundle/ctrlp.vim
nmap <c-m> :bnext<CR>
nmap <c-l> :bprevious<CR>

" Tab management
noremap <C-Tab> :tabNext<CR>

" Allow to force sudo save
cmap w!! w !sudo tee % >/dev/null

" Disable stupid F1
noremap <F1> <nop>

" Display non-breaking space
set listchars=trail:◃,nbsp:•
set list

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Mouse bleuark
set mouse=""

" Toggle visibility
nmap <c-h> :set hlsearch!<CR>
nmap <c-j> :set number!<CR>
nmap <c-k> :set list!<CR>
nmap <c-l> :set cursorline!<CR>:set cursorcolumn!<CR>
nmap <c-m> :set nu!<CR>

" Statusline
hi User1 guifg=#eea040 guibg=#222222
hi User2 guifg=#dd3333 guibg=#222222
hi User3 guifg=#ff66ff guibg=#222222
hi User4 guifg=#a0ee40 guibg=#222222
hi User5 guifg=#eeee40 guibg=#222222
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
" set statusline +=%2*0x%04B\ %*          "character under cursor

" Remove delays for ESC key
set timeoutlen=1000 ttimeoutlen=0

" Colorscheme
colorscheme gruvbox
set background=dark

" Bépo conditionnal remapping
" if !empty(system("setxkbmap -print|grep bepo"))
"     source ~/.vimrc.bepo
" endif

" Leader Shortcuts
nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>
