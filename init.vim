set nocompatible

"---------
" Plugins
"---------
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'vim-utils/vim-cscope'
Plug 'vim-scripts/taglist.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Pychimp/vim-luna'
Plug 'tpope/vim-unimpaired'
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'elmcast/elm-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'mileszs/ack.vim'

" Source a local init.vim, to allow per-machine settings, if it exists.
" Note that we do this within the plugged section to allow the local init.vim
" to add plugins; plugged does not support multiple begin/end blocks.
if filereadable(glob('~/.config/nvim/local_init.vim'))
    source ~/.config/nvim/local_init.vim
endif
call plug#end()

"--------------- 
" Misc settings 
"---------------

" Tab/indent settings
set tw=79
set expandtab
set cindent shiftwidth=4
set tabstop=4
set cino=(0,:0

" Display column numbers etc.
set ruler

" Turn on line numbers, and use relative line numbers
set number
set relativenumber

" Turn on auto-write, mainly for write-on-make
set autowrite

" Set the colorscheme
colorscheme luna-term

" Highlight the area after 80 chars
let &colorcolumn=join(range(80,999),",")
highlight ColorColumn ctermbg=233

" Hide buffers when they are abandoned rather than throwing them away.
set hidden

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"--------------------"
" Functions/Commands "
"--------------------"

" Taglist toggle. Although taglist has a toggle command, it doesn't support
" jump the cursor to the buffer on open, which TlistOpen does, hence this
" function.
function! TaglistToggle()
    if bufwinnr('__Tag_List__') == -1
        TlistOpen
    else
        TlistClose
    endif
endfunction

"--------------
" Key mappings
"--------------
" Use , forleader
let mapleader = ","

" Toggle tag list visibility
map <silent> <F5> :call TaglistToggle()<CR>

" Toggle NERDTree visibility
map <silent> <F4> :NERDTreeToggle<CR>

" Ctrl+N toggles line numbers
nmap <silent> <C-N> :set invnumber<CR>:set invrelativenumber<CR>

nnoremap <leader>a :Ack

"-----------------
" Plugin settings
"-----------------

" CtrlP settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_jump_to_buffer = 0
let g:ctrlp_working_path_mode = 2
let g:ctrlp_clear_cache_on_exit = 0

if executable('ag')
    let g:ctrlp_user_cmd = 'ag %s -l --nocolor --hidden -g ""'
endif

" Ack settings
" Use ag if available.
if executable('ag')
    let g:ackprg = 'ag --vimgrep --smart-case'
else
    echom "ag executable not found"
endif
