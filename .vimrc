"execute pathogen#infect()

"set nocompatible              " be iMproved, required
"filetype off                  " required
"
"" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"
"Plugin 'christoomey/vim-tmux-navigator'
"
"" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required

"call notify#emitNotification('Title', 'Body')

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" By turning on spell-checking in our ~/.vimrc, 
" we’ll be turning on word completion as well.
" The following command will let us press CTRL-N 
" or CTRL-P in insert-mode to complete the word 
" we’re typing!
"set complete+=kspell

" Search in every subdirectories
" Add all subdirectories in current location to vim-path.
set path+=.
set path+=/export/unicomplex_data/unicomplex/**
set path+=/home/thorgeir/gitlab/**
set path+=**

" Show the file/folder search result in a text bar above the search bar.
set wildmenu

let mapleader=" "

set tags =./tags,tags;
"set tags+=~/sandbox/aptlab/bank_api2.tags;
set tags+=~/sandbox/aptlab/cuckoo.tags;
set tags+=/export/unicomplex_data/unicomplex/tags;

""""""""""""""""""""""
"" MODELINE SUPPORT ""
""""""""""""""""""""""
" Enable modeline (custom vim option in file)
set modeline

"""""""""""""""""""""""
"" WINDOW MANAGEMENT ""
"""""""""""""""""""""""
set splitbelow
set splitright

" don't open folds when searching
set fdo-=search

" Create the `tags` file (may need to install ctags first)
" -f: where to save the index-file.
command! MakeTags !ctags -R -f /export/unicomplex_data/unicomplex/.bzr/tags /export/unicomplex_data/unicomplex/module
let g:toggleHighlightWhitespace = 1
function! HighlightExtraWhitespace()
    " Toggle the extra whitespace highlighting.
    " Highlight the unwanted white spaces.
    if g:toggleHighlightWhitespace == 1 "normal action, do the hi
      let g:toggleHighlightWhitespace = 0
      highlight ExtraWhitespace ctermbg=red guibg=red
      match ExtraWhitespace /\s\+$/
    else
      let g:toggleHighlightWhitespace = 1
      call clearmatches()
    endif
endfunction

" Allow me to use same keys for tmux and vim to switch between windows.
"github.com/codegangsta/dotfiles/tree/master/vim/vim/bundle/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

"function! TmuxMove(direction)
"        let wnr = winnr()
"        silent! execute 'wincmd ' . a:direction
"        " If the winnr is still the same after we moved, it is the last pane
"        if wnr == winnr()
"                call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
"        end
"endfunction
"
"nnoremap <silent> <c-h> :call TmuxMove('h')<cr>
"nnoremap <silent> <c-j> :call TmuxMove('j')<cr>
"nnoremap <silent> <c-k> :call TmuxMove('k')<cr>
"nnoremap <silent> <c-l> :call TmuxMove('l')<cr>

set backspace=indent,eol,start
set foldmethod=indent

set scrolloff=10    " N spaces between the cursor and the end of the file 
                    " and the beginning of the file
set background=dark
set tabstop=4
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
retab

set relativenumber
set autoindent
set showmatch
set wrapscan        " Default on | When searching, start at the beginning
                    " if you have reach the end of file and visa versa
set number
set ruler
set ignorecase smartcase


"
" Colorize
"
" Run :hi to list the current color scheme.
" Display current colorscheme for component.
"   :so $VIMRUNTIME/syntax/hitest.vim
" Change the color for a special key component.
"   :hi <Special key> term=standout ctermfg=21 ctermbg=168 guifg=Cyan guibg=DarkGrey

" Light blue
hi Statement ctermfg=41
hi MatchParen term=underline ctermbg=15
hi Identifier term=NONE cterm=None ctermfg=9
hi Function ctermfg=52
hi Folded cterm=underline ctermfg=80 ctermbg=168
hi Comment ctermfg=37
hi Todo cterm=underline ctermfg=80 ctermbg=168
hi Search cterm=bold,underline ctermfg=24 ctermbg=168
hi VertSplit cterm=bold ctermbg=80

hi StatusLine ctermfg=64 ctermbg=80 cterm=bold
hi StatusLineNC ctermfg=249 ctermbg=80 cterm=none

hi WildMenu cterm=underline ctermfg=6 ctermbg=Yellow

hi Visual term=reverse cterm=reverse guibg=Grey
syntax on


""""""""""""""""""""
"" CUSTOM MAPPING ""
""""""""""""""""""""

" Create TODO line for the ~/TODO.md.
" Find the latest note in the file and creates a TODO line 
" above that note.
" example output: '[ ]-20170926T1736+0000-'
nmap <F4> <ESC>O<ESC>i<Tab>[ ] - <ESC>:r !date +\%Y\%m\%dT\%H\%M\%z --utc<CR>kJA - <ESC>:noh<CR>a

" Create Title
nmap <F3> <ESC>/----------<CR>kO<ESC>:r !date +\%Y-\%m-\%d<ESC>kJo<Tab>----------<ESC>j:noh<CR><ESC><F4><ESC>o<ESC>kA

"O[ ] - <ESC>:r !date +\%Y\%m\%dT\%H\%M\%z --utc<CR>kJA - <ESC>:noh<CR>a

"au BufNewFile *.py 0r /home/thorgeir/vimtemplates/header.template
nnoremap <F5> :set list!<CR>
nnoremap <F6> :pwd<CR>:lcd %:p:h<CR>
nnoremap <F7> :set number!<CR>:set relativenumber!<CR>
"xnoremap <F8> :'<,'>w !python<CR>
xnoremap <F8> :w !python<CR>

nnoremap <F10> :setlocal spell! set spelllang=en_us<CR>


"nnoremap <F8> :!python -c @"<CR>
"nnoremap <F8> :!python `echo %`<CR>

nnoremap za za:syntax sync fromstart<CR>


" Create a dubug printing statement in python.
imap p<Tab> print('=======')<CR>print()
" Generates a fold skeleton.
nmap fold1<Tab> i#-- <CR>{{{1<CR>1}}}<ESC>kkA 
nmap fold2<Tab> i#-- <CR>{{{2<CR>2}}}<ESC>kkA 
nmap fold3<Tab> i#-- <CR>{{{3<CR>3}}}<ESC>kkA 
nmap fold4<Tab> i#-- <CR>{{{4<CR>4}}}<ESC>kkA 

nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>0 :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>9 :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

"
" STATUSLINE
"
set laststatus=2
" Show b:keymap_name in status line.
"set statusline^=%k
set statusline=
set statusline+=\ \ \ \ %f
set statusline+=%m
set statusline+=%=
set statusline+=\ %l:%c
set statusline+=\ %p%%\ \ \ \ 

"""""""""""""""""""
"" Fold settings ""
"""""""""""""""""""
if has("folding")
    set foldenable        " enable folding
    set foldmethod=indent " fold based on syntax highlighting
    set fillchars="fold:"
    "hi Folded ctermbg=168
    "hi Folded ctermfg=21
    set foldtext=FoldText()
    "function! FoldText()
    "      
    "endfunction
    function! FoldText()
      let line = getline(v:foldstart)
      if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
        let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
        let linenum = v:foldstart + 1
        while linenum < v:foldend
          let line = getline( linenum )
          let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
          if comment_content != ''
            break
          endif
          let linenum = linenum + 1
        endwhile
        let sub = initial . ' ' . comment_content
      else
        let sub = line
        let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
        if startbrace == '{'
          let line = getline(v:foldend)
          let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
          if endbrace == '}'
            let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
          endif
        endif
      endif
      let n = v:foldend - v:foldstart + 1
      let info = " " . n . " lines"
      let sub = sub . "                                                                                                                  "
      let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
      let fold_w = getwinvar( 0, '&foldcolumn' )
      let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
      return sub . info
    endfunction
endif


""""""""""""
"" EVENTS ""
""""""""""""
autocmd InsertEnter * :syntax sync fromstart

autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

"""""""""""""""
"" FUNCTIONS ""
"""""""""""""""

"""""""""""""""""""""""
" MySQL configuration "
"""""""""""""""""""""""
" Size of the window
" let g:dbext_default_buffer_lines = 40
" Notify user when MySQL query have finish
function! DBextPostResult(db_type, buf_nr)
    " If dealing with a MYSQL database
    if a:db_type == 'MYSQL'
        " Assuming the first column is an integer
        " highlight it using the WarningMsg color
        silent !notify-send -t 100 "MySQL Query Finish"
        redraw!
        "syntax sync fromstart
        "!paplay /usr/share/sounds/freedesktop/stereo/complete.oga
    endif
endfunction


" Change the default profile by write 
" in your vim (modeline) command, like so: 
"   /*dbext: profile=c3_dev_write_thorgeir*/
let g:dbext_default_profile_c3_read_thorgeir ='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/thorgeirp.txt`:host=db-read.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_write_thorgeir='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/thorgeirp.txt`:host=db-write.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_read_drone    ='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep.txt`:host=db-read.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_write_drone   ='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep.txt`:host=db-write.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_ms_read_drone   ='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep.txt`:host=c3multiscannerdb01.amadis.com:port=3306'
let g:dbext_default_profile_c3_dev_write_thorgeir='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/thorgeirp.txt`:host=c3dev-db01.amadis.com:port=3306'
let g:dbext_default_profile_c3_uni_read_drone='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep.txt`:host=10.3.18.41:port=3306'
let g:dbext_default_profile_c3_lm_drone='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep.txt`:host=c3db04.amadis.com:port=3306'
let g:dbext_default_profile_c3_lm_thorgeir='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/thorgeirp.txt`:host=c3db04.amadis.com:port=3306'

