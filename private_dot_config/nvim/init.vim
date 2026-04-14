" Configuration variables
let USE_LEAP_IN_NVIM = 1

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

if !has('nvim')
        Plug 'tpope/vim-sensible'
endif
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'wellle/targets.vim'
Plug 'andymass/vim-matchup'
Plug 'vim-scripts/ReplaceWithRegister'

" Text Objects
Plug 'tpope/vim-surround'
Plug 'sgur/vim-textobj-parameter'
" Change from ' to a
let g:vim_textobj_parameter_mapping = 'a'

Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'

Plug 'sainnhe/gruvbox-material'

" Env Specific Plugins
if !exists("g:vscode") && !exists("g:cursor")
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

        " FZF Key Bindings
        nmap <C-p> :Files<CR>
        nmap <Leader><C-P> :RG!<CR>


        if has('nvim') && USE_LEAP_IN_NVIM
                Plug 'ggandor/leap.nvim'
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

" THEME SETUP
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"Enable theme
set background=dark
let g:gruvbox_material_background = 'hard'
autocmd vimenter * ++nested colorscheme gruvbox-material

" VIM configs
" ===========
filetype indent plugin on
set nu
set wrap

" Spacing
" =======
set expandtab " Turn tab to spaces
set tabstop=4 " Number of spaces a \t counts for
set softtabstop=-1 " Number of spaces added when pressing TAB. Use shiftwidth if -1.
set shiftwidth=4 " Number of spaces for indentation operations

" Search
" ======
set hlsearch
set incsearch
set ignorecase
set smartcase

" Mappings
" =======

let mapleader = " "

if exists("g:vscode") || exists("g:cursor")
        xmap gc  <Plug>VSCodeCommentary
        nmap gc  <Plug>VSCodeCommentary
        omap gc  <Plug>VSCodeCommentary
        nmap gcc <Plug>VSCodeCommentaryLine
endif


