""Get out of VI's compatible mode.
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

""Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

""Plugin

Plugin 'tpope/vim-sensible'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'mattn/emmet-vim'
Plugin 'mileszs/ack.vim'
Plugin 'benmills/vimux'

"Plugin 'cireric/VimIM'
"Plugin 'ervandew/supertab'
"Plugin 'dkprice/vim-easygrep'
"Plugin 'vim-scripts/YankRing.vim'
"Plugin 'justinmk/vim-sneak'

"""Language
Plugin 'cireric/vimerl'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'fatih/vim-go'
Plugin 'othree/html5.vim'
Plugin 'lepture/vim-jinja'  "nunjucks syntax hightlighting

"""AutoComplete
Plugin 'Valloric/YouCompleteMe'
Plugin 'ternjs/tern_for_vim'
Plugin 'scrooloose/syntastic'

"""vim-snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

"""Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

"""Color schemes
Plugin 'altercation/vim-colors-solarized'

"Required, plugins available after.
call vundle#end()

call pathogen#infect()
call pathogen#helptags()

"Enable filetype plugin
filetype on
filetype plugin on

"filetype plugin indent on
filetype indent on

"Sets how many lines of history VIM har to remember
set history=400

"this lets us put the marker in the file so that
"it can be shared across and stored in version control.
set foldmethod=indent
"close to end it.  "set commentstring=\ #\ %s

"default fold level, all open, set it 200 or something
"to make it all closed.
set foldlevel=0

"Have the mouse enabled all the time:
set mouse=a

"Set to auto read when a file is changed from the outside
set autoread

"help language
"set helplang=cn

syntax enable
syntax on

set ffs=unix,dos,mac

"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on wild menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show command
set showcmd

"Show matching bracets
set showmatch

"show current mode
set showmode

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
"set ignorecase
set incsearch

"Highlight search things
set hlsearch
"set nohlsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"How many tenths of a second to blink
set mat=2


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
"Always hide the statusline
set laststatus=2

function! CurDir()
   let curdir = substitute(getcwd(), '/Users/tanyongchang/', "~/", "g")
   return curdir
endfunction

"Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set nofen
set fdl=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set noexpandtab        " real tabs please!
set expandtab           " change tab to N space
set tabstop=4           " tab spacing
set softtabstop=4       " unify it
set shiftwidth=4        " unify it
"set smarttab           " use tabs at start of a line, spaces elsewhere
set fo=tcrqnmM          " see help formatoptions (complex)
set linebreak           " wrap long lines at a character in 'breakat'
set textwidth=500       " maximum width of text that is being inserted
set wrap                " wrap lines
"set list

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Encoding Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gb18030,big5

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menuone,preview
set fileformat=unix
set fileformats=unix,dos,mac
set foldenable
set foldmethod=marker
set shell=/bin/zsh

"set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*.so,*.swp,*.zip,*/.git/*,*/.hg/*,*/.svn/*

"auto jump last cursor's position
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

"GUI Options
if has("gui_running")
    "set background=light
    set background=dark
    set guioptions=aegic
    colorscheme solarized
    if has('mac') 
        set guifont=Monaco:h14
    endif
    if exists('&macatsui')
       set nomacatsui
    endif
endif

"key map
"TODO 分MacOS, Linux 快键键
"map <F2> :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>
"map <F3> <CR>
"map <F4> :wall<CR>
"map <F5> :CtrlPMRUFiles<CR>
"map <F7> :<CR>
"map <F9> :nohlsearch<CR>
map <C-m> :nohlsearch<CR>
map <C-l> :0,$s/\s\+$//<CR>
"map <F12> :<CR>
"map <C-v> "+p<CR>
"map <C-c> "+y<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""
" => vimerl
"""""""""""""""""""""""""""""""
"let g:erlang_folding = 1
let g:erlang_show_errors = 1
let g:erlang_completion_cache = 1

"""""""""""""""""""""""""""""""
" => vim-javascript
"""""""""""""""""""""""""""""""
let g:javascript_enable_domhtmlcss = 1
let g:javascript_plugin_jsdoc = 1

"""""""""""""""""""""""""""""""
" => nerdtree
"""""""""""""""""""""""""""""""
let g:NERDTreeIgnore = ['node_modules/*']

"""""""""""""""""""""""""""""""
" => ctrlp
"""""""""""""""""""""""""""""""
"let g:ctrlp_use_caching = 1
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_show_hidden = 0
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
    \ 'file': '\v\.(beam|log|jpg|png|jpeg|dmg|pdf|eot|svg|ttf|woff)$',
    \ }
"let g:ctrlp_user_command = 'find %s -type f'

let g:ctrlp_mruf_max = 500
let g:ctrlp_mruf_exclude = '/tmp/.*\|/var/tmp/.*|/temp/.*'
"let g:ctrlp_mruf_include = '\.hrl$\|\.erl$'
"let g:ctrlp_mruf_case_sensitive = 1
let g:ctrlp_mruf_save_on_update = 1
let g:ctrlp_by_filename = 1

"""""""""""""""""""""""""""""""
" => vim-markdown
"""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1

"""""""""""""""""""""""""""""""
" => YouCompleteMe
"""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
inoremap <leader><leader> <C-x><C-o>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nmap <F4> :YcmDiags<CR>

" 自动补全配置
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0

"""""""""""""""""""""""""""""""
" => ack
"""""""""""""""""""""""""""""""
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
let g:ack_autoclose = 1

"""""""""""""""""""""""""""""""
" => syntastic
"""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

