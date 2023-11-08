" A convenient wrapper because I am too incompetent to manage ftplugins
function s:loadFile(file_to_load)
    execute "source " . stdpath('config') . a:file_to_load
endfunction

" Turn off numbers when opening terminals
autocmd TermOpen * setlocal nonumber norelativenumber
