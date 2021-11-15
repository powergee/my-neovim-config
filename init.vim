" Specify a directory for plugins
call plug#begin()
" Make sure you use single quotes
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'preservim/tagbar'
Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.7' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Initialize plugin system
call plug#end()

set number
set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
set autochdir
set encoding=utf-8
set fileencodings=utf-8,euckr

let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
if has('termguicolors') && &termguicolors
    let g:jellybeans_overrides['background']['guibg'] = 'none'
endif
colorscheme jellybeans

let NERDTreeShowHidden=1

function! BuildCurrentFile() abort
    let ext = expand("%:e")
    execute "w"

    if ext == "cpp"
        execute "!g++ -std=c++17 \"" . expand("%") . "\" -o \"" . expand("%:r") . ".exe\""
        if v:shell_error == 0
            call feedkeys("\<CR>")
            execute "vsplit"
            execute "terminal \"./" . expand("%:r") . ".exe\""
        endif
    elseif ext == "c"
        execute "!gcc -std=c++17 \"" . expand("%") . "\" -o \"" . expand("%:r") . ".exe\""
        if v:shell_error == 0
            call feedkeys("\<CR>")
            execute "vsplit"
            execute "terminal \"./" . expand("%:r") . ".exe\""
        endif
    elseif ext == "py"
        execute "vsplit"
        execute "terminal python3 %"
    else
        echom "File type \"". ext . "\" is not supported."
    endif
endfunc

map <C-n> :NERDTreeToggle<CR>
tnoremap <Esc> <C-\><C-n>
nnoremap <F5> :call BuildCurrentFile()<CR>