"mysql --user=apt_user --host=c4sbdb01 --password=Pr0nt0@pt
"let g:dbext_default_profile_c4_sb_read_apt_user='type=MYSQL:user=apt_user:passwd=`cat /home/thorgeir/.config/mysql/sb.txt`:host=c4sbdb01.amadis.com:port=3306'
let g:dbext_default_profile_c4_sb_read_apt_user='type=MYSQL:user=apt_user:passwd=Pr0nt0@pt:host=c4sbdb01.amadis.com:port=3306'

let g:dbext_default_profile_c3_fooze_read_drone   ='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep.txt`:host=10.3.18.41:port=3306'
let g:dbext_default_profile_c4_ipgever_write_root='type=MYSQL:user=root:host=c4ipgever01.amadis.com'
"let g:dbext_default_profile_c3_sb_write_sba_api='type=MYSQL:user=sba_api:passwd=Pr0nt0API:host=c3sandboxnursery05.amadis.com'

"let g:dbext_default_profile_c3_unimatrix_drone    ='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep.txt`:host=c3unicomplexdb01.amadis.com:port=3306'
let g:dbext_default_profile_c3_db05_read_drone='type=MYSQL:user=drone:passwd=assimilatethis:host=c3db05.amadis.com:port=3306'
let g:dbext_default_profile_c3_logdata_read_slackbot='type=MYSQL:user=slackbot:passwd=gettowork:host=c3logdatadb02.amadis.com:port=3306'
let g:dbext_default_profile_c3_db03_read_drone='type=MYSQL:user=drone:passwd=assimilatethis:host=c3db03.amadis.com:port=3306'

