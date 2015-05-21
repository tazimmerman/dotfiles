set nocompatible
set backspace=start,indent,eol
set wildmenu
set wildmode=list:longest,full
set wildignore=*/.git/*,*/.hg/*,*/.svn/*,*/tmp/*,*.pyc,*.pyo,*.so,*.o,*.dll,*.lib,*.pyd,*.obj,*.h5,*.ttf,*.pdf,*.xls,*.pcl,*.tar,*.gz,*.png,*.gif,*.jpg,*.dat,tags
set complete=.,w,b,u,t
set completeopt=menu,preview
set ignorecase
set smartcase
set infercase
set showmatch
set hlsearch
set incsearch
set ruler
set nowrap
set nowrapscan
set comments=sr:/*,mb:*,ex:*/
set formatoptions=cqr
set makeprg=make
set fileformats=unix,dos
set encoding=utf-8
set browsedir=buffer
set switchbuf=usetab
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winpos,winsize
set mousehide
set hidden
set noswapfile
set shellslash
set fillchars= 
set foldmethod=indent
set foldlevel=20
set laststatus=2
set t_Co=256
set winminheight=0
set winminwidth=0
set updatetime=2000
set antialias
set scrolloff=5
set listchars=tab:\|\ ,extends:>,precedes:<
set tags=./tags;
set runtimepath+=~/.vim/bundle/Vundle.vim,~/.local/share/vim

" Disable Git SSL verification
let $GIT_SSL_NO_VERIFY='true'

" Begin Vundle plugin management
filetype off
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'vcscommand.vim'
Plugin 'hdima/python-syntax'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'justinmk/vim-sneak'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'chriskempson/base16-vim'
Plugin 'tomasr/molokai'
"Plugin 'ivalkeen/vim-ctrlp-tjump'
"Plugin 'fisadev/vim-ctrlp-cmdpalette'
call vundle#end()
" End Vundle plugin management

let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_show_hidden=0
let g:ctrlp_switch_buffer=1
let g:ctrlp_match_window='max:10,results:100'
let g:ctrlp_use_caching=1
let g:ctrlp_root_markers=['cscope.out', 'tags']
let g:ctrlp_extensions=['buffertag']
let g:ctrlp_buftag_ctags_bin='/home/tzimmerm/tp/vim/7.4/bin/ctags'
let g:ctrlp_by_filename=1

let g:UltiSnipsSnippetDirectories=["ultisnips"]

let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_python_checkers=['pyflakes', 'pep8']
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=has("gui")
let g:syntastic_enable_highlighting=has("gui")
let g:syntastic_enable_balloons=has("gui")
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:VCSCommandSVNExec='/auto/csmodeldata/foopen/AMD64/svn185/python2.7/bin/svn'

augroup VCSCommand
    au User VCSBufferCreated silent! nmap <unique> <buffer> q :bwipeout<CR>
augroup END

syntax on
filetype on
filetype indent on
filetype plugin on
syntax sync fromstart

" Jump to the next diff and obtain it (repeat with @@, followed by @:)
command -nargs=0 DO :normal ]cdo<CR>

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
nmap <silent> <leader>q" ciw'<C-R><C-O>"'<Esc>

if has("cscope")
    set cscopeprg=cscope
    set cscopetag
    set cscopetagorder=1
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set nocscopeverbose

    if filereadable("cscope.out")
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

set background=dark
colorscheme base16-default
set cursorline

if has("gui_running")
    set guioptions=ai
    set guifont=Sauce\ Code\ Powerline:h16
    set lines=32
    set columns=128
endif
