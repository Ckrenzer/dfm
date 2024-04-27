" Turn off numbers when opening terminals
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermClose * if exists("g:repl_bufnr") && bufexists(g:repl_bufnr) | execute "bdelete " . g:repl_bufnr | endif
autocmd ModeChanged * call TurnOffCaps()
