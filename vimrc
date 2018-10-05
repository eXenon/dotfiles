" General options
let mapleader = "\<Space>"
let g:netrw_liststyle = 3 " File explorer style

" Neovim plugins - may not be compatible with classical vim
call plug#begin('~/.config/nvim/plugs')
highlight Pmenu ctermfg=black ctermbg=white

" vim-one Theme
Plug 'mhartington/oceanic-next'

" Vim plugs
Plug 'thinca/vim-ref' " Docs on K-press
Plug 'ElmCast/elm-vim' " Elm HL and elm-format on save
Plug 'ervandew/supertab' " Autocomplete on tab

" VimWiki
Plug 'vimwiki/vimwiki'
let g:vimwiki_path='/keybase/private/xaviernunn/wiki/'
let g:vimwiki_template_path='/keybase/private/xaviernunn/wiki_templates/'

" Elixir stuff
Plug 'elixir-editors/vim-elixir' " Highlighting, indentation and filetype for elixir
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' } " Elixir docs, eval and completion

" Highlighter
Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' }
let g:highlighter#auto_update = 2

" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Date increment/decrement
Plug 'tpope/vim-speeddating'

" Python stuff
"   Flake8
Plug 'nvie/vim-flake8'
let g:flake8_show_in_gutter = 1
autocmd FileType python map <buffer> <C-F> :call Flake8()<CR>
"   Autopep8
Plug 'tell-k/vim-autopep8'
let g:autopep8_on_save = 1
let g:autopep8_max_line_length = 120
let g:autopep8_disable_show_diff = 1

" Initialize plugs
call plug#end()

set nocompatible
filetype plugin on
set syntax=on

" Always show powerline
set laststatus=2

" Colorscheme
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum
set background=dark


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

" Bépo conditionnal remapping
" if !empty(system("setxkbmap -print|grep bepo"))
"     source ~/.vimrc.bepo
" endif

" Leader Shortcuts
nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>
nmap <leader>q :q<CR>
