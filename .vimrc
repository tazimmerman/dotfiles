" General {{{
set backspace=start,indent,eol
set browsedir=buffer
set encoding=utf-8
set fillchars= 
set formatoptions=tcrqn
set hidden
set laststatus=2
set listchars=tab:\|\ ,extends:>,precedes:<
set makeprg=make
set noswapfile
set nowrap
set ruler
set scrolloff=5
set showmatch
set switchbuf=usetab
set tags=./tags;
" }}}

" Grep {{{
if has('unix')
    set grepprg=~/.local/bin/ack\ -s\ --with-filename\ --nocolor\ --nogroup\ --column
    set grepformat=%f:%l:%c:%m
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
set wildmenu
set wildmode=list:longest,full
set complete=.,w,b,u,t
set completeopt=menu,preview
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
set background=dark
set colorcolumn=+1
set cursorline
set mousehide
set winminheight=0
set winminwidth=0

if has('gui')
    set guioptions=aci
endif

if has('gui_macvim')
    set antialias
    set guifont=Sauce\ Code\ Powerline:h16
elseif has('gui_running')
    set guifont=Terminess\ Powerline\ 12
else
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
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'ervandew/supertab'
Plug 'hdima/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'bling/vim-airline'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'bkad/CamelCaseMotion'
Plug 'jiangmiao/auto-pairs'
"Plug 'ivalkeen/vim-ctrlp-tjump'
"Plug 'fisadev/vim-ctrlp-cmdpalette'
call plug#end()
" }}}

" Gruvbox {{{
colorscheme gruvbox
" }}}

" Ctrl-P {{{
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_show_hidden=0
let g:ctrlp_switch_buffer=1
let g:ctrlp_match_window='max:10,results:100'
let g:ctrlp_use_caching=1
let g:ctrlp_root_markers=['cscope.out', 'tags']
let g:ctrlp_extensions=['buffertag']
let g:ctrlp_buftag_ctags_bin='/home/tzimmerm/tp/vim/7.4/bin/ctags'
let g:ctrlp_by_filename=1
" }}}

" Syntastic {{{
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_python_checkers=['pyflakes', 'pep8']
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=has('gui')
let g:syntastic_enable_highlighting=has('gui')
let g:syntastic_enable_balloons=has('gui')
let g:syntastic_mode_map={ 'mode': 'passive' }
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol='✗'
let g:syntastic_style_warning_symbol='⚠'
" }}}

" Airline {{{
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#enabled=0
" }}}

" Commands {{{
" Jump to the next diff and obtain it (repeat with @@, followed by @:)
command -nargs=0 Fix :normal ]cdo<CR>

" Find TODO, XXX, etc.
command -nargs=0 Todo :lvimgrep /\#\s*\(XXX\|TODO\|NOTE\)/ %<CR>
" }}}

" Mappings {{{
" Popup navigation
inoremap <silent> <C-K> <C-R>=pumvisible() ? "\<lt>C-P>" : "\<lt>C-K>"<CR>
inoremap <silent> <C-J> <C-R>=pumvisible() ? "\<lt>C-N>" : "\<lt>C-J>"<CR>

" Alias space to leader
map <Space> <leader>

" Erase trailing whitespace on any line
nnoremap <silent> <leader><BS> :%s/\s\+$//g<CR>

" Reset search pattern
nnoremap <silent> <leader><ESC> :nohlsearch<CR>

" Syntastic check/reset
nnoremap <silent> <leader>sc :SyntasticCheck<CR>
nnoremap <silent> <leader>sr :SyntasticReset<CR>

" Wrap a word in quotes
nnoremap <silent> <leader>q' ciw'<C-R><C-O>"'<Esc>
nnoremap <silent> <leader>q" ciw"<C-R><C-O>""<Esc>
nnoremap <silent> <leader>q" ciw"<C-R><C-O>""<Esc>
nnoremap <silent> <leader>q( ciw(<C-R><C-O>")<Esc>
nnoremap <silent> <leader>q[ ciw[<C-R><C-O>"]<Esc>
nnoremap <silent> <leader>q{ ciw{<C-R><C-O>"}<Esc>
nnoremap <silent> <leader>q< ciw<<C-R><C-O>"><Esc>

" Format a paragraph
noremap <silent> <leader>gq gqap

" Inverse of g]
nnoremap <silent> g[ :pop<CR>

" Move lines with indent
nnoremap <silent> <Up> :move-2<CR>==
nnoremap <silent> <Down> :move+<CR>==
inoremap <silent> <Up> <Esc>:move-2<CR>==gi
inoremap <silent> <Down> <Esc>:move+<CR>==gi
vnoremap <silent> <Up> :move'<-2<CR>gv=gv
vnoremap <silent> <Down> :move'>+<CR>gv=gv

" }}}

" tab_complete() {{{
function! s:tab_complete()
    if pumvisible()
        return "\<C-N>"
    endif
    if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$'
        return "\<Tab>"
    elseif exists('&omnifunc') && &omnifunc != ''
        return "\<C-X>\<C-O>"
    else
        return "\<C-N>"
    endif
endfunction
inoremap <silent> <C-@> <C-R>=<SID>tab_complete()<CR>
" }}}

" google_it() {{{
let s:open_cmd=executable('xdg-open') ? 'xdg-open ' : 'open '

function! s:google_it(phrase)
    let url='https://www.google.com/search?q='
    let q=substitute(
                \ '"'.a:phrase.'"',
                \ '[^A-Za-z0-9_.~-]',
                \ '\="%".printf("%02X", char2nr(submatch(0)))',
                \ 'g')
    call system(s:open_cmd . url . q)
endfunction
nnoremap <silent> <leader>? :call <SID>google_it(expand("<cWORD>"))<CR>
" }}}

" grep_buffers() {{{
function! s:grep_buffers(word)
    silent execute ":cclose|cex []|bufdo vimgrepadd /" . a:word . "/j %|cwindow"
endfunction
nnoremap <silent> <leader>/ :call <SID>grep_buffers(expand("<cWORD>"))<CR>
" }}}

" vim: foldmethod=marker
