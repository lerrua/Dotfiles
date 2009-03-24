" File:          snipMate.vim
" Author:        Michael Sanders
" Version:       0.74
" Description:   snipMate.vim implements some of TextMate's snippets features in
"                Vim. A snippet is a piece of often-typed text that you can
"                insert into your document using a trigger word followed by a "<tab>".
"
"                For more help see snipMate.txt; you can do this by using:
"                :helptags ~/.vim/doc
"                :h snipMate.txt

if exists('loaded_snips') || &cp || version < 700
	finish
endif
let loaded_snips = 1
if !exists('snips_author') | let snips_author = 'Me' | endif

au FileType objc,cpp,cs let &ft = expand('<amatch>').'.c'
au FileType xhtml let &ft = expand('<amatch>').'.html'
au BufRead,BufNewFile *.snippets\= set ft=snippet
au FileType snippet setl noet fdm=indent

" These are just here to avoid errors, for now
com! -nargs=+ -bang Snipp
com! -nargs=+ -bang GlobalSnip
com! -nargs=+ -bang BufferSnip

let s:snippets = {} | let s:multi_snips = {}

fun! Filename(...)
	let filename = expand('%:t:r')
	if filename == '' | return a:0 == 2 ? a:2 : '' | endif
	return !a:0 || a:1 == '' ? filename : substitute(a:1, '$1', filename, 'g')
endf

fun! MakeSnip(scope, trigger, content, ...)
	let multisnip = a:0 && a:1 != ''
	let var = multisnip ? 's:multi_snips' : 's:snippets'
	if !has_key({var}, a:scope) | let {var}[a:scope] = {} | endif
	if !has_key({var}[a:scope], a:trigger)
		let {var}[a:scope][a:trigger] = multisnip ? [[a:1, a:content]] : a:content
	elseif multisnip | let {var}[a:scope][a:trigger] += [[a:1, a:content]]
	else
		echom 'Warning in snipMate.vim: Snippet '.a:trigger.' is already defined.'
				\ .' See :h multi_snip for help on snippets with multiple matches.'
	endif
endf

fun! ExtractSnips(dir, ft)
	for path in split(globpath(a:dir, '*'), "\n")
		if isdirectory(path)
			let pathname = fnamemodify(path, ':t')
			for snipFile in split(globpath(path, '*.snippet'), "\n")
				call s:ProcessFile(snipFile, a:ft, pathname)
			endfor
		elseif fnamemodify(path, ':e') == 'snippet'
			call s:ProcessFile(path, a:ft)
		endif
	endfor
endf

" Processes a single-snippet file; optionally add the name of the parent
" directory for a snippet with multiple matches.
fun s:ProcessFile(file, ft, ...)
	let keyword = fnamemodify(a:file, ':t:r')
	if keyword  == '' | return | endif
	try
		let text = join(readfile(a:file), "\n")
	catch /E484/
		echom "Error in snipMate.vim: couldn't read file: ".a:file
	endtry
	return a:0 ? MakeSnip(a:ft, a:1, text, keyword)
			\  : MakeSnip(a:ft, keyword, text)
endf

fun! ExtractSnipsFile(file)
	if !filereadable(a:file)
		return echom "Error in snipMate.vim: couldn't read file: ".a:file
	endif
	let text = readfile(a:file)
	let ft = fnamemodify(a:file, ':t:r')
	let inSnip = 0
	for line in text + ["\n"]
		if inSnip && (line == '' || strpart(line, 0, 1) == "\t")
			let content .= strpart(line, 1)."\n"
			continue
		elseif inSnip
			call MakeSnip(ft, trigger, content[:-2], name)
			let inSnip = 0
		endif

		if stridx(line, 'snippet') == 0
			let inSnip = 1
			let trigger = strpart(line, 8)
			let name = ''
			let space = stridx(trigger, ' ') + 1
			if space " Process multi snip
				let name = strpart(trigger, space)
				let trigger = strpart(trigger, 0, space - 1)
			endif
			let content = ''
		endif
	endfor
endf

fun! ResetSnippets()
	let s:snippets = {} | let s:multi_snips = {} | let g:did_ft = {}
endf

fun s:RemoveSnippet()
	unl s:snipPos s:curPos s:snipLen s:endSnip s:endSnipLine s:prevLen
endf

fun s:ChooseSnippet(scope, trigger)
	let snippet = []
	let i = 1
	for snip in s:multi_snips[a:scope][a:trigger]
		let snippet += [i.'. '.snip[0]]
		let i += 1
	endfor
	if i == 2 | return s:multi_snips[a:scope][a:trigger][0][1] | endif
	let num = inputlist(snippet) - 1
	return num < i-1 ? s:multi_snips[a:scope][a:trigger][num][1] : ''
