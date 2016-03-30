source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/ftplugin/man.vim

let g:vim_file_root="~/.vim"

syntax on
let g:html_use_css = 0
set nu
set nobackup
set ic 	"ignore case when search, to turn it off, run :set noic
set smartindent
set autoindent
"autocmd FileType c,cpp,h,asp,html set shiftwidth=4 | set tabstop=4 | set expandtab  
set shiftwidth=4 " set auto indent width to 4 when switch lines
set tabstop=4 " set indent width to 4
set expandtab " use spaces instead of tab 
set encoding=utf8 " use utf8 encoding by default
set ruler " show the line and column number of the cursor position
set incsearch
set hlsearch
set smartcase " be case sensitive if the search pattern contains upper case letter
set guioptions-=eT " remove tab header line and toolbar

if has('win32') || has('win64')
    let g:vim_file_root="c:/tools/vim/vimfiles"
    au GUIEnter * simalt ~x " start gvim in maximazed mode
    "source $VIMRUNTIME/mswin.vim
    "behave mswin
    colo molokai

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
    colo molokai
    set guifont=Monaco:h13 " set font to Consolas, height 11
else
    if has('gui_running')
        colo mydesert
    else
        colo molokai
    endif
endif

set nocompatible
set laststatus=2
set history=80
set noundofile
" enable hidden so that a buffer is allowed to be closed to hidden mode
" unless we terminate the edit session
set hidden
"let vim command line be more zsh like
set wildmode=full
set wildmenu

if executable('ag')
    " use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ cscope.\\*\ --ignore\ tags
else
    set grepprg=grep\ -nrIE\ --exclude=\"cscope.*\"\ --exclude=tags
endif
nnoremap \gp :grep 

function! CountApperenceOf(pattern)
    let pattern = a:pattern
    if a:pattern == ""
        let pattern = input("Count apperence of:")
    endif
    let pattern = escape(pattern, '/')
    execute ":%s/\\V" . pattern . "//gn"
endfunction

nnoremap \wc :call CountApperenceOf("")<CR>
vnoremap \wc <esc>:call CountApperenceOf(GetVisualSelection())<CR>
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
nnoremap \du :diffupdate<CR>
" tcsh-style editing keys
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>

" vundle configuration
filetype off " required for vundle

exec 'set rtp+='.g:vim_file_root.'/bundle/vundle'
call vundle#begin(g:vim_file_root."/bundle")
" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" My bundles here:
Bundle 'tpope/vim-fugitive'
Bundle 'gregsexton/gitv'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/DoxygenToolkit.vim'
Bundle 'rxwen/javacomplete'
Bundle 'rxwen/gtags.vim'
Bundle 'rxwen/vim-cscope_maps'
Bundle 'rxwen/vim-finder'
Bundle 'rxwen/vim-ctrlp_extensions'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'tmhedberg/matchit'
Bundle 'Valloric/YouCompleteMe'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-surround'
Bundle 'bling/vim-airline'
Bundle 'davidhalter/jedi-vim'
Bundle 'tpope/vim-dispatch'
Bundle 'fatih/vim-go'
Bundle 'vim-ruby/vim-ruby'
Bundle 'PProvost/vim-ps1'
Bundle 'tfnico/vim-gradle'
Bundle 'ekalinin/Dockerfile.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/syntastic'
Bundle 'phongvcao/vim-stardict'
Bundle 'Yggdroot/indentLine'
Bundle 'godlygeek/tabular'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'elzr/vim-json'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'aklt/plantuml-syntax'
call vundle#end()            " required

filetype on " revert filetype option after vundle initialization
" vundle configuration end

" doxygentoolkit mapping
nmap \dx :Dox<CR>
" end doxygentoolkit mapping

" git command
nnoremap \gs :Gstatus<CR>
nnoremap \gl :Glog<CR>
nnoremap \ggl :Gvsplit! log --stat<CR>
nnoremap \gb :Gblame<CR>
nnoremap \gd :Gvdiff<CR>
nnoremap \gv :Gitv --all<CR>
" \gV to show log for current buffer
nnoremap \gV :Gitv! --all<CR>
vmap \gV :Gitv! --all<CR>
set directory+=$TMP

" gitgutter configuration
nnoremap \gh :GitGutterLineHighlightsToggle<CR>
let g:gitgutter_highlight_lines = 0

" map \b to run make command
nnoremap \b :Make<CR>
nnoremap \B :Make 

" nerdtree options
nnoremap \nt    :NERDTreeFocus<CR>
nnoremap \nT    :NERDTree 
nnoremap \nf    :NERDTreeFind<CR>

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

" man utility options
function! GetVisualSelection()
    let [s:lnum1, s:col1] = getpos("'<")[1:2]
    let [s:lnum2, s:col2] = getpos("'>")[1:2]
    let s:lines = getline(s:lnum1, s:lnum2)
    let s:lines[-1] = s:lines[-1][: s:col2 - (&selection == 'inclusive' ? 1 : 2)]
    let s:lines[0] = s:lines[0][s:col1 - 1:]
    return join(s:lines, ' ')
