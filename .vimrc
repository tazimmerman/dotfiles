" General {{{
set autoread
set backspace=start,indent,eol
set browsedir=buffer
if !has('nvim')
    set cryptmethod=blowfish2
endif
set encoding=utf-8
set fillchars= 
set formatoptions=tcroqnlj
set hidden
set list
set listchars=tab:\|\ ,extends:>,precedes:<
set makeprg=make
set noswapfile
set nowrap
set scrolloff=5
set showmatch
set switchbuf=usetab
set updatetime=500
set virtualedit=block
" }}}

" Paths {{{
set exrc
set path+=include
set tags=./tags
" }}}

" Grep {{{
if has('unix')
    if executable('ag')
        set grepprg=ag\ --nogroup\ --nocolor\ --column\ --vimgrep
    elseif executable('ack')
        set grepprg=ack\ -s\ --with-filename\ --nocolor\ --nogroup\ --column
    elseif executable('rg')
        set grepprg=rg\ --vimgrep
    endif
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" {{{ Quickfix
set errorformat^=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" }}}

" {{{ Diff
set diffopt-=internal
" }}}

" Search {{{
set ignorecase
set smartcase
set infercase
set hlsearch
set incsearch
set nowrapscan
" }}}

" Completion {{{
set wildignorecase
set wildmenu
set wildmode=longest:full,full
set wildoptions=tagfile
if has('nvim')
    set wildoptions+=pum
endif
set complete=.,w,b
set completeopt=menu
set pumheight=15
" }}}

