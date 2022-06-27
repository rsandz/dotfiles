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

" Important plugins
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'ggandor/lightspeed.nvim'
Plug 'vim-scripts/ReplaceWithRegister'

" Text Objects
Plug 'tpope/vim-surround'
Plug 'sgur/vim-textobj-parameter'
" Change from ' to a
let g:vim_textobj_parameter_mapping = 'a'

Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'

" Non VSCode plugins
if !has("g:vscode")
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        let g:airline_theme='bubblegum'
        let g:airline#extensions#tabline#enabled = 1

        Plug 'tpope/vim-fugitive'
        Plug 'scrooloose/nerdcommenter'
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
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


