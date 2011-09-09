" many thanks to steve losh. his blogpost at 
" http://stevelosh.com/blog/2010/09/coming-home-to-vim
" made my vimrc be really cool.
"
" additional thanks to drew neil from vimcasts.org for additional stuff
set nocompatible " don't be Vi.

let mapleader="," " , is easy to type on the neo2 keyboard layout

"
"" pathogen bundle support
"
" put your vim stuff into ~/.vim/bundle/name/ and everything's nice and tidy.
"
filetype off " when file types are on before pathogen is loaded, things explode
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on " but we still want ftplugins and ftindent!

set encoding=utf-8 " UTF-8 is my default text encoding.
set scrolloff=3 " if possible, don't move the cursor to within 3 lines of window edges
set autoindent " please indent for us!
set hidden
set wildmenu " zsh-like tab completion list menus, yay!
set wildmode=list:longest
set cursorline " show the line the cursor is on with highlighting (usually an underline)
set ruler " display line numbers at the left side of the buffer
set backspace=indent,eol,start " make backspace behave nicely.
set laststatus=2 " always display a status line for the last window
" set relativenumber " display relative line numbers instead of absolute

"
"" searching
"
set smartcase " uppercase matches uppercase, lowercase matches any case
set gdefault " automatically replace globally. use /g at the end to turn off.
set incsearch " search while typing
set hlsearch " highlight search results
set showmatch " briefly jump to matching bracket pairs, if they are visible.

" don't use vims own regex syntax.
nnoremap / /\v
vnoremap / /\v

" key binding to clear highlighted searches
nnoremap <leader><space> :noh<cr>

" move screen lines rather than file lines in normal mode
nnoremap <down> gj
nnoremap <up> gk
" don't move the cursor in insert mode.
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <leader>pv :!iki_preview.sh %<cr>

"
"" important note
"
" I use the neo2 keyboard layout, which has arrow-keys on the home row.
" Thus I am not ashamed to use the arrow keys in vim for navigation.

" display a vertical line at 85 characters
set colorcolumn=85

" ever hit f1 while trying to hit escape? probably.
" ever hit f1 while trying to get the vim help? probably not.
" yeah.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>


" 88/256 color terminals make things beautiful.
set t_Co=256
colorscheme molokai_sjl

" Show trailing whitepace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

" this will probably be replaced by "do-indentation-right" plugin soon.
set tabstop=4
set shiftwidth=4
set et

" syntax highlighting! oh my god, this is the most important thing ever.
syn on
" we do have a mouse and sometimes it's nice to be able to use it
" especially since it's a nipple mouse on our home row.
set mouse=a

" beautifully display tabs and trailing spaces
set listchars=tab:»\ ,trail:·
set list

" leave insert mode with ctrl-d
imap <C-d> <Esc>

" something for ctags or something.
let g:ctags_statusline=1

" open the scratchpad (from the scratchpad vim plugin) with ,s
nnoremap <leader>s :ScratchOpen<cr>i
" open the nerdtree with ,ls
nnoremap <leader>ls :NERDTree<cr>
" open a prompt for Ack with ,a
nnoremap <leader>a :Ack 

" ignore several kinds of files for wildcard filename expansion
" (also important for the command-T plugin)
set wildignore+=*.o,*.pyc,*.pyo,.git,.hg,.svn,lib/**

set directory^=$HOME/.vim/swapfile//   "put all swap files together in one place

set undofile " create an undo file for persistent undo
set undodir^=$HOME/.vim/undofile//

set formatprg=par\ -w75

"set spell " I'm a horrible speller.

fu! CustomFoldText() "{{{

    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank( 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = getline(fs)
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strlen(foldSizeStr) - strlen(line) - strlen(foldLevelStr) - strlen(foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf "}}}

set foldtext=CustomFoldText()

let g:Gitv_OpenHorizontal=0
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview


" Jump to the definition of whatever the cursor is on
map <leader>j :RopeGotoDefinition<CR>

" Rename whatever the cursor is on (including references to it)
map <leader>r :RopeRename<CR>


" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Don't let pyflakes use the quickfix window
let g:pyflakes_use_quickfix = 0

au BufRead,BufNewFile *.py nnoremap <buffer><CR> :nohlsearch\|:call PressedEnter()<cr>
nnoremap <buffer><CR> :nohlsearch\|:call PressedEnter()<cr>

nnoremap <leader>u :TlistToggle<CR>

" update after 500 miliseconds of no cursor movement, rather than
" 4 seconds (for taglist etc.)
set updatetime=500