endf

fun! TriggerSnippet()
	if pumvisible() " Update snippet if completion is used, or deal with supertab
		if exists('s:sid')
			return exists('b:complType') ? b:complType : "\<c-n>"
		endif
		call feedkeys("\<esc>a", 'n')
		return exists('s:snipPos') ? '' : "\<tab>"
	endif
	if !exists('s:sid') && exists('g:SuperTabMappingForward')
				\ && g:SuperTabMappingForward == "<tab>"
		call s:GetSuperTabSID()
	endif

	if exists('s:snipPos') && s:endSnip == s:snipPos[s:curPos][1]+s:snipPos[s:curPos][2]
		return s:JumpTabStop() " Don't treat placeholder text as a trigger.
	endif

	let word = matchstr(getline('.'), '\S\+\%'.col('.').'c')
	for scope in [bufnr('%')] + split(&ft, '\.') + ['_']
		let trigger = s:GetSnippet(word, scope)
		if exists('s:snippet') | break | endif
	endfor

	" If word is a trigger for a snippet, delete the trigger & expand the snippet.
	if exists('s:snippet')
		if s:snippet == '' " If user cancelled a multi snippet, quit.
			return unl s:snippet
		endif
		let col = col('.') - len(trigger)
		sil exe 's/'.escape(trigger, '.^$/\*[]').'\%#//'
		return s:ExpandSnippet(col)
	endif
	if exists('s:snipPos') | return s:JumpTabStop() | endif
	return exists('s:sid') ? {s:sid}_SuperTab('n') : "\<tab>"
endf

fun s:GetSuperTabSID()
	let old = @a
	redir @a | sil exe 'fun /SuperTab$' | redir END
	let s:sid = matchstr(@a, '<SNR>\d\+\ze_SuperTab(command)')
	let @a = old
endf