" Wild Ignore {{{
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/tmp/*,*/research-data/*,*/test-data/*
set wildignore+=*.pyc,*.pyo,*.pyd,*/__pycache__/*
set wildignore+=*.so,*.o,*.dll,*.lib,*.obj,*.exe
set wildignore+=*.ttf,*.pdf,*.xls,*.xlsx,*.doc,*.docx
set wildignore+=*.h5,*.pcl,*.dat
set wildignore+=*.tar,*.gz,*.bz2
set wildignore+=*.png,*.gif,*.jpg,*.bmp,*.ico
set wildignore+=cscope.out,tags
" }}}

" Clipboard {{{
if has('clipboard')
    if has('unnamedplus')
        set clipboard=unnamedplus
    else
        set clipboard=unnamed
    endif
endif
" }}}

" Win32/64 {{{
if has('win32') || has('win64')
    set fileformats=unix,dos
    set shellslash
endif
" }}}

" UI {{{
set breakindent
set colorcolumn=+1
set cursorline
set display=lastline
set laststatus=2
set linebreak
set ruler
set mousehide
set showbreak=\ \ >\  
set splitbelow
set splitright
set winminheight=0
set winminwidth=0

if has('gui')
    set guioptions=aci
endif

if has('gui_macvim')
    set antialias
    set guifont=Sauce\ Code\ Powerline:h16
    set transparency=10
elseif has('gui_running')
    set guifont=mononoki\ 11
else
    if &term =~ 'st'
        set t_8f=[38;2;%lu;%lu;%lum
        set t_8b=[48;2;%lu;%lu;%lum
        set termguicolors
    endif

    set lazyredraw

    if !has('nvim')
        set ttyfast
    endif

    if &term =~ '256color'
        set t_ut=
    endif
endif
" }}}

" Auto Commands {{{
augroup CursorLine
    autocmd!
    autocmd WinEnter * set cursorline colorcolumn=+1
    autocmd WinLeave * set nocursorline colorcolumn=
    autocmd InsertEnter * set nocursorline
    autocmd InsertLeave * set cursorline
augroup end

augroup QuickFix
    autocmd!
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
augroup end
" }}}

" Syntax, Filetype {{{
syntax on
filetype on
filetype indent on
filetype plugin on
syntax sync fromstart
" }}}

" Plug-ins {{{
packadd! badwolf
packadd! gruvbox
packadd! papercolor-theme
packadd! tender.vim
packadd! vim-airline
packadd! vim-airline-themes

packadd! ale
packadd! fzf.vim
packadd! targets.vim
packadd! vim-abolish
packadd! vim-commentary
packadd! vim-gitgutter
packadd! vim-grepper
packadd! vim-repeat
packadd! vim-surround
packadd! vim-wordmotion

packadd! python-syntax
packadd! vim-python-pep8-indent
packadd! vim-javascript
" }}}

" PaperColor {{{
let g:PaperColor_Theme_Options={
    \   'language': {
    \     'python': {
    \       'highlight_builtins': 1
    \     }
    \   }
    \ }
" }}}

" Badwolf {{{
let g:badwolf_darkgutter=1
let g:badwolf_tabline=2
" }}}

" Gruvbox {{{
let g:gruvbox_italics=1
let g:gruvbox_italicize_strings=1
let g:gruvbox_number_column='bg1'
" }}}

" Colors {{{
if has('gui_running')
    set background=dark
    colorscheme badwolf
else
    set background=dark
    colorscheme gruvbox
endif
" }}}

" Airline {{{
let g:airline_powerline_fonts=1
let g:airline_theme=has('gui_running') ? 'badwolf' : 'gruvbox'
let g:airline#extensions#wordcount#enabled=0
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#default#layout=[
    \ ['a', 'c'],
    \ ['x', 'z'],
    \ ]
" }}}

" Word Motion {{{
let g:wordmotion_prefix='<leader>'
" }}}

" ALE {{{
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_insert_leave=1
let g:ale_set_highlights=0
let g:ale_set_signs=0
let g:ale_set_balloons=0
let g:ale_linters={
    \ 'python': ['flake8']
    \ }
let g:ale_python_flake8_options='--ignore=E501,W291,E722' " line too long, trailing whitespace, bare except
" }}}

" Grepper {{{
let g:grepper = {}
let g:grepper.tools=['rg']
let g:grepper.prompt=0
" }}}

" Git Gutter {{{
let g:gitgutter_terminal_reports_focus=0
" }}}

" FZF {{{
let g:fzf_buffers_jump=1
let g:fzf_tags_command='ctags -R --exclude=*/__pycache__/* --python-kinds=-i --sorted=yes'
" }}}

" Commands {{{
" Jump to the next diff and obtain it (repeat with @@, followed by @:)
command! -nargs=0 Fix :normal! ]cdo<CR>

" Find TODO, XXX, etc.
command! -nargs=0 Todo :lvimgrep /\#\s*\(XXX\|TODO\|NOTE\)/ %<CR>

" Find conflict markers
command! -nargs=0 Conflicts :lvimgrep />>>>>>>\|=======\|<<<<<<</ %<CR>

" Avoid the 'Hit ENTER to continue' prompts
command! -nargs=* -complete=file_in_path Grep silent! grep! <args> | redraw!
command! -nargs=* -complete=file_in_path LGrep silent! lgrep! <args> | redraw!
command! -nargs=0 Make silent! make! | redraw!
command! -nargs=0 LMake silent! lmake! | redraw!
" }}}

" Mappings {{{
" Popup navigation
inoremap <silent> <C-K> <C-R>=pumvisible() ? "\<lt>C-P>" : "\<lt>C-K>"<CR>
inoremap <silent> <C-J> <C-R>=pumvisible() ? "\<lt>C-N>" : "\<lt>C-J>"<CR>

" Alias space to leader
map <Space> <leader>

" Highlight word under cursor without jumping
nnoremap <silent> <leader>* :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hlsearch<CR>

" Change next/previous occurrence
nnoremap <silent> c; *``cgn
nnoremap <silent> c, #``cgn

" Reset search pattern
nnoremap <silent> <ESC> :let @/=""<CR>

" ALE shortcuts
nmap <silent> ]l <Plug>(ale_next)
nmap <silent> [l <Plug>(ale_previous)
nmap <silent> <leader>l <Plug>(ale_lint)

" Grepper shortcuts
nmap <silent> gs <Plug>(GrepperOperator)
vmap <silent> gs <Plug>(GrepperOperator)

" FZF shortcuts
nmap <silent> <leader>fe :Files<CR>
nmap <silent> <leader>fg :GFiles<CR>

nmap <silent> <leader>fb :Buffers<CR>
nmap <silent> <leader>ft :Tags<CR>

" Wrap a word in quotes
nnoremap <silent> <leader>q' ciw'<C-R><C-O>"'<Esc>
nnoremap <silent> <leader>q" ciw"<C-R><C-O>""<Esc>
nnoremap <silent> <leader>q" ciw"<C-R><C-O>""<Esc>
nnoremap <silent> <leader>q( ciw(<C-R><C-O>")<Esc>
nnoremap <silent> <leader>q[ ciw[<C-R><C-O>"]<Esc>
nnoremap <silent> <leader>q{ ciw{<C-R><C-O>"}<Esc>
nnoremap <silent> <leader>q< ciw<<C-R><C-O>"><Esc>

" Inverse of g]
nnoremap <silent> g[ :pop<CR>

" Preview tag
nnoremap <silent> g\ :ptjump <C-R>=expand("<cword>")<CR><CR>

" Move lines with indent
nnoremap <silent> <Up> :move-2<CR>==
nnoremap <silent> <Down> :move+<CR>==
inoremap <silent> <Up> <Esc>:move-2<CR>==gi
inoremap <silent> <Down> <Esc>:move+<CR>==gi
vnoremap <silent> <Up> :move'<-2<CR>gv=gv
vnoremap <silent> <Down> :move'>+<CR>gv=gv

" Indent and return to Visual mode
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" Repeat over lines in Visual mode
vnoremap <silent> . :normal .<CR>

" Highlight text from last Insert mode
nnoremap <silent> gV `[v`]

" Add relative line motions to jump list
nnoremap <silent> <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <silent> <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" }}}

" get_visual_selection() {{{
function! s:get_visual_selection()
    let [begln, begcol] = getpos("'<")[1:2]
    let [endln, endcol] = getpos("'>")[1:2]
    let lines = getline(begln, endln)
    let lines[-1] = lines[-1][:endcol - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][begcol - 1:]
    return join(lines, "\n")
endfunction
" }}}

" tab_complete() {{{
function! s:tab_complete(mode)
    let cmd=(a:mode == "P" ? "\<C-P>" : "\<C-N>")
    let bol=(strpart(getline('.'), 0, col('.')-1) =~ '^\s*$' ? 1 : 0)
    if bol == 0 || pumvisible()
        return cmd
    else
        return "\<Tab>"
    endif
endfunction
inoremap <silent> <Tab> <C-R>=<SID>tab_complete("P")<CR>
inoremap <silent> <S-Tab> <C-R>=<SID>tab_complete("N")<CR>
" }}}

" google_it() {{{
let s:open_cmd=executable('xdg-open') ? 'xdg-open ' : 'open '

function! s:google_it(phrase)
    let url='https://www.google.com/search?q='
    let q=substitute('"'.a:phrase.'"',
                   \ '[^A-Za-z0-9_.~-]',
                   \ '\="%".printf("%02X", char2nr(submatch(0)))',
                   \ 'g')
    call system(s:open_cmd . url . q)
endfunction
vnoremap <silent> <leader>k :call <SID>google_it(<SID>get_visual_selection())<CR>
nnoremap <silent> <leader>k :call <SID>google_it(expand("<cWORD>"))<CR>

function! s:go_to_httpstatuses(code)
    let url='https://httpstatuses.com/'
    let code = str2nr(a:code)
    call system(s:open_cmd . url . code)
endfunction
command! -nargs=1 HttpStatus :call <SID>go_to_httpstatuses(<q-args>)
" }}}

" FZF {{{
if has('nvim')
    let $FZF_DEFAULT_OPTS='--layout=reverse'
    let g:fzf_layout={'window': 'call FloatingFZF()'}

    function! FloatingFZF()
        " scratch, unlisted, new, empty, unnamed buffer
        let buf=nvim_create_buf(v:false, v:true)
        " % of the height
        let height=float2nr(&lines * 0.5)
        " % of the width
        let width=float2nr(&columns * 0.5)
        " horizontal position (centralized)
        let xpos=float2nr((&columns - width) / 2)
        " vertical position (one line down from the top)
        let ypos=1

        let opts={
            \ 'relative': 'editor',
            \ 'row': ypos,
            \ 'col': xpos,
            \ 'width': width,
            \ 'height': height
            \ }

        call nvim_open_win(buf, v:true, opts)
    endfunction
endif
" }}}

" Local {{{
let localrc=glob('~/.vimrc.local')
if filereadable(localrc)
    exec 'source' localrc
endif
" }}}

" vim: foldmethod=marker
