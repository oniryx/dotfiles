set nocompatible               " Load the latest Vim settings/options

"so ~/.vim/plugins.vim

" COLORS ====================== "

colorscheme desert
set background=dark             " using the dark colorscheme
syntax enable                   " enable syntax processing
set encoding=utf-8
set t_Co=256
highlight Normal ctermbg=None


" SPACES & TABS =============== "

set tabstop=4                   " number of visual spaces per TAB
set softtabstop=4               " number of spaces in tab when editing
set shiftwidth=4                " number of spaces when indenting lines with >>
set expandtab                   " tabs are spaces


" UI CONFIG =================== "

set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set showcmd                     " show which command in bottom bar
"set cursorline                  " highlight current line
filetype indent on              " load filetype-specific indent files
set wildmenu                    " visual autocomplete for command menu
set wildmode=list:longest,full
set lazyredraw                  " redraw only when we need to.
set showmatch                   " show matching brackets
set showmode                    " always show command or insert mode
set statusline+=%F\ %l\:%c      " show filename line columns
set formatoptions=tcqor
set whichwrap=b,s,<,>,[,]       " cursors will now wrap
set mouse=a                     " move cursor with mouse pointer
set visualbell                  " don't beep
set noerrorbells                " don't beep
set scrolloff=2                 " Always show at least 2 lines above/below the cursor
set autowriteall                " Save current file before switching file
set clipboard=unnamed           " Copy yanked selection into Mac clipboard


" SEARCHING =================== "

set incsearch                   " search as characters are entered
set hlsearch                    " highlight matches
set ignorecase                  " caseinsensitive searches
set smartcase                   " only sensitive search when needed


" LEADER ====================== "

let mapleader=","               " leader is ,

" MAPPINGS ==================== "

map <S-h> gT                    " Switch to Tab to the Left
map <S-l> gt                    " Switch to Tab to the Right

" turn off search highlight
nmap <leader><space> :nohlsearch<CR>

" Make NERDTree easier to toggle
nmap <leader>1 :NERDTreeToggle<CR>

" List all the function/variable in the file
nmap <leader>r :CtrlPBufTag<CR>

" Look for tag
nmap <leader>f :tag<space>

autocmd FileType php noremap <C-M> :w!<CR>:!/usr/bin/php %<CR>
autocmd FileType php noremap <C-L> :w!<CR>:!/usr/bin/php -l %<CR>
autocmd FileType php noremap <leader>t :w!<CR>:call RunPHPUnitTest(0)<CR>
autocmd FileType php noremap <leader>m :w!<CR>:call RunPHPUnitTest(1)<CR>
autocmd FileType php noremap <C-]> :tabnew %<CR>g<C-]>
" Fix syntax
autocmd FileType php noremap <leader>fs :w!<CR>:!phpcbf %<CR>

" Set filetype for twig files
au BufNewFile,BufRead *.twig set filetype=htmljinja



" AUTOGROUPS =================== "

" Automatically reload .vimrc if it is change
augroup autosourcing
    autocmd!
    autocmd bufwritepost .vimrc source %
augroup END

" Auto-remove trailing spaces
autocmd BufWritePre *.php :%s/\s\+$//e

augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
augroup END

" auto switch to folder where editing file is
" disabled as it's causing trouble with tags
"autocmd BufEnter * cd %:p:h

set nopaste
set nohidden


" this will show tabs and trailing spaces
set list
set listchars=tab:>-,trail:-

" Auto indent after a {
set autoindent
set smartindent

" Linewidth to endless
set textwidth=0

" Do not wrap lines automatically
set wrap

" Restore line number and column if reentering a file after having edited it
" at least once. For this to work .viminfo in the home dir has to be writable by the user.
let g:restore_position_ignore = '.git/COMMIT_EDITMSG\|svn-commit.tmp'
au BufReadPost * call RestorePosition()

func! RestorePosition()
    if exists("g:restore_position_ignore") && match(expand("%"), g:restore_position_ignore) > -1
        return
    endif

    if line("'\"") > 1 && line("'\"") <= line("$")
        exe "normal! g`\""
    endif
endfunc


function! RunPHPUnitTest(filter)
    cd `=g:project_root`
    silent !clear
    if a:filter
        normal! T yw
        let phpunit_args = '--filter ' . @
    else
        let phpunit_args = ''
    endif
    execute "!".g:phpunit_bin ." ". phpunit_args . " " .bufname("%")
    cd -
endfunction

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set foldlevel=1
set foldlevelstart=1


" PLUGINS CONFIGURATION ===============================

" NERDTree
let NERDTreeHijackNetrw = 0

" Ag
let g:ag_prg="ag --vimgrep"
let g:ag_working_path_mode="r"                          " Start searching from the project root

" Greplace
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

" vim-php-namespace
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>

" Sort PHP use statements Alphabetically
autocmd FileType php inoremap <Leader>sna <Esc>:call PhpSortUse()<CR>
autocmd FileType php noremap <Leader>sna :call PhpSortUse()<CR>

" Sort selection by length
vmap <leader>snl ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>

" pdv - php-doc
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <leader>d :call pdv#DocumentWithSnip()<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" vim-indent-guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup = 1
" Switch black/white depending on the background type dark/light
hi IndentGuidesEven ctermbg=black

" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.swp"
      \ --ignore node_modules
      \ -g ""'

set exrc
set secure

" vim-airline
set laststatus=2
let g:airline_theme='dark'
let g:airline_powerline_fonts=1

" TIPS // MEMENTO
"
" Vim
" 'gg'  to go to the top of the file
" '``'  to go to the previous position
" 'zz'  to center vim line
" '2L'  will move to the second tab
"
" :tags
" ':ts' to see the list of tag selected
"
" :Ag
" 'go' to preview the file when Ag some pattern
"
" :Gsearch pattern
" to search and replace among multiple files
" replace on the displayed list of matches then run
" :Greplace
"
" Vim-surround
" cs'" to change surrounding ' by "
" dst to delete the surrounding tag
" ysiw] to add [] to the word where the cursor is
"
" pdv
" ,d to insert phpdoc block above the position method
