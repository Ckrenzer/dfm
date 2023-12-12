" NEOVIM SETTINGS
colorscheme industry
" Set the color for matching parentheses, braces, etc.
hi MatchParen
            \ cterm=bold,underline
            \ ctermbg=NONE
            \ ctermfg=Yellow
            \ gui=bold,underline
            \ guibg=NONE
            \ guifg=Yellow
set splitright
syntax enable
set showmode
set showcmd
set wildmenu
set ruler
runtime ftplugin/man.vim
set nowrap
set hlsearch
set ignorecase
set smartcase
set number
set relativenumber
set list                          " Show spaces and tabs with hyphens (:set nolist to turn off)
" After the 'expandtab' option is set, any new tab characters
" entered will be converted to spaces
" (use Crtl+v+<Tab> to insert an actual tab character)
set expandtab
" Set the number of spaces to insert when pressing the tab key
set tabstop=4
" Set the number of columns the cursor moves when pressing the tab key
" or backspace <BS> key
set softtabstop=4
" Set the number of spaces inserted for indentation (< and > in visual mode)
set shiftwidth=4
" Type :retab to convert all tabs to spaces in a file