"
" SANDBOX
"
let g:dbext_default_profile_c3_sb_write_root='type=MYSQL:user=api_user:passwd=Pr0nt0API:host=10.3.32.80'
let g:dbext_default_profile_c3_dev_old_sb_write_api_user='type=MYSQL:user=api_user:passwd=Pr0nt0API:host=c3unicmplx13.amadis.com:port=3306'

let g:dbext_default_profile_c3_dev_sb_write_api_user='type=MYSQL:user=api_user:passwd=Pr0nt0API:host=c3sandboxnursery05.amadis.com'
let g:dbext_default_profile_c3_pro_sb_write_api_user='type=MYSQL:user=api_user:passwd=Pr0nt0API:host=c3sandboxsql01.amadis.com'

let g:dbext_default_profile = 'c3_write_thorgeir'




"let g:syntastic_always_populate_loc_list = 1
"let g:NERDTreeDirArrowExpandable = '-'
"let g:NERDTreeDirArrowCollapsible = '+'
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"map <C-t> :NERDTreeToggle<CR>



"
" NEOVIM configuration
"
":tnoremap <CSI> <C-\><C-n>
":tnoremap <M-Esc> <C-\><C-n>
"
":tnoremap <A-h> <C-\><C-n><C-w>h
":tnoremap <A-j> <C-\><C-n><C-w>j
":tnoremap <A-k> <C-\><C-n><C-w>k
":tnoremap <A-l> <C-\><C-n><C-w>l
":nnoremap <A-h> <C-w>h
":nnoremap <A-j> <C-w>j
":nnoremap <A-k> <C-w>k
":nnoremap <A-l> <C-w>l
