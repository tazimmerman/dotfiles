" General {{{
set autoread
set backspace=start,indent,eol
set browsedir=buffer
set cryptmethod=blowfish2
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
set tags=./tags;
set virtualedit=block
" }}}

" Grep {{{
if has('unix')
    if executable('ag')
        set grepprg=ag\ --nogroup\ --nocolor\ --column\ --vimgrep
    elseif executable('ack')
        set grepprg=ack\ -s\ --with-filename\ --nocolor\ --nogroup\ --column
    endif
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
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
set complete=.,w,b
set completeopt=menu
set pumheight=15
" }}}

" Wild Ignore {{{
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/tmp/*,*/research-data/*,*/test-data/*
set wildignore+=*.pyc,*.pyo,*.pyd
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
set colorcolumn=+1
set cursorline
set display=lastline
set laststatus=2
set number
set relativenumber
set ruler
set mousehide
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
    set guifont=Fantasque\ Sans\ Mono\ 12
else
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
    set termguicolors
    set lazyredraw
    set ttyfast
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
packadd! python-syntax
packadd! vim-python-pep8-indent
packadd! lightline.vim
packadd! lightline-gruvbox.vim
packadd! targets.vim
packadd! vim-wordmotion
packadd! vim-abolish
packadd! vim-commentary
packadd! vim-repeat
packadd! vim-surround
packadd! base16-vim
packadd! gruvbox
packadd! papercolor-theme
packadd! probe
packadd! hasksyn
packadd! vim-gitgutter
packadd! ale
" }}}

" Colors {{{
if has('gui_running')
    set background=dark
    colorscheme base16-monokai
else
    set background=dark
    colorscheme gruvbox
endif
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

" Lightline {{{
let g:lightline={}
let g:lightline.colorscheme=has('gui_running') ? 'powerline' : 'gruvbox'
let g:lightline.component={
    \ 'modified': "%{&modified ? '✎' : ''}",
    \ 'readonly': "%{&readonly ? '' : ''}",
    \ }
" }}}

" Word Motion {{{
let g:wordmotion_prefix='<leader>'
" }}}

" Probe {{{
let g:probe_use_gitignore=1
let g:probe_use_wildignore=1
let g:probe_mappings={'select_next': '<c-j>', 'select_prev': '<c-k>'}
" }}}

" Git Gutter {{{
let g:gitgutter_realtime=0
let g:gitgutter_map_keys=0
let g:gitgutter_sign_column_always=1
" }}}

" ALE {{{
let g:ale_lint_on_enter=0
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_insert_leave=1
let g:ale_set_highlights=0
let g:ale_set_signs=0
let g:ale_linters={
    \ 'python': ['flake8']
    \ }
let g:ale_python_flake8_args='--ignore=E501,W291' " line too long, trailing whitespace
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

" Probe shortcuts
nnoremap <silent> <leader>f :ProbeFindInRepo<CR>
nnoremap <silent> <leader>F :ProbeFindBuffer<CR>

" Git Gutter shortcuts
nmap <silent> <leader>h <Plug>GitGutterStageHunk
nmap <silent> <leader>H <Plug>GitGutterUndoHunk
nmap <silent> ]h <Plug>GitGutterNextHunk
nmap <silent> [h <Plug>GitGutterPrevHunk
nmap <silent> ih <Plug>GitGutterTextObjectInnerPending
nmap <silent> ah <Plug>GitGutterTextObjectOuterPending
nmap <silent> ih <Plug>GitGutterTextObjectInnerVisual
nmap <silent> ah <Plug>GitGutterTextObjectOuterVisual

" ALE shortcuts
nmap <silent> ]l <Plug>(ale_next)
nmap <silent> [l <Plug>(ale_previous)
nmap <silent> <leader>l <Plug>(ale_lint)

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
nnoremap <silent> <leader>p :ptjump <C-R>=expand("<cword>")<CR><CR>

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
" }}}

" pack_tags() {{{
function! s:pack_tags()
    for entry in expand(glob('~/.vim').'**/doc', 0, 1)
        if isdirectory(entry)
            exec 'helptags' entry
        endif
    endfor
endfunction
command! -nargs=0 HelpTags :call <SID>pack_tags()
" }}}

" Local {{{
let localrc=glob('~/.vimrc.local')
if filereadable(localrc)
    exec 'source' localrc
endif
" }}}

" vim: foldmethod=marker
