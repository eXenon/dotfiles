" General options
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
let g:netrw_liststyle = 3 " File explorer style
au BufNewFile,BufRead /*.rasi setf css

set formatoptions+=j " Delete comment character when joining commented lines
set undodir=~/.config/nvim/undo " Persistent undo
set undofile
set relativenumber
set inccommand="" " Disable live replace (so sloooooowwwwww)

" Generic function to preserve cursor and search when using
" 'destructive' commands
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

" Neovim plugins - may not be compatible with classical vim
call plug#begin('~/.config/nvim/plugs')
highlight Pmenu ctermfg=black ctermbg=white

" Unicode shenanigans
Plug 'chrisbra/unicode.vim'

" LSP
Plug 'neovim/nvim-lspconfig'

" gundo
Plug 'simnalamburt/vim-mundo'
nnoremap <leader>u :MundoToggle<CR>

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <C-p> :GFiles<CR>
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
nnoremap <C-g> :GGrep<CR>

" Theming
Plug 'arcticicestudio/nord-vim'

" Vim focused editing
Plug 'junegunn/goyo.vim'
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
endfunction
function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nnoremap <leader>! :Goyo<CR>

" Vim plugs
Plug 'ervandew/supertab' " Autocomplete on tab
"   Set supertab to omnicompletion (powered by lsp)
autocmd FileType python let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd FileType python let g:SuperTabClosePreviewOnPopupClose = 1

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
let g:vimwiki_syntax = 'markdown'
let g:vimwiki_autowriteall=1
"   Notational velocity integration
Plug 'alok/notational-fzf-vim'
let g:nv_search_paths = ['$KBFS/private/xaviernunn/wiki/']
let g:nv_default_extension = '.wiki'


" Rust stuff
Plug 'simrat39/rust-tools.nvim'

" Elixir stuff
Plug 'elixir-editors/vim-elixir' " Highlighting, indentation and filetype for elixir
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' } " Elixir docs, eval and completion
Plug 'mhinz/vim-mix-format'

" Ocaml stuff
Plug 'ocaml/vim-ocaml'
augroup ocamlau
    au!

    "    Function to toggle between ml and mli files
    function! ToggleMLI()
        if expand('%:e') ==# "ml"
            execute "e " . expand('%:p') . "i"
        elseif expand('%:e') ==# "mli"
            execute "e " . substitute(expand('%:p'), ".mli", ".ml", "")
        end
    endfunction

    "    Function to use ocamlformat without the hassle
    function! Ocamlformat()
        let formatted=system('ocamlformat --enable-outside-detected-project ' . expand("%"))
        if v:shell_error == "0"
            call Preserve('%!ocamlformat --enable-outside-detected-project ' . expand("%"))
        endif
    endfunction

    "    Setup merlin
    if executable('opam')
        let g:opamshare = substitute(system('opam var share'),'\n$','','''')
        execute "set rtp+=" . g:opamshare . "/merlin/vim"
    endif
    nnoremap <leader>t :MerlinTypeOf<return>
    nnoremap <leader>g :MerlinLocate<return>

    "    Switch between ml and mli
    nnoremap <leader>m :call ToggleMLI()<return>
augroup END

" Highlighter
Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' }
let g:highlighter#auto_update = 2

" Python stuff
"   Flake8
Plug 'nvie/vim-flake8'
let g:flake8_show_in_gutter = 1
"   Black
Plug 'psf/black', { 'branch': 'stable' }
let g:black_linelength = 120
"   Import sorter
Plug 'fisadev/vim-isort'
let g:vim_isort_python_version = 'python3'
"   Jinja highlighter
Plug 'lepture/vim-jinja'

" Git integration
Plug 'tpope/vim-fugitive'

" Read inputs in format file:line
Plug 'bogado/file-line'

" Initialize plugs
call plug#end()

" Visual stuff
"    True colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum
colorscheme nord

set nocompatible
filetype plugin on
set syntax=on

" Always show powerline
set laststatus=2

" Autoformatting
augroup autoformatting
    au!
    autocmd FileType python nnoremap <buffer> <C-F> :Black<CR>
    autocmd FileType elixir nnoremap <buffer> <C-F> :MixFormat<CR>
    autocmd FileType elm nnoremap <buffer> <C-F> :ElmFormat<CR>
    autocmd FileType ocaml nnoremap <buffer> <C-F> :call Ocamlformat()<CR>
    autocmd FileType dart nnoremap <buffer> <C-F> :DartFmt<CR>
    autocmd FileType rust nnoremap <buffer> <C-F> :!cargo fmt<CR>
augroup END

" Commenting
augroup commenting
    au!
    autocmd FileType python noremap <buffer> <C-C> :s/^/#<CR>/dhdhdhdhdh<CR>
    autocmd FileType elixir noremap <buffer> <C-C> :s/^/#<CR>/dhdhdhdhdh<CR>
    autocmd FileType javascript noremap <buffer> <C-C> :s/^/\/\/<CR>/dhdhdhdhdh<CR>
    autocmd FileType elm noremap <buffer> <C-C> :s/^/--<CR>/dhdhdhdhdh<CR>
augroup END

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Buffer management
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

" Searches are case insensitive unless they contain at least one uppercase
set ignorecase
set smartcase

" Mouse bleuark
set mouse=""

" Split management
" 	New splits will be at the bottom or to the right side of the screen
set splitbelow
set splitright
"	Navigate between splits
nnoremap <leader>h <C-w><C-h>
nnoremap <leader>j <C-w><C-j>
nnoremap <leader>k <C-w><C-k>
nnoremap <leader>l <C-w><C-l>


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


" Quick shortcuts for buffers and files
nnoremap s :Buffers<CR>
nnoremap f :GFiles<CR>

" Toggle quickly between 2 spaces and 4 spaces TABs
function! TabsR2Spaces()
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endfunction
function! TabsR4Spaces()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
endfunction
nnoremap <leader>' :call TabsR4Spaces()<CR>
nnoremap <leader>é :call TabsR2Spaces()<CR>

" Avoid conflicting tmux bindings
nnoremap <leader>a <C-A>
nnoremap <leader>x <C-X>

" LSP setup
lua require'lspconfig'.pylsp.setup{}
lua require'lspconfig'.ocamllsp.setup{}

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp', 'ocamllsp', 'rls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 50,
    }
  }
end
nvim_lsp['elixirls'].setup {
  cmd={'elixir-ls'},
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    }
  }
}
require('rust-tools.inlay_hints').set_inlay_hints()
EOF
