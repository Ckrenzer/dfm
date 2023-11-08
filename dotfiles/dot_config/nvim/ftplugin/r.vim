" Set R's working directory to Neovim's working directory
let R_nvim_wd = 1
" Set startup options for R
let R_args = ['--no-save', '--no-restore-data']
" Set the starting column for right-aligned comments inserted with <LocalLeader>;
let r_indent_comment_column = 20
" Stop the annoying jumping in the debugger
let R_debug = 0
let R_dbg_jump = 0
" Start the object browser with all multi-dimensional elements collapsed
let R_objbr_opendf = 0    " Show data.frames elements
let R_objbr_openlist = 0  " Show lists elements
let R_objbr_allnames = 0  " Show hidden objects
"
" HOTKEYS
vmap <buffer> <C-\> <Plug>RDSendSelection
nmap <buffer> <C-\> <Plug>RDSendLine
let R_assign_map = '<M-->'
" omni completion:
""""""" imap <leader><leader> <C-x><C-o> " not feeling this one anymore
nmap <buffer> <Localleader>: :RSend 
"
" CUSTOM FUNCTIONS
" See this page to map custom functions to nvimR hotkeys:
" https://github.com/jamespeapen/Nvim-R/wiki/custom-key-bindings
