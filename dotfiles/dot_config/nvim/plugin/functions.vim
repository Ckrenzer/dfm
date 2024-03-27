" Open a REPL of your choosing
function! REPLOpener(repl)
    " The 'start a REPL in a terminal window' code
    if a:repl == "sblc"
        exe "vsplit | term " .. a:repl .. " --load $HOME/.local/share/nvim/plugged/vlime/lisp/start-vlime.lisp"
        set filetype=lispout
    else
        exe "vsplit | term " .. a:repl
    endif
    set nonumber norelativenumber
    normal G
    let g:repl_jobid = b:terminal_job_id
    let g:repl_bufnr = bufnr('')
    exe 1 "wincmd w"
    exe 'let b:slime_config = {"jobid": "' . g:repl_jobid . '"}'
endfunction
command! -nargs=1 REPLStart call REPLOpener(<q-args>)
nnoremap <LocalLeader>jf :REPLStart 

" Send Keys to the most recently-opened REPL
function! REPLSend(keys)
    :call jobsend(g:repl_jobid, a:keys .. "\n")
    :let current_window = win_getid()
    :let terminal_window = nvim_call_function('bufwinid', [g:repl_bufnr])
    :call win_gotoid(terminal_window)
    :normal G
    :call win_gotoid(current_window)
endfunction
command! -nargs=1 REPLSendKeys call REPLSend(<q-args>)
nnoremap <Localleader>: :REPLSendKeys 

" Turn off Caps Lock
function TurnOffCaps()
    let capsState = matchstr(system('xset -q'), '00: Caps Lock:\s\+\zs\(on\|off\)\ze')
    if capsState == 'on'
        silent! execute ':!xdotool key Caps_Lock'
    endif
endfunction

" Count the number of appearances of a pattern on the current line
function! Count(pattern)
    redir => cnt
      silent execute '.s/' . a:pattern . '//gn'
    redir END
    return matchstr(cnt, '\d\+')
endfunction

" split a line based on a delimiter
function! BreakLine(delim)
    " default to a comma
    let delimiter = a:delim
    if a:delim ==# ''
        let delimiter = ','
    endif
    let pattern = " *" .. delimiter .. " *"
    let numlines = Count(pattern)
    let substitute_cmd = '.s/' . pattern . '/' . delimiter . '/g'
    if numlines > 0
        " break up and reindent the lines
        execute substitute_cmd
        execute "normal" numlines .. "=k"
    endif
endfunction
command! -nargs=* Breakline call BreakLine(<q-args>)

" use * or # in visual mode to search for current selection
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" you should create a wrapper around the find command in lieu of a fuzzy finder
