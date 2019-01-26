if &compatible
	set nocompatible
endif

"""""""""""
" Plugins " reminder: Reload .vimrc and run :PlugInstall
""""""""""" 

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'Valloric/YouCompleteMe'

call plug#end()


" Plugin config
set laststatus=2                     " lightline


""""""""""""
" Autocmds "
""""""""""""

" Automatically jump to last known cursor position on file open
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif


"""""""""""""""""""""""""
" General Configuration "
"""""""""""""""""""""""""

" Set TAB size to 4
set tabstop=4
set shiftwidth=4

syntax enable      " Enable code syntax 
set hlsearch       " Highlight search results

