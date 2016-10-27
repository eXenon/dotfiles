execute pathogen#infect()
set syntax=on

"set rtp+=/usr/local/lib/python3.4/dist-packages/powerline/bindings/vim/

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
nmap <c-j> :bprevious<CR>

" Disable arrows
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
noremap ù l
noremap m k
noremap l j
noremap k h

" Replace ESC in INSERT mode
inoremap jj <ESC>

" Display non-breaking space
set listchars=trail:◃,nbsp:•
set list

