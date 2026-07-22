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
" Defer bracket-match highlighting until idle instead of on every cursor move
" - avoids stalls on large files
let g:matchup_matchparen_deferred = 1
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
        Plug 'preservim/nerdtree'
        nmap <C-n> :NERDTreeToggle<CR>

        Plug 'scrooloose/nerdcommenter'
        nmap <Leader>cc <Plug>NERDCommenterToggle
        nmap <Leader>c<Leader> <Plug>NERDCommenterToggle

        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'

        " FZF Key Bindings
        nmap <C-p> :Files<CR>
        nmap <Leader><C-P> :RG!<CR>
        nmap <Leader>b :Buffers<CR>

        Plug 'neoclide/coc.nvim', {'branch': 'release'}

        if has('nvim')
                " Real parser-based highlighting - replaces regex :syntax for
                " covered filetypes, no catastrophic backtracking on nested
                " generics like the connectionMutations.ts freeze.
                Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        endif

        Plug 'liuchengxu/vim-which-key'

        Plug 'airblade/vim-rooter'

        Plug 'liuchengxu/vista.vim'
        let g:vista_default_executive = 'coc'
        nmap <Leader>v :Vista!!<CR>

        Plug 'ludovicchabant/vim-gutentags'
        let g:gutentags_cache_dir = expand('~/.cache/tags')
        " /usr/bin/ctags (macOS BSD ctags) precedes /opt/homebrew/bin on
        " PATH and doesn't support gutentags' flags (-R, --tag-relative,
        " etc). Point at Universal Ctags explicitly instead of reordering
        " PATH globally.
        let g:gutentags_ctags_executable = '/opt/homebrew/bin/ctags'


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

if has('nvim')
lua <<EOF
-- nvim-treesitter's `main` branch dropped the old configs.setup() API;
-- install parsers and drive highlighting through Neovim's native
-- vim.treesitter.start(), per the plugin's current README.
require('nvim-treesitter').install({ 'typescript', 'tsx', 'javascript', 'json' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'typescriptreact', 'javascript', 'json' },
  callback = function()
    -- Clear regex :syntax first - it still catastrophically backtracks on
    -- nested generics even if treesitter is also highlighting the buffer.
    vim.cmd('syntax clear')
    vim.treesitter.start()
  end,
})
EOF
endif

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

" Perf: force the old regex engine - Vim's NFA engine catastrophically
" backtracks on vim-polyglot's TS/TSX syntax (generics, template literals),
" the classic cause of freezes on large TS files. Also give syntax matching
" more time before Vim gives up mid-redraw instead of hanging.
set regexpengine=1
set redrawtime=10000


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

" vim-which-key: show a popup of mappings under the current prefix
set timeoutlen=500
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

if exists("g:vscode") || exists("g:cursor")
        xmap gc  <Plug>VSCodeCommentary
        nmap gc  <Plug>VSCodeCommentary
        omap gc  <Plug>VSCodeCommentary
        nmap gcc <Plug>VSCodeCommentaryLine
else
        " Coc.nvim
        " ========
        function! CheckBackspace() abort
                let col = col('.') - 1
                return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Tab: if completion popup is open, select next entry; else if cursor is
        " mid-word insert a real tab; else trigger completion
        inoremap <silent><expr> <TAB>
                                \ coc#pum#visible() ? coc#pum#next(1) :
                                \ CheckBackspace() ? "\<Tab>" :
                                \ coc#refresh()
        " Shift-Tab: if popup open, select previous entry; else normal backspace
        inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
        " Enter: if popup open, confirm the selected completion; else normal newline
        inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>"

        nmap <silent> gd <Plug>(coc-definition)      " jump to where symbol under cursor is defined
        nmap <silent> gy <Plug>(coc-type-definition)  " jump to the definition of the symbol's type
        nmap <silent> gi <Plug>(coc-implementation)   " jump to concrete implementation(s) of an interface/abstract method
        nmap <silent> <leader>r <Plug>(coc-references)      " list all usages of symbol under cursor
        nnoremap <silent> K :call CocActionAsync('doHover')<CR>  " show docs/type info for symbol under cursor

        nmap <silent> rn <Plug>(coc-rename)  " rename symbol under cursor across the project

        nmap <leader>a  <Plug>(coc-codeaction-cursor)   " show quick-fix/refactor actions for the current line
        nmap <leader>ac <Plug>(coc-codeaction-source)   " show file-wide actions (e.g. organize imports)
        xmap <leader>a  <Plug>(coc-codeaction-selected) " show actions scoped to the visual selection

        nmap <silent> [g <Plug>(coc-diagnostic-prev)  " jump to previous error/warning
        nmap <silent> ]g <Plug>(coc-diagnostic-next)  " jump to next error/warning

        xmap <leader>f <Plug>(coc-format-selected)  " format the visual selection
        nmap <leader>f <Plug>(coc-format-selected)  " format under an operator (e.g. <leader>fip)
endif


