" statusline functions {
let s:mode_map = {
      \ 'n':      ' NORMAL ',
      \ 'no':     ' NO     ',
      \ 'v':      ' V-CHAR ',
      \ 'V':      ' V-LINE ',
      \ "\<C-v>": ' V-BLCK ',
      \ 's':      ' S-CHAR ',
      \ 'S':      ' S-LINE ',
      \ "\<C-s>": ' S-B    ',
      \ 'i':      ' INSERT ',
      \ 'ic':     ' I-COMP ',
      \ 'ix':     ' I-COMP ',
      \ 'R':      ' R      ',
      \ 'Rc':     ' R-COMP ',
      \ 'Rv':     ' R-VIRT ',
      \ 'Rx':     ' R-COMP ',
      \ 'c':      ' C-LINE ',
      \ 'cv':     ' EX     ',
      \ 'ce':     ' EX     ',
      \ 'r':      ' ENTER  ',
      \ 'rm':     ' MORE   ',
      \ 'r?':     ' ?      ',
      \ '!':      ' SHELL  ',
\ }

function! VimModeStatusline()
    let l:mode = mode()
    return has_key(s:mode_map, l:mode) ? s:mode_map[l:mode] : ''
endfunction

function! LinterStatusline() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error
    let l:all_non_errors = l:counts.total - l:all_errors
    if l:counts.total > 0
        return printf('%s: %d %s: %d', g:ale_sign_error, all_errors, g:ale_sign_warning, all_non_errors)
    endif
    return printf('%s', g:ale_sign_ok)
endfunction

function! ReadOnlyStatusline()
    if &readonly == 1
        return '  '
    endif
    return ''
endfunction

function! PasteStatusline()
    if &paste == 1
        return '  '
    endif
    return ''
endfunction

function! GitBranchStatusline()
    let l:branch_name = fugitive#head()
    if l:branch_name != ""
        return printf(' %s', branch_name)
    endif
    return ''
endfunction
" }

" statusline
function! StatusLineFormat(mode) abort
    let l:line=''

    if a:mode ==# 'active'
        let l:line .= '%#TermCursor#'
        let l:line .= '  '
        let l:line .= ''
        let l:line .= ' %{GitBranchStatusline()} %'
        let l:line .= ' %{ReadOnlyStatusline()} '
        let l:line .= ' %{PasteStatusline()} '
        let l:line .= '%='
        " let l:line .= '%#TermCursor#'
        let l:line .= ' %l'
        let l:line .= ''
        let l:line .= '%v'
        let l:line .= ' '
        let l:line .= ''
        let l:line .= ' %{WebDevIconsGetFileFormatSymbol()} '
        let l:line .= '%{&fileencoding?&fileencoding:&encoding}'
        let l:line .= '  '
        let l:line .= LinterStatusline()
        let l:line .= ' '
        let l:line .= ''
        let l:line .= VimModeStatusline()
        let l:line .='%*'
        return l:line
    endif

    let l:line .= 'ﮋ 廓廓廓'

    " let l:line .= ''

    " let l:line .= ''
    " let l:line .= ''
    " let l:line .= ''
    let l:line .= '%='
    let l:line .='%#StatusLineNC#'
    let l:line .='%t'
    let l:line .= ' %{WebDevIconsGetFileTypeSymbol()}'
    let l:line .='%*'
    return l:line
endfunction