endfunction

nnoremap \m :Man 
nnoremap K :exec "Man" expand("<cword>")<CR>
vnoremap K <esc>:exec "Man " GetVisualSelection()<CR>

" youcompleteme configuration
let g:ycm_collect_identifiers_from_tags_files = 0 " consumes too much memory when work with linux kernel
let g:ycm_key_list_previous_completion = [] "disable default key
let g:ycm_key_list_select_completion = [] "disable default key
"let g:ycm_key_invoke_completion = '<C-XC-O>'
let g:ycm_global_ycm_extra_conf = g:vim_file_root.'/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_seed_identifiers_with_syntax = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 0
let g:ycm_error_symbol = 'x'
let g:ycm_warning_symbol = '>'
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1

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
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.obj,*.o,cscope.*,tags  " Windows
else
    set wildignore+=*.swp,*/.git/*,*/.hg/*,*/.svn/*,*.o,cscope.*,tags    " Linux/MacOSX
endif
let g:ctrlp_prompt_mappings = {
\ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
\ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
\ 'PrtHistory(-1)':       ['<c-k>'],
\ 'PrtHistory(1)':        ['<c-j>'],
\ }

let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn)$',
\ 'file': '\v\.(exe|so|dll|o|obj|swp|a|lib|pyc|pyd|pdf|jpg|png|bmp|avi|swf|mp4|mpeg|kmv|mp3|cscope.out|cscope.files|tags|zip|rar|tgz|gz|tar|7z|iso)$',
\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
\ }

nmap \ff  :CtrlP ./<CR>
nmap \fb  :CtrlPBuffer<CR>
nmap \fc  :CtrlPCurFile<CR>
" show root 
nmap \fr  :CtrlP<CR>
nmap \fm  :CtrlPMRUFiles<CR>
" list all tags from tags file
nmap \fa  :CtrlPTag<CR>
" list tags in current buffer
nmap \ft  :CtrlPBufTag<CR>
" list tags in all buffers
nmap \fT  :CtrlPBufTagAll<CR>
nmap \fq  :CtrlPQuickfix<CR>
nmap \fl  :CtrlPLine<CR>
nmap \fs  :CtrlPListSource<CR>
nmap \f:  :CtrlPCmdHistory<CR>
nmap \f;  :CtrlPCmdHistory<CR>
" map f; to cmd history too, can save a shift key stroke
nmap \f/  :CtrlPSearchHistory<CR>

" jedi plugin configuration (included via Youcompleteme plugin, as submodule)
"let g:jedi#documentation_command = 'K'
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = "<leader>d"
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
let g:jedi#popup_select_first = 0
let g:jedi#auto_close_doc = "1"
""let g:jedi#completions_command = "<C-Space>"
"let g:jedi#rename_command = "<leader>r"
"let g:jedi#show_call_signatures = "1"
""autocmd FileType python if g:jedi#documentation_command != '' | execute "vnoremap <silent> <buffer>".g:jedi#documentation_command." :call jedi#show_documentation()<CR>" | endif

" formatprg configuration
function! SetFormatPrg()
    if &filetype == "xml"
        set formatprg=xmllint\ --format\ -
    elseif &filetype == "json"
        set formatprg=jq\ '.'
    elseif &filetype == "cpp" || &filetype == "c"
        set formatprg=astyle\ --mode=c\ -A2\ -c\ -j\ -p\ -k3\ -n\ -z2
    endif
endfunction

autocmd BufEnter * :call SetFormatPrg()
autocmd FileType * :call SetFormatPrg()

" gtags configuration
let g:Gtags_prefer_gtags_to_cscope = 0
let g:Gtags_Auto_Map = 1
let g:Gtags_OpenQuickfixWindow = 0

" a.vim configuration
nnoremap \av :AV<CR>
nnoremap \as :AS<CR>
nnoremap \at :AT<CR>
nnoremap \ag :A<CR>

" startdict configuration
nnoremap \sw :StarDict<space>
nnoremap \sc :StarDictCursor<CR>

" indentline configuration
nnoremap \ig :IndentLinesToggle<CR>
let g:indentLine_enabled=0
let g:indentLine_showFirstIndentLevel=1
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
let g:indentLine_fileTypeExclude = ['txt', 'log']
" enable indent for tab
" :set list lcs=tab:\|\ 

" tabular configuration
nnoremap \t= :Tabularize /=<CR>
nnoremap \t: :Tabularize /:<CR>
nnoremap \t, :Tabularize /,<CR>
nnoremap \t<Bar> :Tabularize /<Bar><CR>
vnoremap \t :Tabularize /

" toggle ruler
nnoremap \r :set cursorline! cursorcolumn!<CR>

" UltiSnips configuration
let g:UltiSnipsEnableSnipMate=1
