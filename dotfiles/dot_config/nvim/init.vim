let maplocalleader = ' '
let mapleader = '\'
set mouse=


" You install plugins from within NeoVim by typing
"   :PlugInstall
" and then restarting NeoVim.
call plug#begin()
    " LSP
    " LSP Support
    Plug 'neovim/nvim-lspconfig'                           " Required
    Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
    Plug 'williamboman/mason-lspconfig.nvim'               " Optional
    " Autocompletion
    Plug 'hrsh7th/nvim-cmp'     " Required
    Plug 'hrsh7th/cmp-nvim-lsp' " Required
    Plug 'L3MON4D3/LuaSnip'     " Required
    Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}


    Plug 'jpalardy/vim-slime'
    Plug 'Asheq/close-buffers.vim'

    " need newer version of nvim, need to configure
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'

    " sophisitcated undo tree
    Plug 'mbbill/undotree'

    " fuzzy finder
    " I think that a fuzzy finder goes against the UNIX philosophy.
    " Use the find command instead. nvim-telescope/telescope.nvim is a good one,
    " should I ever have a change of heart.

    " Julia
    Plug 'prabirshrestha/vim-lsp'
    Plug 'machakann/vim-lsp-julia'
    Plug 'JuliaEditorSupport/julia-vim'

    " Common Lisp
    Plug 'vlime/vlime', {'rtp': 'vim/'}

    " R
    Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
call plug#end()
