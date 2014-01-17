source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/ftplugin/man.vim

let g:vim_file_root="~/.vim"

if has('win32') || has('win64')
    let g:vim_file_root="d:/vim/vimfiles"
    au GUIEnter * simalt ~x " start gvim in maximazed mode
    "source $VIMRUNTIME/mswin.vim
    "behave mswin
    colo darkblue

    " Alt-Space is System menu
    if has("gui")
      noremap <M-Space> :simalt ~<CR>
      inoremap <M-Space> <C-O>:simalt ~<CR>
      cnoremap <M-Space> <C-C>:simalt ~<CR>

      set guifont=Consolas:h11 " set font to Consolas, height 11
    endif

    set guioptions-=b " remove scrollbars from gui
    set guioptions-=B " remove scrollbars from gui
    set guioptions-=l " remove scrollbars from gui
    set guioptions-=L " remove scrollbars from gui
    set guioptions-=r " remove scrollbars from gui
    set guioptions-=R " remove scrollbars from gui
elseif has("mac")
    colo darkblue
    set guifont=Monaco:h13 " set font to Consolas, height 11
else
    if has('gui_running')
        colo desert
    else
        colo torte
    endif
endif

set nocompatible
set laststatus=2

:set grepprg=grep\ -nrIE
nnoremap \gp :grep 

nnoremap \cn :cnext<CR> 
nnoremap \cp :cprevious<CR> 
nnoremap <C-W>t :tabnew<CR> 
" yank current file name to unamed register
nnoremap \fp :let @"=expand("%:p")<CR> 
nnoremap \fn :let @"=expand("%:t")<CR> 
nnoremap \fd :let @"=expand("%:p:h")<CR> 
" yank current file name to clipboard 
nnoremap \fP :let @*=expand("%:p")<CR> 
nnoremap \fN :let @*=expand("%:t")<CR> 
nnoremap \fD :let @*=expand("%:p:h")<CR> 
nnoremap \df :diffthis<CR>
nnoremap \ds :vert diffsplit 
nnoremap \do :diffoff<CR>
" tcsh-style editing keys
:cnoremap <C-A> <Home>
:cnoremap <C-F> <Right>
:cnoremap <C-B> <Left>

syntax on
let g:html_use_css = 0
set nu
set nobackup
set ic 	"ignore case when search, to turn it off, run :set noic
set smartindent
set autoindent
set guioptions-=T 
"autocmd FileType c,cpp,h,asp,html set shiftwidth=4 | set tabstop=4 | set expandtab  
set shiftwidth=4 " set auto indent width to 4 when switch lines
set tabstop=4 " set indent width to 4
set expandtab " use spaces instead of tab 
set encoding=utf8 " use utf8 encoding by default
set ruler
set incsearch
set hlsearch


exec 'autocmd BufNewFile makefile   0r '.g:vim_file_root.'/skeleton/makefile.skel'
exec 'autocmd BufNewFile Android.mk 0r '.g:vim_file_root.'/skeleton/Android.mk.skel'
exec 'autocmd BufNewFile *.tex      0r '.g:vim_file_root.'/skeleton/tex.skel'
exec 'autocmd BufNewFile *.py       0r '.g:vim_file_root.'/skeleton/py.skel'
exec 'autocmd BufNewFile *.pyw      0r '.g:vim_file_root.'/skeleton/py.skel'

" vundle configuration
"filetype off " required for vundle

exec 'set rtp+='.g:vim_file_root.'/bundle/vundle'
call vundle#rc(g:vim_file_root."/bundle")
" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" My bundles here:
Bundle 'tpope/vim-fugitive'
Bundle 'gregsexton/gitv'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/DoxygenToolkit.vim'
Bundle 'vim-scripts/javacomplete'
Bundle 'rxwen/vim-cscope_maps'
Bundle 'rxwen/vim-finder'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tmhedberg/matchit'
Bundle 'Valloric/YouCompleteMe'
Bundle 'majutsushi/tagbar'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-surround'
Bundle 'bling/vim-airline'
Bundle 'godlygeek/tabular'
Bundle 'davidhalter/jedi-vim'

