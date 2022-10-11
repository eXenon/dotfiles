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

" Powerline
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" TreeSitter Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Unicode shenanigans
Plug 'chrisbra/unicode.vim'

" LSP
Plug 'neovim/nvim-lspconfig'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" Vsnip
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

" gundo
Plug 'simnalamburt/vim-mundo'
nnoremap <leader>u :MundoToggle<CR>

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <C-t> :GFiles<CR>
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
nnoremap <C-g> :GGrep<CR>

" Theming
Plug 'arcticicestudio/nord-vim'

" Fish stuff
Plug 'dag/vim-fish'
if &shell =~# 'fish$'
    set shell=sh
endif

" Elm stuff
Plug 'ElmCast/elm-vim' " Elm HL and elm-format on save

" Rust stuff
Plug 'simrat39/rust-tools.nvim'

" Elixir stuff
augroup elixirau
    au!

    " Mix format command
    function! MixFormat()
        silent write
        silent !mix format
    endfunction
augroup END

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
    autocmd FileType elixir nnoremap <buffer> <C-F> :call MixFormat()<CR>
    autocmd FileType heex nnoremap <buffer> <C-F> :call MixFormat()<CR>
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
"   New splits will be at the bottom or to the right side of the screen
set splitbelow
set splitright
"   Navigate between splits
nnoremap <leader>h <C-w><C-h>
nnoremap <leader>j <C-w><C-j>
nnoremap <leader>k <C-w><C-k>
nnoremap <leader>l <C-w><C-l>


" Toggle visibility
nnoremap <c-h> :set hlsearch!<CR>
nnoremap <c-k> :set list!<CR>

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

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
nnoremap <leader>f :Files<CR>

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

" TreeSitter config
lua << EUF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "elixir", "eex", "heex", "fish", "gleam", "css", "scss", "html", "javascript", "bash", "json", "elm", "rust", "ocaml", "python", "vim", "lua" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EUF

" LSP setup
lua require'lspconfig'.pylsp.setup{}
lua require'lspconfig'.ocamllsp.setup{}
lua require'lspconfig'.rust_analyzer.setup{}

lua << EOF
local nvim_lsp = require('lspconfig')

-- Init lualine
-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  deepblue = '#0000ff',
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.deepblue },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.deepblue },
    b = { fg = colors.white, bg = colors.deepblue },
    c = { fg = colors.black, bg = colors.deepblue },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'fileformat' },
    lualine_x = { 'encoding' },
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

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
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

end

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      -- setting up snippet engine
      -- this is for vsnip, if you're using other
      -- snippet engine, please refer to the `nvim-cmp` guide
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before~=nil and has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' }
  })
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp', 'ocamllsp' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 50,
    }
  }
end

EOF
