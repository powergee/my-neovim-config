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
" Initialize plugin system
call plug#end()

set number
set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
set autochdir

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

map <C-n> :NERDTreeToggle<CR>
tnoremap <Esc> <C-\><C-n>

fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
endfunction

autocmd VimLeave * NERDTreeClose
autocmd VimLeave * call SaveSess()

autocmd VimEnter * nested call RestoreSess()
