" Configuration variables
let USE_LIGHT_SPEED_IN_NVIM = 1

" Auto install vim plug
if has('nvim')
        if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
                silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                                        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
else
        if empty(glob('~/.vim/autoload/plug.vim'))
                silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                                        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
endif

call plug#begin()

" Plugin Definition
" =================

Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/ReplaceWithRegister'

" Text Objects
Plug 'tpope/vim-surround'
Plug 'sgur/vim-textobj-parameter'
" Change from ' to a
let g:vim_textobj_parameter_mapping = 'a'

Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'

" Env Specific Plugins
if !has("g:vscode")
        " NVIM or VIM
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        let g:airline_theme='bubblegum'
        let g:airline#extensions#tabline#enabled = 1

        Plug 'tpope/vim-fugitive'
        Plug 'scrooloose/nerdcommenter'
        nmap <Leader>cc <Plug>NERDCommenterToggle
        nmap <Leader>c<Leader> <Plug>NERDCommenterToggle

        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'

        if has('nvim') && USE_LIGHT_SPEED_IN_NVIM
                Plug 'ggandor/lightspeed.nvim'
        else
                Plug 'easymotion/vim-easymotion'
                let g:EasyMotion_do_mapping = 0
                let g:EasyMotion_smartcase = 1

                " Jump anywhere with 2 chars
                nmap s <Plug>(easymotion-overwin-f2)
                vmap z <Plug>(easymotion-bd-f2)
        endif
endif


call plug#end()


" VIM configs
" ===========
filetype indent plugin on
set nu
set wrap

" Spacing
" =======
set expandtab

" Search
" ======
set hlsearch
set incsearch
set ignorecase
set smartcase

" Mappings
" =======

let mapleader = " "

if exists("g:vscode")
        xmap gc  <Plug>VSCodeCommentary
        nmap gc  <Plug>VSCodeCommentary
        omap gc  <Plug>VSCodeCommentary
        nmap gcc <Plug>VSCodeCommentaryLine
endif


