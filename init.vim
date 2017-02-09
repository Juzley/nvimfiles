set nocompatible

"---------
" Plugins
"---------
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'ctrlp.vim'
Plug 'Pychimp/vim-luna'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-unimpaired'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
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

" Turn on line numbers, and use relative line numbers
set number
set relativenumber

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

"--------------
" Key mappings
"--------------
" Ctrl+N toggles line numbers
nmap <silent> <C-N> :set invnumber<CR>:set invrelativenumber<CR>

"-----------------
" Plugin settings
"-----------------

" CtrlP settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_jump_to_buffer = 0
let g:ctrlp_working_path_mode = 2
let g:ctrlp_root_markers = ['comp-mdata.pl', '.ACME/', 'content.lst']
let g:ctrlp_clear_cache_on_exit = 0

