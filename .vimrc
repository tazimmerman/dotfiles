" General {{{
set backspace=start,indent,eol
set browsedir=buffer
set cryptmethod=blowfish2
set encoding=utf-8
set fillchars= 
set formatoptions=tcrqn
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
" }}}

" Grep {{{
if has('unix')
    if executable('ag')
        set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
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
set wildmode=list:longest,full
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
set laststatus=2
set lazyredraw
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
    set ttyfast
    set t_Co=256
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
" }}}

" Syntax, Filetype {{{
syntax on
filetype on
filetype indent on
filetype plugin on
syntax sync fromstart
" }}}

" Plug-ins {{{
call plug#begin('~/.vim/bundle')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'hdima/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jonathanfilip/vim-lucius'
Plug 'morhetz/gruvbox'
Plug 'wellle/targets.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-commentary'
call plug#end()
" }}}

" Colors {{{
let g:gruvbox_italic=1
if has('gui_running')
    set background=light
    colorscheme lucius
else
    set background=dark
    colorscheme gruvbox
endif
" }}}

" Ctrl-P {{{
let g:ctrlp_match_window='max:10,results:100'
let g:ctrlp_root_markers=['cscope.out', 'tags']
let g:ctrlp_use_caching=1
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_max_depth=5
let g:ctrlp_lazy_update=1
let g:ctrlp_extensions=['buffertag', 'bookmarkdir']
let g:ctrlp_buftag_ctags_bin='~/.local/bin/ctags'
" }}}

" Syntastic {{{
let g:syntastic_enable_signs=has('gui')
let g:syntastic_enable_balloons=has('gui')
let g:syntastic_enable_highlighting=has('gui')
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map={ 'mode': 'passive' }
let g:syntastic_python_checkers=['pyflakes', 'pep8']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol='✗'
let g:syntastic_style_warning_symbol='⚠'
" }}}

" Airline {{{
let g:airline_powerline_fonts=1
let g:airline#extensions#wordcount#enabled=0
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#tabline#enabled=0
let g:airline#extensions#default#layout=[
    \ ['a', 'c'],
    \ ['x', 'z'],
    \ ]
" }}}

" Word Motion {{{
let g:wordmotion_prefix='<leader>'
" }}}

" Commands {{{
" Jump to the next diff and obtain it (repeat with @@, followed by @:)
command! -nargs=0 Fix :normal! ]cdo<CR>

" Find TODO, XXX, etc.
command! -nargs=0 Todo :lvimgrep /\#\s*\(XXX\|TODO\|NOTE\)/ %<CR>
" }}}

" Mappings {{{
" Popup navigation
inoremap <silent> <C-K> <C-R>=pumvisible() ? "\<lt>C-P>" : "\<lt>C-K>"<CR>
inoremap <silent> <C-J> <C-R>=pumvisible() ? "\<lt>C-N>" : "\<lt>C-J>"<CR>

" Alias space to leader
map <Space> <leader>

" Highlight word under cursor without jumping
nnoremap <silent> <leader>* :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hlsearch<CR>

" Reset search pattern
nnoremap <silent> <ESC> :let @/=""<CR>

" CtrlP shortcuts
nnoremap <silent> <C-K> :CtrlPBookmarkDir<CR>

" Syntastic shortcuts
nnoremap <silent> <F6> :SyntasticCheck<CR>
nnoremap <silent> <F7> :SyntasticReset<CR>

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

" Preview tag on Enter
nnoremap <silent> <leader><CR> :ptjump <C-R>=expand("<cword>")<CR><CR>

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

" grep_buffers() {{{
function! s:grep_buffers(word)
    silent cclose
    silent cexpr []
    silent execute ':bufdo | try | vimgrepadd /' . a:word . '/j % | catch | endtry'
    silent cwindow
endfunction
vnoremap <silent> <leader>i :call <SID>grep_buffers(<SID>get_visual_selection())<CR>
nnoremap <silent> <leader>i :call <SID>grep_buffers(expand("<cWORD>"))<CR>
" }}}

" Local {{{
if filereadable(glob('~/.vimrc.local'))
    source ~/.vimrc.local
endif
" }}}

" vim: foldmethod=marker
