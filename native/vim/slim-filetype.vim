" Vim support file to detect file types
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2017 Aug 11

" Listen very carefully, I will say this only once
if exists("did_load_filetypes")
  finish
endif
let did_load_filetypes = 1

" Line continuation is used here, remove 'C' from 'cpoptions'
let s:cpo_save = &cpo
set cpo&vim

augroup filetypedetect

" Ignored extensions
if exists("*fnameescape")
au BufNewFile,BufRead ?\+.orig,?\+.bak,?\+.old,?\+.new,?\+.dpkg-dist,?\+.dpkg-old,?\+.dpkg-new,?\+.dpkg-bak,?\+.pacsave,?\+.pacnew,?\+.pacsave,?\+.pacnew
	\ exe "doau filetypedetect BufRead " . fnameescape(expand("<afile>:r"))
au BufNewFile,BufRead *~
	\ let s:name = expand("<afile>") |
	\ let s:short = substitute(s:name, '\~$', '', '') |
	\ if s:name != s:short && s:short != "" |
	\   exe "doau filetypedetect BufRead " . fnameescape(s:short) |
	\ endif |
	\ unlet! s:name s:short
au BufNewFile,BufRead ?\+.in
	\ if expand("<afile>:t") != "configure.in" |
	\   exe "doau filetypedetect BufRead " . fnameescape(expand("<afile>:r")) |
	\ endif
elseif &verbose > 0
  echomsg "Warning: some filetypes will not be recognized because this version of Vim does not have fnameescape()"
endif

" Pattern used to match file names which should not be inspected.
" Currently finds compressed files.
if !exists("g:ft_ignore_pat")
  let g:ft_ignore_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\)$'
endif

" Function used for patterns that end in a star: don't set the filetype if the
" file name matches ft_ignore_pat.
func! s:StarSetf(ft)
  if expand("<amatch>") !~ g:ft_ignore_pat
    exe 'setf ' . a:ft
  endif
endfunc

" Vim help file
au BufNewFile,BufRead $VIMRUNTIME/doc/*.txt	setf help

" C or lpc
au BufNewFile,BufRead *.c			call s:FTlpc()

func! s:FTlpc()
  if exists("g:lpc_syntax_for_c")
    let lnum = 1
    while lnum <= 12
      if getline(lnum) =~# '^\(//\|inherit\|private\|protected\|nosave\|string\|object\|mapping\|mixed\)'
	setf lpc
	return
      endif
      let lnum = lnum + 1
    endwhile
  endif
  setf c
endfunc

" C++
au BufNewFile,BufRead *.cxx,*.c++,*.hh,*.hxx,*.hpp,*.ipp,*.moc,*.tcc,*.inl setf cpp
if has("fname_case")
  au BufNewFile,BufRead *.C,*.H setf cpp
endif

" .h files can be C, Ch C++, ObjC or ObjC++.
" Set c_syntax_for_h if you want C, ch_syntax_for_h if you want Ch. ObjC is
" detected automatically.
au BufNewFile,BufRead *.h			call s:FTheader()

" Cmake
au BufNewFile,BufRead CMakeLists.txt,*.cmake,*.cmake.in		setf cmake

" Configure scripts
au BufNewFile,BufRead configure.in,configure.ac setf config

" Git
au BufNewFile,BufRead COMMIT_EDITMSG,MERGE_MSG,TAG_EDITMSG setf gitcommit
au BufNewFile,BufRead *.git/config,.gitconfig,.gitmodules setf gitconfig
au BufNewFile,BufRead *.git/modules/*/config	setf gitconfig
au BufNewFile,BufRead */.config/git/config	setf gitconfig
if !empty($XDG_CONFIG_HOME)
  au BufNewFile,BufRead $XDG_CONFIG_HOME/git/config	setf gitconfig
endif
au BufNewFile,BufRead git-rebase-todo		setf gitrebase
au BufRead,BufNewFile .gitsendemail.msg.??????	setf gitsendemail
au BufNewFile,BufRead .msg.[0-9]*
      \ if getline(1) =~ '^From.*# This line is ignored.$' |
      \   setf gitsendemail |
      \ endif
