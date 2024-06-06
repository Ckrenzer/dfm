" Depending on the day, you may want this to say "neovim" or "tmux"
" It decides where to send selected text using the vim-slime plugin
let g:slime_target = "neovim"
" moving the cursor back to where you started is pretty tedious
let g:slime_preserve_curpos = 0
nmap <C-\> <Plug>SlimeLineSend
