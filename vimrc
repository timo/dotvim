" vi: foldmethod=marker
" many thanks to steve losh. his blogpost at 
" http://stevelosh.com/blog/2010/09/coming-home-to-vim
" made my vimrc be really cool.
"
" additional thanks to drew neil from vimcasts.org for additional stuff
set nocompatible " don't be Vi.

let mapleader="," " , is easy to type on the neo2 keyboard layout

set shell=/bin/sh " if we use fish, things are not going to work.

"
"" pathogen bundle support
"
" put your vim stuff into ~/.vim/bundle/name/ and everything's nice and tidy.
"
filetype off " when file types are on before pathogen is loaded, things explode
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on " but we still want ftplugins and ftindent!

set encoding=utf8 " UTF-8 is my default text encoding.
set scrolloff=3 " if possible, don't move the cursor to within 3 lines of window edges
set autoindent " please indent for us!
set hidden
set wildmenu " zsh-like tab completion list menus, yay!
set wildmode=list:longest
"set cursorline " show the line the cursor is on with highlighting (usually an underline)
"set cursorcolumn " show the column the cursor is on
"set ruler " display line numbers at the left side of the buffer
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
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

nnoremap <leader>pv :!iki_preview.sh %<cr>

"
"" important note
"
" I use the neo2 keyboard layout, which has arrow-keys on the home row.
" Thus I am not ashamed to use the arrow keys in vim for navigation.

" display a vertical line at 85 characters
"set colorcolumn=85

" ever hit f1 while trying to hit escape? probably.
" ever hit f1 while trying to get the vim help? probably not.
" yeah.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" splits now put the active window on the right side rather than the left.
" feels more natural to me.
set splitright

" 88/256 color terminals make things beautiful.
set t_Co=256
colorscheme distinguished

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
set listchars=tab:¬\ ,trail:·
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
nnoremap <leader>a :Ack ""<LEFT>
" use ack to immediately search for the word under the cursor
nnoremap <leader>A :Ack ""<LEFT><C-R><C-W><RIGHT><CR>

" ignore several kinds of files for wildcard filename expansion
" (also important for the command-T plugin)
set wildignore+=*.o,*.pyc,*.pyo,.git,.hg,.svn,.tox

set directory^=$HOME/.vim/swapfile//   "put all swap files together in one place

set undofile " create an undo file for persistent undo
set undodir^=$HOME/.vim/undofile//

set history=100

set formatprg=par\ -w75

"set spell " I'm a horrible speller.

"fu! CustomFoldText() "{{{

    ""get first non-blank line
    "let fs = v:foldstart
    "while getline(fs) =~ '^\s*$' | let fs = nextnonblank( 1)
    "endwhile
    "if fs > v:foldend
        "let line = getline(v:foldstart)
    "else
        "let line = getline(fs)
    "endif

    "let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    "let foldSize = v:foldend - v:foldstart
    "let foldSizeStr = " " . foldSize . " lines "
    "let foldLevelStr = repeat("+--", v:foldlevel)
    "let lineCount = line("$")
    "let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    "let expansionString = repeat(".", w - strlen(foldSizeStr) - strlen(line) - strlen(foldLevelStr) - strlen(foldPercentage))
    "return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
"endf "}}}

"set foldtext=CustomFoldText()

let g:Gitv_OpenHorizontal=0
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview


" Jump to the definition of whatever the cursor is on
map <leader>j :RopeGotoDefinition<CR>

" Rename whatever the cursor is on (including references to it)
map <leader>r :RopeRename<CR>


" close preview window automatically when we move around
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Don't let pyflakes use the quickfix window
let g:pyflakes_use_quickfix = 0

au BufRead,BufNewFile *.py nnoremap <buffer><CR> :nohlsearch<cr>
nnoremap <buffer><CR> :nohlsearch<cr>

nnoremap <leader>u :TlistToggle<CR>

" when opening ctrlp, go up the file system until .git or similar is found
let g:ctrlp_working_path_mode = 2

nnoremap <leader>gv :Gitv --all<cr>
nnoremap <leader>gV :Gitv! --all<cr>
vnoremap <leader>gV :Gitv! --all<cr>

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gD :Gdiff HEAD<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gb :Gblame<cr>

nnoremap <leader>gw :w<cr>:Gwrite<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gW :w<cr>:Gwrite<cr>:Gstatus<cr>
nnoremap <leader>ge :Gedit<cr>

nnoremap <leader>p6 :set ft=perl6<cr>

let g:Powerline_symbols = 'fancy'

" jedi autocomplete configuration

let g:jedi#goto_command = '<leader>G'

" haskellmode stuff

au BufEnter *.hs compiler ghc
let g:haddock_browser="/usr/bin/chromium"
let g:ghc="/usr/bin/ghc-7.4.1"

" update after 500 miliseconds of no cursor movement, rather than
" 4 seconds (for taglist etc.)
set updatetime=500

au BufRead,BufNewFile tmpmsg.* set filetype=mail

" Block Colors {{{

let g:blockcolor_state = 0
function! BlockColor() " {{{
    if g:blockcolor_state
        let g:blockcolor_state = 0
        call matchdelete(77881)
        call matchdelete(77882)
        call matchdelete(77883)
        call matchdelete(77884)
        call matchdelete(77885)
        call matchdelete(77886)
    else
        let g:blockcolor_state = 1
        call matchadd("BlockColor1", '^ \{4}.*', 1, 77881)
        call matchadd("BlockColor2", '^ \{8}.*', 2, 77882)
        call matchadd("BlockColor3", '^ \{12}.*', 3, 77883)
        call matchadd("BlockColor4", '^ \{16}.*', 4, 77884)
        call matchadd("BlockColor5", '^ \{20}.*', 5, 77885)
        call matchadd("BlockColor6", '^ \{24}.*', 6, 77886)
    endif
endfunction " }}}
" Default highlights {{{
hi def BlockColor1 guibg=#222222 ctermbg=234
hi def BlockColor2 guibg=#2a2a2a ctermbg=235
hi def BlockColor3 guibg=#353535 ctermbg=236
hi def BlockColor4 guibg=#3d3d3d ctermbg=237
hi def BlockColor5 guibg=#444444 ctermbg=238
hi def BlockColor6 guibg=#4a4a4a ctermbg=239
" }}}
nnoremap <leader>B :call BlockColor()<cr>

" }}}
" Highlight Word {{{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction " }}}

" Mappings {{{

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" }}}
" Default Highlights {{{

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}

" }}}