au BufNewFile,BufRead *.git/*
      \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
      \   setf git |
      \ endif

" Group file
au BufNewFile,BufRead */etc/group,*/etc/group-,*/etc/group.edit,*/etc/gshadow,*/etc/gshadow-,*/etc/gshadow.edit,*/var/backups/group.bak,*/var/backups/gshadow.bak  setf group

" HTML (.shtml and .stm for server side)
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm  call s:FThtml()

" Distinguish between HTML, XHTML and Django
func! s:FThtml()
  let n = 1
  while n < 10 && n < line("$")
    if getline(n) =~ '\<DTD\s\+XHTML\s'
      setf xhtml
      return
    endif
    if getline(n) =~ '{%\s*\(extends\|block\|load\)\>\|{#\s\+'
      setf htmldjango
      return
    endif
    let n = n + 1
  endwhile
  setf html
endfunc

" Host config
au BufNewFile,BufRead */etc/host.conf		setf hostconf

" .INI file for MSDOS
au BufNewFile,BufRead *.ini			setf dosini

" Makefile
au BufNewFile,BufRead *[mM]akefile,*.mk,*.mak,*.dsp setf make

" Manpage
au BufNewFile,BufRead *.man			setf man

" Markdown
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md  setf markdown

" Python, Python Shell Startup Files
" Quixote (Python-based web framework)
au BufNewFile,BufRead *.py,*.pyw,.pythonstartup,.pythonrc,*.ptl  setf python

" sed
au BufNewFile,BufRead *.sed			setf sed

