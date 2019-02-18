set number "Display line numbers
set backspace=2 "Enable backspace and delete on anything for insert mode
syntax on "Enable syntax highligthing
set cursorline
set t_Co=256 "Tell Vim to use all 254 colors since Termite is capable
colorscheme pablo
hi Comment ctermfg=13

let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>

"For Java
autocmd FileType java set expandtab|set shiftwidth=2|set softtabstop=2|set tabstop=2
autocmd FileType java set autoindent