" vundle configuration end

" doxygentoolkit mapping
nmap \dx :Dox<CR>
" end doxygentoolkit mapping

" generate errorformat(%f:%l: %m) string based on current cursor position
nnoremap \qp :let @"=expand("%").":".line(".").": ".expand("<cWORD>")."\n"<CR> 
" reload errorfile
nnoremap \qr :cg .stack<CR> 
nnoremap \qv :vsplit .stack<CR> 

" git command
nnoremap \gs :Gstatus<CR>
nnoremap \gl :Glog<CR>
nnoremap \ggl :Gvsplit! log --stat<CR>
nnoremap \gb :Gblame<CR>
nnoremap \gd :Gdiff<CR>
nnoremap \gv :Gitv<CR>
set directory+=$TMP

" map \b to run make command
nnoremap \b :make<CR>

" support aapt errorformat
let &efm = '\ %#[aapt]\ %f:%l:\ %m,' . &efm
" support ant errorformat, see :help errorformat-ant and :help let-option
let &efm = '%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#,' . &efm


" nerdtree options
nnoremap \nt    :NERDTreeFocus<CR>
nnoremap \nT    :NERDTree 
nnoremap \nf    :NERDTreeFind<CR>

" snipMate options
let g:snippets_dir = g:vim_file_root."/snippets"
let g:snips_email = "rx.wen218@gmail.com"
let g:snips_author = "Raymond Wen"

" finder utility
nnoremap \fi :Find 
nnoremap \fI :FindNoCase 
nnoremap \lo :Locate 

" tagbar options
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_left = 1
nnoremap \tg :TagbarToggle<CR>

nnoremap \m  :Man 
nnoremap K :exec "Man" expand("<cword>")<CR>

" youcompleteme configuration
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_key_list_previous_completion = [] "disable default key
let g:ycm_key_list_select_completion = [] "disable default key
"let g:ycm_key_invoke_completion = '<C-XC-O>'
let g:ycm_global_ycm_extra_conf = g:vim_file_root.'/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_seed_identifiers_with_syntax = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 0

" ctrlp configuration
let g:ctrlp_regexp = 0
let g:ctrlp_match_window = 'bottom,order:ttb,min:0,max:50'
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
if has('win32') || has('win64')
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*    " Linux/MacOSX
endif
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn)$',
\ 'file': '\v\.(exe|so|dll|o|swp|a|lib|pyc|pyd|pdf|jpg|png|bmp|avi|swf|mp4|mpeg|kmv|mp3)$',
\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
\ }
let g:ctrlp_prompt_mappings = {
\ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
\ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
\ 'PrtHistory(-1)':       ['<c-k>'],
\ 'PrtHistory(1)':        ['<c-j>'],
\ }

nmap \ff  :CtrlP ./<CR>
nmap \fb  :CtrlPBuffer<CR>
nmap \fc  :CtrlPCurFile<CR>
" show root dir ($HOME or cvs root)
nmap \fr  :CtrlP<CR>
nmap \fma :CtrlPBookmarkFileAdd<CR>
nmap \fmd :CtrlPBookmarkDir<CR>
nmap \ft  :CtrlPTag<CR>
nmap \fq  :CtrlPQuickfix<CR>
nmap \fl  :CtrlPLine<CR>

" jedi plugin configuration (included via Youcompleteme plugin, as submodule)
"let g:jedi#documentation_command = 'K'
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = "<leader>d"
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
""let g:jedi#completions_command = "<C-Space>"
"let g:jedi#rename_command = "<leader>r"
"let g:jedi#show_call_signatures = "1"

" formatprg configuration
autocmd FileType cpp,c set formatprg=astyle\ --mode=c\ -A2\ -c\ -j\ -p\ -k3\ -n\ -z2