" Shell scripts (sh, ksh, bash, bash2, csh); Allow .profile_foo etc.
" Gentoo ebuilds and Arch Linux PKGBUILDs are actually bash scripts
au BufNewFile,BufRead .bashrc*,bashrc,bash.bashrc,.bash[_-]profile*,.bash[_-]logout*,.bash[_-]aliases*,*.bash,*/{,.}bash[_-]completion{,.d,.sh}{,/*},*.ebuild,PKGBUILD*,*.install,*.eclass,PKGBUILD* call SetFileTypeSH("bash")
au BufNewFile,BufRead .kshrc*,*.ksh call SetFileTypeSH("ksh")
au BufNewFile,BufRead */etc/profile,.profile*,*.sh,*.env call SetFileTypeSH(getline(1))

" Shell script (Arch Linux) or PHP file (Drupal)
au BufNewFile,BufRead *.install
	\ if getline(1) =~ '<?php' |
	\   setf php |
	\ else |
	\   call SetFileTypeSH("bash") |
	\ endif

" Also called from scripts.vim.
func! SetFileTypeSH(name)
  if expand("<amatch>") =~ g:ft_ignore_pat
    return
  endif
  if a:name =~ '\<csh\>'
    " Some .sh scripts contain #!/bin/csh.
    call SetFileTypeShell("csh")
    return
  elseif a:name =~ '\<tcsh\>'
    " Some .sh scripts contain #!/bin/tcsh.
    call SetFileTypeShell("tcsh")
    return
  elseif a:name =~ '\<zsh\>'
    " Some .sh scripts contain #!/bin/zsh.
    call SetFileTypeShell("zsh")
    return
  elseif a:name =~ '\<ksh\>'
    let b:is_kornshell = 1
    if exists("b:is_bash")
      unlet b:is_bash
    endif
    if exists("b:is_sh")
      unlet b:is_sh
    endif
  elseif exists("g:bash_is_sh") || a:name =~ '\<bash\>' || a:name =~ '\<bash2\>'
    let b:is_bash = 1
    if exists("b:is_kornshell")
      unlet b:is_kornshell
    endif
    if exists("b:is_sh")
      unlet b:is_sh
    endif
  elseif a:name =~ '\<sh\>'
    let b:is_sh = 1
    if exists("b:is_kornshell")
      unlet b:is_kornshell
    endif
    if exists("b:is_bash")
      unlet b:is_bash
    endif
  endif
  call SetFileTypeShell("sh")
endfunc

" OpenSSH configuration
au BufNewFile,BufRead ssh_config,*/.ssh/config	setf sshconfig

" OpenSSH server configuration
au BufNewFile,BufRead sshd_config		setf sshdconfig

" Sudoers
au BufNewFile,BufRead */etc/sudoers,sudoers.tmp	setf sudoers

" TeX
au BufNewFile,BufRead *.latex,*.sty,*.dtx,*.ltx,*.bbl	setf tex
au BufNewFile,BufRead *.tex			call s:FTtex()

" Choose context, plaintex, or tex (LaTeX) based on these rules:
" 1. Check the first line of the file for "%&<format>".
" 2. Check the first 1000 non-comment lines for LaTeX or ConTeXt keywords.
" 3. Default to "latex" or to g:tex_flavor, can be set in user's vimrc.
func! s:FTtex()
  let firstline = getline(1)
  if firstline =~ '^%&\s*\a\+'
    let format = tolower(matchstr(firstline, '\a\+'))
    let format = substitute(format, 'pdf', '', '')
    if format == 'tex'
      let format = 'latex'
    elseif format == 'plaintex'
      let format = 'plain'
    endif
  elseif expand('%') =~ 'tex/context/.*/.*.tex'
    let format = 'context'
  else
    " Default value, may be changed later:
    let format = exists("g:tex_flavor") ? g:tex_flavor : 'plain'
    " Save position, go to the top of the file, find first non-comment line.
    let save_cursor = getpos('.')
    call cursor(1,1)
    let firstNC = search('^\s*[^[:space:]%]', 'c', 1000)
    if firstNC " Check the next thousand lines for a LaTeX or ConTeXt keyword.
      let lpat = 'documentclass\>\|usepackage\>\|begin{\|newcommand\>\|renewcommand\>'
      let cpat = 'start\a\+\|setup\a\+\|usemodule\|enablemode\|enableregime\|setvariables\|useencoding\|usesymbols\|stelle\a\+\|verwende\a\+\|stel\a\+\|gebruik\a\+\|usa\a\+\|imposta\a\+\|regle\a\+\|utilisemodule\>'
      let kwline = search('^\s*\\\%(' . lpat . '\)\|^\s*\\\(' . cpat . '\)',
			      \ 'cnp', firstNC + 1000)
      if kwline == 1	" lpat matched
	let format = 'latex'
      elseif kwline == 2	" cpat matched
	let format = 'context'
      endif		" If neither matched, keep default set above.
      " let lline = search('^\s*\\\%(' . lpat . '\)', 'cn', firstNC + 1000)
      " let cline = search('^\s*\\\%(' . cpat . '\)', 'cn', firstNC + 1000)
      " if cline > 0
      "   let format = 'context'
      " endif
      " if lline > 0 && (cline == 0 || cline > lline)
      "   let format = 'tex'
      " endif
    endif " firstNC
    call setpos('.', save_cursor)
  endif " firstline =~ '^%&\s*\a\+'

  " Translation from formats to file types.  TODO:  add AMSTeX, RevTex, others?
  if format == 'plain'
    setf plaintex
  elseif format == 'context'
    setf context
  else " probably LaTeX
    setf tex
  endif
  return
endfunc

" Vim script
au BufNewFile,BufRead *.vim,*.vba,.exrc,_exrc	setf vim

" Viminfo file
au BufNewFile,BufRead .viminfo,_viminfo		setf viminfo

" Plain text files, needs to be far down to not override others.  This avoids
" the "conf" type being used if there is a line starting with '#'.
au BufNewFile,BufRead *.text,README		setf text

" Help files match *.txt but should have a last line that is a modeline.
au BufNewFile,BufRead *.txt	
	\  if getline('$') !~ 'vim:.*ft=help'
	\|   setf text
	\| endif


" Use the filetype detect plugins.  They may overrule any of the previously
" detected filetypes.
runtime! ftdetect/*.vim

" NOTE: The above command could have ended the filetypedetect autocmd group
" and started another one. Let's make sure it has ended to get to a consistent
" state.
augroup END

" Generic configuration file. Use FALLBACK, it's just guessing!
au filetypedetect BufNewFile,BufRead,StdinReadPost *
	\ if !did_filetype() && expand("<amatch>") !~ g:ft_ignore_pat
	\    && (getline(1) =~ '^#' || getline(2) =~ '^#' || getline(3) =~ '^#'
	\	|| getline(4) =~ '^#' || getline(5) =~ '^#') |
	\   setf FALLBACK conf |
	\ endif

" Restore 'cpoptions'
let &cpo = s:cpo_save
unlet s:cpo_save
