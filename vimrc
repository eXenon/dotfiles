" General options
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
let g:netrw_liststyle = 3 " File explorer style

" Neovim plugins - may not be compatible with classical vim
call plug#begin('~/.config/nvim/plugs')
highlight Pmenu ctermfg=black ctermbg=white

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <C-p> :Files<CR>
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
nnoremap <C-g> :GGrep<CR>

" Theming

" Vim plugs
Plug 'thinca/vim-ref' " Docs on K-press
Plug 'ervandew/supertab' " Autocomplete on tab
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-fugitive'

" Fish stuff
Plug 'dag/vim-fish'
if &shell =~# 'fish$'
    set shell=sh
endif

" Elm stuff
Plug 'ElmCast/elm-vim' " Elm HL and elm-format on save

" VimWiki
Plug 'vimwiki/vimwiki'
let g:vimwiki_path='$KBFS/private/xaviernunn/wiki/'
let g:vimwiki_template_path='$KBFS/private/xaviernunn/wiki_templates/'

" Elixir stuff
Plug 'elixir-editors/vim-elixir' " Highlighting, indentation and filetype for elixir
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' } " Elixir docs, eval and completion
Plug 'mhinz/vim-mix-format'

" Highlighter
Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' }
let g:highlighter#auto_update = 2

" Date increment/decrement
Plug 'tpope/vim-speeddating'

" Python stuff
"   Flake8
Plug 'nvie/vim-flake8'
let g:flake8_show_in_gutter = 1
"   Autopep8
Plug 'tell-k/vim-autopep8'
let g:autopep8_on_save = 1
let g:autopep8_max_line_length = 120
let g:autopep8_disable_show_diff = 1
"   Import sorter
Plug 'fisadev/vim-isort'
let g:vim_isort_python_version = 'python3'
"   Autocmds
augroup pyautocmd
    au!
    "   Flake8 on command
    autocmd FileType python nnoremap <buffer> <C-F> :call Flake8()<CR>
    "   Break a function call into mutiple lines
    autocmd FileType python nnoremap <buffer> <leader>J :s/\((\zs\\|,\ *\zs\\|)\)/\r&/g<CR><Bar>:'[,']Autopep8<CR>:set nohlsearch<CR>
augroup END

" Initialize plugs
call plug#end()

set nocompatible
filetype plugin on
set syntax=on

" Always show powerline
set laststatus=2

" Colorscheme
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
" set t_8b=^[[48;2;%lu;%lu;%lum
" set t_8f=^[[38;2;%lu;%lu;%lum

" Autoformatting
augroup autoformatting
    au!
    autocmd FileType python noremap <buffer> <C-F> :call Flake8()<CR>
    autocmd FileType elixir noremap <buffer> <C-F> :MixFormat<CR>
augroup END

" Commenting
augroup commenting
    au!
    autocmd FileType python noremap <buffer> <C-C> :s/^/#<CR>/dhdhdhdhdh<CR>
    autocmd FileType elixir noremap <buffer> <C-C> :s/^/#<CR>/dhdhdhdhdh<CR>
    autocmd FileType javascript noremap <buffer> <C-C> :s/^/\/\/<CR>/dhdhdhdhdh<CR>
augroup END

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Buffer management
set runtimepath^=~/.vim/bundle/ctrlp.vim
nnoremap <c-m> :bnext<CR>

" Tab management
noremap <C-Tab> :tabNext<CR>

" Allow to force sudo save
cnoremap w!! w !sudo tee % >/dev/null

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
nnoremap <c-h> :set hlsearch!<CR>
nnoremap <c-j> :set number!<CR>
nnoremap <c-k> :set list!<CR>
nnoremap <c-l> :set cursorline!<CR>:set cursorcolumn!<CR>
nnoremap <c-m> :set nu!<CR>

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

" Leader Shortcuts
nnoremap <leader>w :w<cr>
nnoremap <leader>wq :wq<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader><left> :bp<cr>
nnoremap <leader><right> :bn<cr>
nnoremap <leader><ENTER> :set hlsearch!<CR>
nnoremap <leader>M zM
nnoremap <leader>J i<CR><ESC>

" Strict mode
inoremap <Left> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Right> <nop>

" Exercice stuff
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>t  itest<esc>
vnoremap <leader>' <esc>`<i'<esc>`>2li'<esc>h
vnoremap <leader>" <esc>"<i'<esc>`>2li"<esc>h
vnoremap <leader>) <esc>`<i(<esc>`>2li)<esc>h
vnoremap <leader>} <esc>`<i{<esc>`>2li}<esc>h
vnoremap <leader>] <esc>`<i[<esc>`>2li]<esc>h

" Language specific bindings
augroup ifabbrev
    au!
    autocmd FileType python :iabbrev <buffer> iff if:<left>
    autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
augroup END
