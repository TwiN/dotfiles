" Automatically jump to last known cursor position on file open
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Set TAB size to 4
set tabstop=4
set shiftwidth=4

syntax enable      " Enable code syntax 
set hlsearch       " Highlight search results