" Check if word under cursor is snippet trigger; if it isn't, try checking if
" the text after non-word characters is (e.g. check for "foo" in "bar.foo")
fun s:GetSnippet(word, scope)
	let word = a:word
	wh !exists('s:snippet')
		if exists('s:snippets["'.a:scope.'"]['''.word.''']')
			let s:snippet = s:snippets[a:scope][word]
		elseif exists('s:multi_snips["'.a:scope.'"]['''.word.''']')
			let s:snippet = s:ChooseSnippet(a:scope, word)
		else
			if match(word, '\W') == -1 | break | endif
			let word = substitute(word, '.\{-}\W', '', '')
		endif
	endw
	return word
endf

fun s:ExpandSnippet(col)
	let lnum = line('.') | let col = a:col

	call s:ProcessSnippet()
	if s:snippet == ''
		return unl s:snippet " Avoid an error if the snippet is now empty
	endif

	let snip = split(substitute(s:snippet, '$\d\|${\d.\{-}}', '', 'g'), "\n", 1)

	let line = getline(lnum)
	let afterCursor = strpart(line, col - 1)
	if afterCursor != "\t" && afterCursor != ' '
		let line = strpart(line, 0, col - 1)
		let snip[-1] .= afterCursor
	else
		let afterCursor = ''
		" For some reason the cursor needs to move one right after this
		if line != '' && col == 1 && &ve !~ 'all\|onemore'
			let col += 1
		endif
	endif

	call setline(lnum, line.snip[0])

	" Autoindent snippet according to previous indentation
	let indent = matchend(line, '^.\{-}\ze\(\S\|$\)') + 1
	call append(lnum, map(snip[1:], "'".strpart(line, 0, indent - 1)."'.v:val"))

	if exists('s:snipPos') && stridx(s:snippet, '${1') != -1
		if exists('s:update')
			call s:UpdateSnip(len(snip[-1]) - len(afterCursor))
			call s:UpdatePlaceholderTabStops()
		else
			call s:UpdateTabStops(len(snip) - 1, len(snip[-1]) - len(afterCursor))
		endif
	endif

	let snipLen = s:BuildTabStops(lnum, col - indent, indent)
	unl s:snippet

	if snipLen
		if exists('s:snipLen')
			let s:snipLen += snipLen | let s:curPos += 1
		else
			let s:snipLen = snipLen | let s:curPos = 0
		endif
		let s:endSnip     = s:snipPos[s:curPos][1]
		let s:endSnipLine = s:snipPos[s:curPos][0]

		call cursor(s:snipPos[s:curPos][0], s:snipPos[s:curPos][1])
		let s:prevLen = [line('$'), col('$')]
		if s:snipPos[s:curPos][2] != -1 | return s:SelectWord() | endif
	else
		if !exists('s:snipLen') | unl s:snipPos | endif
		" Place cursor at end of snippet if no tab stop is given
		let newlines = len(snip) - 1
		call cursor(lnum + newlines, indent + len(snip[-1]) - len(afterCursor)
					\ + (newlines ? 0: col - 1))
	endif
	return ''
endf

fun s:ProcessSnippet()
	" Evaluate eval (`...`) expressions.
	" Using a loop here instead of a regex fixes a bug with nested "\=".
	if stridx(s:snippet, '`') != -1
		wh match(s:snippet, '`.\{-}`') != -1
			let s:snippet = substitute(s:snippet, '`.\{-}`',
						\ substitute(eval(matchstr(s:snippet, '`\zs.\{-}\ze`')),
						\ "\n\\%$", '', ''), '')
		endw
		let s:snippet = substitute(s:snippet, "\r", "\n", 'g')
	endif

	" Place all text after a colon in a tab stop after the tab stop
	" (e.g. "${#:foo}" becomes "${:foo}foo").
	" This helps tell the position of the tab stops later.
	let s:snippet = substitute(s:snippet, '${\d:\(.\{-}\)}', '&\1', 'g')

	" Update the s:snippet so that all the $# become
	" the text after the colon in their associated ${#}.
	" (e.g. "${1:foo}" turns all "$1"'s into "foo")
	let i = 1
	wh stridx(s:snippet, '${'.i) != -1
		let s = matchstr(s:snippet, '${'.i.':\zs.\{-}\ze}')
		if s != ''
			let s:snippet = substitute(s:snippet, '$'.i, '&'.s, 'g')
		endif
		let i += 1
	endw

	if &et " Expand tabs to spaces if 'expandtab' is set.
		let s:snippet = substitute(s:snippet, '\t',
						\ repeat(' ', &sts ? &sts : &sw), 'g')
	endif
endf

fun s:Count(haystack, needle)
	let counter = 0
	let index = stridx(a:haystack, a:needle)
	wh index != -1
		let index = stridx(a:haystack, a:needle, index+1)
		let counter += 1
	endw
	return counter
endf

" This function builds a list of a list of each tab stop in the
" snippet containing:
" 1.) The tab stop's line number.
" 2.) The tab stop's column number
"     (by getting the length of the string between the last "\n" and the
"     tab stop).
" 3.) The length of the text after the colon for the current tab stop
"     (e.g. "${1:foo}" would return 3). If there is no text, -1 is returned.
" 4.) If the "${#:}" construct is given, another list containing all
"     the matches of "$#", to be replaced with the placeholder. This list is
"     composed the same way as the parent; the first item is the line number,
"     and the second is the column.
fun s:BuildTabStops(lnum, col, indent)
	let snipPos = []
	let i = 1
	let withoutVars = substitute(s:snippet, '$\d', '', 'g')
	wh stridx(s:snippet, '${'.i) != -1
		let beforeTabStop = matchstr(withoutVars, '^.*\ze${'.i)
		let withoutOthers = substitute(withoutVars, '${'.i.'\@!\d.\{-}}', '', 'g')
		let snipPos += [[a:lnum + s:Count(beforeTabStop, "\n"),
						\ a:indent + len(matchstr(withoutOthers,
						\ "^.*\\(\n\\|^\\)\\zs.*\\ze${".i)), -1]]
		if snipPos[i-1][0] == a:lnum
			let snipPos[i-1][1] += a:col
		endif

		" Get all $# matches in another list, if ${#:name} is given
		if stridx(withoutVars, '${'.i.':') != -1
			let j = i-1
			let snipPos[j][2] = len(matchstr(withoutVars, '${'.i.':\zs.\{-}\ze}'))
			let snipPos[j] += [[]]
			let withoutOthers = substitute(s:snippet, '${\d.\{-}}\|$'.i.'\@!\d', '', 'g')
			wh stridx(withoutOthers, '$'.i) != -1
				let beforeMark = matchstr(withoutOthers, '^.\{-}\ze$'.i)
				let linecount = a:lnum + s:Count(beforeMark, "\n")
				let snipPos[j][3] += [[linecount,
							\ a:indent + (linecount > a:lnum
							\ ? len(matchstr(beforeMark, "^.*\n\\zs.*"))
							\ : a:col + len(beforeMark))]]
				let withoutOthers = substitute(withoutOthers, '$'.i, '', '')
			endw
		endif
		let i += 1
	endw

	if exists('s:snipPos') " Build a nested snippet
		let s:snipPos = extend(s:snipPos, snipPos, s:curPos + 1)
	else
		let s:snipPos = snipPos
	endif
	return i - 1
endf

fun s:JumpTabStop()
	if exists('s:update')
		call s:UpdatePlaceholderTabStops()
	else
		call s:UpdateTabStops()
	endif

	let s:curPos += 1
	if s:curPos == s:snipLen
		let sMode = s:endSnip == s:snipPos[s:curPos-1][1]+s:snipPos[s:curPos-1][2]
		call s:RemoveSnippet()
		return sMode ? "\<tab>" : TriggerSnippet()
	endif

	call cursor(s:snipPos[s:curPos][0], s:snipPos[s:curPos][1])

	let s:endSnipLine = s:snipPos[s:curPos][0]
	let s:endSnip     = s:snipPos[s:curPos][1]
	let s:prevLen     = [line('$'), col('$')]

	return s:snipPos[s:curPos][2] == -1 ? '' : s:SelectWord()
endf

fun s:UpdatePlaceholderTabStops()
	" Update tab stops in snippet if text has been added via "$#",
	" e.g. in "${1:foo}bar$1${2}"
	if exists('s:origPos')
		let changeLen = s:origWordLen - s:snipPos[s:curPos][2]

		" This could probably be more efficent...
		if changeLen != 0
			let lnum = line('.')
			let len = len(s:origPos)
			for pos in s:snipPos[(s:curPos + 1):]
				let i = 0 | let j = 0 | let k = 0
				let endSnip = pos[2] + pos[1] - 1
				wh i < len && s:origPos[i][0] <= pos[0]
					if pos[0] == s:origPos[i][0]
						if pos[1] > s:origPos[i][1]
								\ || (pos[2] == -1 && pos[1] == s:origPos[i][1])
							let j += 1
						elseif s:origPos[i][1] < endSnip " Parse variables within placeholders
							let k += 1
						endif
					endif
					let i += 1
				endw
				if pos[0] == lnum && pos[1] > s:origSnipPos
					let j += 1
				endif
				let pos[1] -= changeLen*j
				let pos[2] -= changeLen*k

				if pos[2] != -1
					for nPos in pos[3]
						let i = 0 | let j = 0
						wh i < len && s:origPos[i][0] <= nPos[0]
							if nPos[0] == s:origPos[i][0] && nPos[1] > s:origPos[i][1]
								let j += 1
							endif
							let i += 1
						endw
						if nPos[0] == lnum && nPos[1] > s:origSnipPos
							let j += 1
						endif
						if nPos[0] > s:origPos[0][0] | break | endif
						let nPos[1] -= changeLen*j
					endfor
				endif
			endfor
		endif
		unl s:endSnip s:origPos s:origSnipPos
	endif
	unl s:startSnip s:origWordLen s:update
endf

fun s:UpdateTabStops(...)
	let changeLine = a:0 ? a:1 : s:endSnipLine - s:snipPos[s:curPos][0]
	let changeCol  = a:0 > 1 ? a:2 : s:endSnip - s:snipPos[s:curPos][1]
	if exists('s:origWordLen')
		let changeCol -= s:origWordLen | unl s:origWordLen
	endif
	" There's probably a more efficient way to do this as well...
	let lnum = s:snipPos[s:curPos][0]
	let col  = s:snipPos[s:curPos][1]
	" Update the line number of all proceeding tab stops if <cr> has
	" been inserted.
	if changeLine != 0
		for pos in s:snipPos[(s:curPos + 1):]
			if pos[0] >= lnum
				if pos[0] == lnum
					let pos[1] += changeCol
				endif
				let pos[0] += changeLine
			endif
			if pos[2] != -1
				for nPos in pos[3]
					if nPos[0] >= lnum
						if nPos[0] == lnum
							let nPos[1] += changeCol
						endif
						let nPos[0] += changeLine
					endif
				endfor
			endif
		endfor
	elseif changeCol != 0
		" Update the column of all proceeding tab stops if text has
		" been inserted/deleted in the current line.
		for pos in s:snipPos[(s:curPos + 1):]
			if pos[1] >= col && pos[0] == lnum
				let pos[1] += changeCol
			endif
			if pos[2] != -1
				for nPos in pos[3]
					if nPos[0] > lnum | break | endif
					if nPos[0] == lnum && nPos[1] >= col
						let nPos[1] += changeCol
					endif
				endfor
			endif
		endfor
	endif
endf

fun s:SelectWord()
	let s:origWordLen = s:snipPos[s:curPos][2]
	let s:oldWord     = strpart(getline('.'), s:snipPos[s:curPos][1] - 1,
								\ s:origWordLen)
	let s:prevLen[1] -= s:origWordLen
	if !empty(s:snipPos[s:curPos][3])
		let s:update    = 1
		let s:endSnip   = -1
		let s:startSnip = s:snipPos[s:curPos][1] - 1
	endif
	if !s:origWordLen | return '' | endif
	let l = col('.') != 1 ? 'l' : ''
	if &sel == 'exclusive'
		return "\<esc>".l.'v'.s:origWordLen."l\<c-g>"
	endif
	return s:origWordLen == 1 ? "\<esc>".l.'gh'
							\ : "\<esc>".l.'v'.(s:origWordLen - 1)."l\<c-g>"
endf

" This updates the snippet as you type when text needs to be inserted
" into multiple places (e.g. in "${1:default text}foo$1bar$1",
" "default text" would be highlighted, and if the user types something,
" UpdateChangedSnip() would be called so that the text after "foo" & "bar"
" are updated accordingly)
"
" It also automatically quits the snippet if the cursor is moved out of it
" while in insert mode.
au CursorMovedI * call s:UpdateChangedSnip(0)
au InsertEnter * call s:UpdateChangedSnip(1)
fun s:UpdateChangedSnip(entering)
	if exists('s:update')
		if !exists('s:origPos') && s:curPos + 1 < s:snipLen
			" Save the old snippet & word length before it's updated
			" s:startSnip must be saved too, in case text is added
			" before the snippet (e.g. in "foo$1${2}bar${1:foo}").
			let s:origSnipPos = s:startSnip
			let s:origPos     = deepcopy(s:snipPos[s:curPos][3])
		endif
		let col = col('.') - 1

		if s:endSnip != -1
			let changeLen = col('$') - s:prevLen[1]
			let s:endSnip += changeLen
		else " When being updated the first time, after leaving select mode
			if a:entering | return | endif
			let s:endSnip = col - 1
		endif

		" If the cursor moves outside the snippet, quit it
		if line('.') != s:snipPos[s:curPos][0] || col < s:startSnip ||
					\ col - 1 > s:endSnip
			unl! s:startSnip s:origWordLen s:origPos s:update
			return s:RemoveSnippet()
		endif

		call s:UpdateSnip()
		let s:prevLen[1] = col('$')
	elseif exists('s:snipPos')
		let col        = col('.')
		let lnum       = line('.')
		let changeLine = line('$') - s:prevLen[0]

		if lnum == s:endSnipLine
			let s:endSnip += col('$') - s:prevLen[1]
			let s:prevLen = [line('$'), col('$')]
		endif
		if changeLine != 0
			let s:endSnipLine += changeLine
			let s:endSnip = col
		endif

		" Delete snippet if cursor moves out of it in insert mode
		if (lnum == s:endSnipLine && (col > s:endSnip || col < s:snipPos[s:curPos][1]))
			\ || lnum > s:endSnipLine || lnum < s:snipPos[s:curPos][0]
			call s:RemoveSnippet()
		endif
	endif
endf

fun s:UpdateSnip(...)
	" Using strpart() here avoids a bug if s:endSnip was negative that would
	" happen with the getline('.')[(s:startSnip):(s:endSnip)] syntax
	let newWordLen = a:0 ? a:1 : s:endSnip - s:startSnip + 1
	let newWord    = strpart(getline('.'), s:startSnip, newWordLen)
	if newWord != s:oldWord
		let changeLen    = s:snipPos[s:curPos][2] - newWordLen
		let curLine      = line('.')
		let startCol     = col('.')
		let oldStartSnip = s:startSnip
		let updateSnip   = changeLen != 0
		let i            = 0

		for pos in s:snipPos[s:curPos][3]
			if updateSnip
				let start = s:startSnip
				if pos[0] == curLine && pos[1] <= start
					let s:startSnip -= changeLen
					let s:endSnip -= changeLen
				endif
				for nPos in s:snipPos[s:curPos][3][(i):]
					if nPos[0] == pos[0]
						if nPos[1] > pos[1] || (nPos == [curLine, pos[1]] &&
												\ nPos[1] > start)
							let nPos[1] -= changeLen
						endif
					elseif nPos[0] > pos[0] | break | endif
				endfor
				let i += 1
			endif

			call setline(pos[0], substitute(getline(pos[0]), '\%'.pos[1].'c\V'.
						\ escape(s:oldWord, '\'), escape(newWord, '\'), ''))
		endfor
		if oldStartSnip != s:startSnip
			call cursor('.', startCol + s:startSnip - oldStartSnip)
		endif

		let s:oldWord = newWord
		let s:snipPos[s:curPos][2] = newWordLen
	endif
endf
" vim:noet:sw=4:ts=4:ft=vim
