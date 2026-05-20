lua require('plugins')

"-----------------------------------------
" below come from neoclide/coc.nvim recommended/example config
" although we are not using coc, the settings below apply to nvim as well

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

"-----------------------------------------

set nu

set tabstop=2
set shiftwidth=2
set expandtab
set encoding=utf-8
"
" Enable folding
set foldmethod=indent
set foldlevel=99

set belloff=all

colorscheme lunaperche


"To color the first git line
au FileType gitcommit
 \ hi gitcommitSummary ctermfg=yellow ctermbg=red
au FileType tex nnoremap <F5> :! pdflatex %:p && rm %:t:r.aux && rm %:t:r.log<CR>


"Haskell autoformatter"
"function! Ormolu() range
"    "Based on:
"    "https://github.com/meck/vim-brittany/blob/master/ftplugin/haskell/brittany.vim
"    "
"    " Write the buffer to Ormolu, rather than having it use the
"    " file on disk, because that file might not have been created yet!
"    " If Ormolu doesn't run into any errors, run Ormolu again and re-write the buffer
"    silent! w !ormolu % > /dev/null 2>&1
"
"    if v:shell_error
"        "echohl  WarningMsg
"        "silent echo "Ormolu: Parsing error\n"
"        "echohl None
"    else
"        silent! exe "undojoin"
"        silent! exe "keepjumps " . a:firstline . "," . a:lastline . "!ormolu " . bufname("%")
"    endif
"        call winrestview(b:winview)
"
"endfunction
"
"function! OrmoluOnSave()
"    let b:winview = winsaveview()
"    exe "%call Ormolu()"
"endfunction
"
"augroup ormolu
"    "autocmd-remove
"    autocmd!
"    autocmd BufWritePost *.hs call OrmoluOnSave()
"augroup END
