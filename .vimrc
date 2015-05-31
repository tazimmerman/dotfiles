" General {{{
set backspace=start,indent,eol
set browsedir=buffer
set comments=sr:/*,mb:*,ex:*/
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
set wildignore+=*/tmp/*
set wildignore+=*.pyc,*.pyo,*.pyd
set wildignore+=*.so,*.o,*.dll,*.lib,*.obj,*.exe
set wildignore+=*.ttf,*.pdf,*.xls,*.xlsx,*.doc,*.docx
set wildignore+=*.h5,*.pcl,*.dat
set wildignore+=*.tar,*.gz,*.bz2
set wildignore+=*.png,*.gif,*.jpg,*.bmp,*.ico
set wildignore+=cscope.out,tags
" }}}

" Win32/64 {{{
if has('win32') || has('win64')
    set fileformats=unix,dos
    set shellslash
endif
" }}}

" MacOS {{{
if has('mac')
    set guifont=Sauce\ Code\ Powerline:h16
endif
" }}}

" UI {{{
set background=dark
set mousehide
set winminheight=0
set winminwidth=0

if has('gui_running')
    set antialias " Mac OSX only
    set guioptions=ai
    set guifont=Terminess\ Powerline\ 12
else
    set t_Co=256
endif
" }}}

" Auto Commands {{{
augroup CursorLine
    autocmd!
    autocmd WinLeave,InsertEnter * set nocursorline
    autocmd WinEnter,InsertLeave * set cursorline
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
Plug 'SirVer/ultisnips'
Plug 'hdima/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'bling/vim-airline'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-multiple-cursors'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
"Plug 'ivalkeen/vim-ctrlp-tjump'
"Plug 'fisadev/vim-ctrlp-cmdpalette'
call plug#end()
" }}}

" Gruvbox {{{
colorscheme gruvbox
" }}}

" Sneak {{{
let g:sneak#streak=1
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

" UltiSnips {{{
let g:UltiSnipsSnippetDirectories=['ultisnips']
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
nmap <Space> <leader>

" Erase trailing whitespace on any line
nmap <silent> <leader><BS> :%s/\s\+$//g<CR>

" Reset search pattern
nmap <silent> <leader><ESC> :let @/=""<CR>

" Syntastic check/reset
nmap <silent> <leader>sc :SyntasticCheck<CR>
nmap <silent> <leader>sr :SyntasticReset<CR>

" Wrap a word in quotes
nmap <silent> <leader>q' ciw'<C-R><C-O>"'<Esc>
nmap <silent> <leader>q" ciw"<C-R><C-O>""<Esc>
nmap <silent> <leader>q" ciw"<C-R><C-O>""<Esc>
nmap <silent> <leader>q( ciw(<C-R><C-O>")<Esc>
nmap <silent> <leader>q[ ciw[<C-R><C-O>"]<Esc>
nmap <silent> <leader>q{ ciw{<C-R><C-O>"}<Esc>
nmap <silent> <leader>q< ciw<<C-R><C-O>"><Esc>

" Format a paragraph
noremap <silent> <leader>gq gqap

" Inverse of g]
nnoremap <silent> g[ :pop<CR>
" }}}

" Cscope {{{
if has('cscope')
    set cscopeprg=cscope
    set cscopetag
    set cscopetagorder=1
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set nocscopeverbose

    if filereadable('cscope.out')
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " Find this C symbol
    nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    " Find this definition
    nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    " Find functions called by this function
    nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    " Find functions calling this function
    nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    " Find this text string
    nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    " Find this egrep pattern
    nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    " Find this file
    nmap <C-@>f :cs find f <C-R>=expand("<cword>")<CR><CR>
    " Find files #including this file
    nmap <C-@>i :cs find i <C-R>=expand("<cword>")<CR><CR>
    " View the tag (g-] behavior)
    nmap <C-@>] :tselect <C-R>=expand("<cword>")<CR><CR>
endif
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
function! s:google_it(phrase)
    let url='https://www.google.com/search?q='
    let q=substitute(
                \ '"'.a:phrase.'"',
                \ '[^A-Za-z0-9_.~-]',
                \ '\="%".printf("%02X", char2nr(submatch(0)))',
                \ 'g')
    call system('/home/tzimmerm/firefox/latest/firefox ' . url . q)
endfunction
nnoremap <silent> <leader>? :call <SID>google_it(expand("<cWORD>"))<CR>
" }}}

" vim: foldmethod=marker
