" Turn off numbers when opening terminals
autocmd TermOpen * setlocal nonumber norelativenumber
au InsertLeave * call TurnOffCaps()
