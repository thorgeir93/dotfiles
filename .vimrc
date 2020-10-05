filetype off

execute pathogen#infect() 
" call pathogen#helptags()

let g:pymode_options_colorcolumn = 0

" Disable ":lopen" option like pylint.
let g:pymode_lint_cwindow = 0

filetype plugin indent on

" ALE - PYLINT options
" Run linters only when I save files
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

set paste

" Search in every subdirectories
" Add all subdirectories in current location to vim-path.
set path+=.
set path+=**
set path+=/export/unicomplex_data/unicomplex/module/python/**

" Show the file/folder search result in a text bar above the search bar.
set wildmenu

" change the current working directory whenever you
" open a file, switch buffers, delete a buffer or open/close a window.
set autochdir

set tags =./tags,tags;

""""""""""""""""""""""
"" MODELINE SUPPORT ""
""""""""""""""""""""""
" Enable modeline
" Allow you to add custom vim options in file e.g.
"       # vim: set expandtab:
set modeline

"""""""""""""""""""""""
"" WINDOW MANAGEMENT ""
"""""""""""""""""""""""
set splitbelow
set splitright

"""
" NETRW
"""
" Same as if you tab `i` letter three times in netrw view.
let g:netrw_liststyle = 3

" Removing the banner
let g:netrw_banner = 0

" Set the width of the directory explorer

" open files in a new vertical split
let g:netrw_browse_split = 2

" Preview in vertical
let g:netrw_preview   = 1
let g:netrw_winsize   = 75

" Vertical split
let g:netrw_altv = 1






" don't open folds when searching
set fdo-=search

set backspace=indent,eol,start

" The kind of folding used. Possible values:
"   expr, manual, indent, marker, syntax, diff  
set foldmethod=indent

" N spaces between the cursor and the end of the file 
" and the beginning of the file
set scrolloff=10    

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

""""""""""""""""""""""""""""""""""""""""
"" REMEMBER WHICH CODE YOU HAD FOLDED ""
""""""""""""""""""""""""""""""""""""""""
" TODO only do this for sql files
" TODO Add sql syntax to .sql files.
" TODO Set manual foldmethod only on sql files.
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END


"
" Colorize
"
" Run :hi to list the current color scheme.
" Display current colorscheme for component.
"   :so $VIMRUNTIME/syntax/hitest.vim
" Change the color for a special key component.
"   :hi <Special key> term=standout ctermfg=21 ctermbg=168 \
"   guifg=Cyan guibg=DarkGrey

" Light blue
hi Statement ctermfg=41
hi MatchParen term=underline ctermbg=15
hi Identifier term=NONE cterm=None ctermfg=9
hi Function ctermfg=52
hi Folded cterm=underline ctermfg=80 ctermbg=168
hi Comment ctermfg=37
hi Todo cterm=underline ctermfg=80 ctermbg=168
hi Search cterm=bold,underline ctermfg=24 ctermbg=168
hi VertSplit cterm=bold ctermbg=80 ctermfg=80
"hi VertSplit term=reverse cterm=bold ctermbg=80 gui=reverse 

hi StatusLine ctermfg=12 ctermbg=80 cterm=bold
hi StatusLineNC ctermfg=11 ctermbg=80 cterm=none
"hi StatusLine term=reverse ctermfg=64 ctermbg=80 gui=reverse "hi StatusLineNC term=reverse ctermfg=64 ctermbg=80 gui=reverse

hi StatusLineTerm term=bold ctermfg=80 guifg=Cyan
hi StatusLineTermNC term=bold ctermfg=80 guifg=Cyan 
hi Terminal ctermfg=24 ctermbg=16

hi WildMenu cterm=bold ctermfg=14 ctermbg=16

hi Visual term=reverse cterm=reverse guibg=Grey

hi TabLineFill cterm=none ctermfg=64 ctermbg=80
hi TabLineSel cterm=none ctermfg=12 ctermbg=16
hi TabLine cterm=none ctermfg=12 ctermbg=80

hi Error term=reverse ctermfg=2 ctermbg=4
"hi Error term=None
syntax on

""""""""""""""""""""""
"" TERMINAL OPTIONS ""
""""""""""""""""""""""
" :terminal++rows=30 #for fixed size.
" Split vertical
" :vert ter
" set termwinscroll=90000
if has('terminal')
    set termwinscroll=90000
endif

""""""""""""""""""""
"" CUSTOM MAPPING ""
""""""""""""""""""""
" Create TODO line for the ~/TODO.md.
" Find the latest note in the file and creates a TODO line 
" above that note.
" example output: '[ ]-20170926T1736+0000-'

let g:TODO_START = "*"
let g:TODO_DONE = "x"
let g:TODO_BLOCK= " "

function! GetInsideBracket()
  " Return the character(s) in the brackets in the beginning of the line.
  execute "normal mx0t]yi]`x"
  return @"
endfunction

function! ChangeInsideBracket(symbol)
  " Replace the string in the brackets with the given symbol.
  execute "normal mx0t]r" . a:symbol . "`x"
endfunction

" Change:
" '[ ]-20170926T1736+0000-' 
" To:
" '[x]-20170926T1736+0000-' 
" And the otherway arround.
function! Todo_change(symbol)
  " Delete what is inside the brackets
  " [ ] - ... becomes [] or
  " [x] - ... becomes []
  call ChangeInsideBracket(a:symbol)

  " Assign the last copied string to variable
  " (what is inside in the brackets)
  ""let l:bracket_string = GetInsideBracket()

  ""if l:bracket_string == "x"
  ""  call ChangeInsideBracket(" ")
  ""else
  ""  call ChangeInsideBracket("x")
  ""endif

  ""execute "normal `x"
endfunction

"function! todo_start()
"  execute "normal


"function! CreateTODO()
"    execute "normal O<ESC>i<Tab>[ ] - <ESC>"
"    execute "normal :r !date +\%Y\%m\%dT\%H\%M\%z --utc<CR>"
"    execute "normal kJA -  <ESC>:noh<CR>a"
"endfunction


"nmap <F4> <ESC>O<ESC>i<Tab>[ ] - <ESC>:r !date +\%Y\%m\%dT\%H\%M\%z --utc<CR>kJA -  <ESC>:noh<CR>a
"nmap <F4> <ESC>O<ESC>i<Tab>[ ] - <ESC>:r !date +\%Y\%m\%dT\%H\%M\%z --utc<CR>kJA -  <ESC>:noh<CR>a


" Create Title
nmap <F2> <ESC>O<ESC>i  [ ]<ESC>:r!date +\%Y\%m\%dT\%H\%M --utc<CR>kJxA: <ESC>:noh<CR>a
nmap <F3> :call Todo_change(g:TODO_START)<CR>
"nmap <F4> :call Todo_change(g:TODO_BLOCK)<CR>
nmap <F5> :call Todo_change(g:TODO_DONE)<CR>A (<ESC>:r !date +\%H\%M --utc<CR>kJxA)<ESC>
nmap <F6> <ESC>?.*\S.*\n<CR>jjO<ESC>:r !date +\%Y-\%m-\%d<ESC>kJo<Tab>----------<ESC>j:noh<CR><ESC><F2><ESC>o<ESC>kA
nnoremap <F7> :set number!<CR>:set relativenumber!<CR>
xnoremap <F8> :w !python<CR>
nnoremap <F9> :set list!<CR>

nnoremap <F10> :setlocal spell! set spelllang=en_us<CR>

nnoremap za za:syntax sync fromstart<CR>

" Create a dubug printing statement in python.
imap p<Tab> print('=======')<CR>print()
imap j<Tab> print(json.dumps(, indent=3, default=str))

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
" ctrl-s | Saving changes
"
" Copy from 
" vim.fandom.com/wiki/Map_Ctrl-S_to_save_current_or_new_files
" ----
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command! -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>
"inoremap <C-S> <C-O>:Update<CR>
"noremap <silent> <C-S> :update<CR>
"vnoremap <silent> <C-S> <C-C>:update<CR>
"inoremap <silent> <C-S> <C-O>:update<CR>



"
" STATUSLINE
"
set laststatus=2
set statusline=
set statusline+=\ \ \ \ %f
set statusline+=%m
set statusline+=%=
set statusline+=\ %l:%c
set statusline+=\ %p%%\ \ \ \ 

""""""""""""
"" EVENTS ""
""""""""""""
autocmd InsertEnter * :syntax sync fromstart

autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
" Higlight the lines that are equal or more than 80 columns with the same color scheme as the comment scheme!
augroup vimrc_autocmds
    "autocmd BufEnter * highlight ColorColumn term=reverse ctermfg=64 ctermbg=80
    autocmd BufEnter * highlight ColorColumn term=standout ctermfg=14 ctermbg=242
    autocmd BufEnter *.py match ColorColumn /\%80v.*/
    "autocmd TerminalOpen * 
augroup END

"""""""""""""""
"" FUNCTIONS ""
"""""""""""""""

function! DisplayRegisters()
    for c in range(0, 9)
        echo system('echo ' . c . ': ' . shellescape(getreg(c)))
    endfor

    for c in range(0, 25)
        let char = nr2char(c + char2nr("a"))
        echo system('echo ' . char . ': ' . shellescape(getreg(char)))
    endfor
endfunction
" You can use https://vim.fandom.com/wiki/Have_Vim_check_automatically_if_the_file_has_changed_externally
" to get ideas.
function! Test()
    echo system('rm /tmp/vim.registers')
    redir > /tmp/vim.registers | silent call DisplayRegisters() | redir END
endfunction

fun! AutoreadPython()
python << EOF
import time, vim
try: import thread
except ImportError: import _thread as thread # Py3

def autoread():
    vim.command('checktime')  # Run the 'checktime' command
    vim.command('redraw')     # Actually update the display

#def update_registers(filepath):
#    registers = {}
#    for number in range(0, 9):
#        registers[number] = (
#            vim.command('shellescape(getreg({char}))'.format(char=number))
#        )
#
#    with open(filepath, 'w') as file_handler:
#        file_handler.writeline(registers[1])

def autoread_loop():
    while True:
        time.sleep(1)
        autoread()
        #update_registers('/tmp/vim.registers')

thread.start_new_thread(autoread_loop, ())
EOF
endfun

"call Test()





"""""""""""""""""""""""
" MySQL configuration "
"""""""""""""""""""""""
" Size of the window
" let g:dbext_default_buffer_lines = 40
" Notify user when MySQL query have finish
function! DBextPostResult(db_type, buf_nr)
    " If dealing with a MYSQL database
    if a:db_type == 'MYSQL'

        " Make windows Equal Size
        wincmd =
        "" Bind horizontal scrolling for 'scrollbind' windows.
        "" (default: ver,jump)
        "set scrollopt=hor

        "" Bind buffers (lock them toogether)
        "set scrollbind

        "" Split the current buffer with height 3xrow
        "3split

        "" Lock the window height.
        "set winfixheight

        "" Your position is in the splitted window.
        "" Delete the unnecessary information at the top
        "" by deleting the next two lines.
        "execute "normal dj"
    endif
endfunction


"let g:dbext_default_buffer_lines=40
let g:dbext_default_buffer_lines = 60

" If you want each buffer to have its OWN Result buffer, you can define:
"let g:dbext_default_use_sep_result_buffer = 1 " (default=0)

" When the command is run, the results are displayed in the Result
" buffer, setting display_cmd_line = 1, will also display the command
" that was run to generate the output.  Useful for debugging.
"let g:dbext_default_display_cmd_line = 1


" Change the default profile by write 
" in your vim (modeline) command, like so: 
"   /*dbext: profile=c3_dev_write_thorgeir*/
let g:dbext_default_profile_c3_read_thorgeir ='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/thorgeirp.txt`:host=db-read.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_write_thorgeir='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/thorgeirp.txt`:host=db-write.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_read_drone    ='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep`:host=db-read.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_write_drone   ='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep`:host=db-write.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_ms_read_drone   ='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep`:host=c3multiscannerdb01.amadis.com:port=3306'
let g:dbext_default_profile_c3_dev_write_thorgeir='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/thorgeirp.txt`:host=c3dev-db01.amadis.com:port=3306'
let g:dbext_default_profile_c3_uni_read_drone='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep`:host=10.3.18.41:port=3306'
let g:dbext_default_profile_c3_lm_drone='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep`:host=c3db04.amadis.com:port=3306'
let g:dbext_default_profile_c3_lm_read_drone='type=MYSQL:user=drone:passwd=assimilatethis:host=10.3.18.32:port=3306'
let g:dbext_default_profile_c3_lm_thorgeir='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/thorgeirp.txt`:host=c3db04.amadis.com:port=3306'

"mysql --user=apt_user --host=c4sbdb01 --password=Pr0nt0@pt
"let g:dbext_default_profile_c4_sb_read_apt_user='type=MYSQL:user=apt_user:passwd=`cat /home/thorgeir/.config/mysql/sb.txt`:host=c4sbdb01.amadis.com:port=3306'
let g:dbext_default_profile_c4_sb_read_apt_user='type=MYSQL:user=apt_user:passwd=Pr0nt0@pt:host=c4sbdb01.amadis.com:port=3306'

let g:dbext_default_profile_c3_fooze_read_drone   ='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep`:host=10.3.18.41:port=3306'
let g:dbext_default_profile_c4_ipgever_write_root='type=MYSQL:user=root:host=c4ipgever01.amadis.com'
"let g:dbext_default_profile_c3_sb_write_sba_api='type=MYSQL:user=sba_api:passwd=Pr0nt0API:host=c3sandboxnursery05.amadis.com'

"let g:dbext_default_profile_c3_unimatrix_drone    ='type=MYSQL:user=drone:passwd=`cat /home/thorgeir/.config/mysql/dronep`:host=c3unicomplexdb01.amadis.com:port=3306'
let g:dbext_default_profile_c3_db05_read_drone='type=MYSQL:user=drone:passwd=assimilatethis:host=c3db05.amadis.com:port=3306'
let g:dbext_default_profile_c3_logdata_read_slackbot='type=MYSQL:user=slackbot:passwd=gettowork:host=c3logdatadb02.amadis.com:port=3306'
let g:dbext_default_profile_c3_db03_read_drone='type=MYSQL:user=drone:passwd=assimilatethis:host=c3db03.amadis.com:port=3306'
let g:dbext_default_profile_c3_sb_write_root='type=MYSQL:user=api_user:passwd=Pr0nt0API:host=10.3.32.80'

let g:dbext_default_profile_c3_yara_read_drone='type=MYSQL:user=drone:passwd=assimilatethis:host=c3yaradb01.amadis.com'

"
" SANDBOX
"
let g:dbext_default_profile_c3_sb_write_root='type=MYSQL:user=api_user:passwd=Pr0nt0API:host=10.3.32.80'
let g:dbext_default_profile_c3_dev_old_sb_write_api_user='type=MYSQL:user=api_user:passwd=Pr0nt0API:host=c3unicmplx13.amadis.com:port=3306'

let g:dbext_default_profile_c3_dev_sb_write_apt_user='type=MYSQL:user=apt_user:passwd=Pr0nt0@pt:host=c3sandboxnursery05.amadis.com'
let g:dbext_default_profile_c3_dev_sb_write_api_user='type=MYSQL:user=api_user:passwd=Pr0nt0API:host=c3sandboxnursery05.amadis.com'
" let g:dbext_default_profile_c3_pro_sb_write_api_user='type=MYSQL:user=api_user:passwd=Pr0nt0API:host=c3sandboxsql01.amadis.com'
let g:dbext_default_profile_c3_pro_sb_write_api_user='type=MYSQL:user=api_user:passwd=Pr0nt0API:host=production-sandboxsql-ash1-001.threatlab.ash1.cynet'


" Berlin
let g:dbext_default_profile_ber1_pro_sb_write_api_user='type=MYSQL:user=api_user:passwd=Pr0nt0API:host=production-av-mysql-sandbox-ber1-001.ber1.cynet'

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

if exists("g:loaded_tmux_navigator") || &cp || v:version < 700
  finish
endif
let g:loaded_tmux_navigator = 1

function! s:VimNavigate(direction)
  try
    execute 'wincmd ' . a:direction
  catch
    echohl ErrorMsg | echo 'E11: Invalid in command-line window; <CR> executes, CTRL-C quits: wincmd k' | echohl None
  endtry
endfunction

if !get(g:, 'tmux_navigator_no_mappings', 0)
  nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
endif

if empty($TMUX)
  command! TmuxNavigateLeft call s:VimNavigate('h')
  command! TmuxNavigateDown call s:VimNavigate('j')
  command! TmuxNavigateUp call s:VimNavigate('k')
  command! TmuxNavigateRight call s:VimNavigate('l')
  command! TmuxNavigatePrevious call s:VimNavigate('p')
  finish
endif

command! TmuxNavigateLeft call s:TmuxAwareNavigate('h')
command! TmuxNavigateDown call s:TmuxAwareNavigate('j')
command! TmuxNavigateUp call s:TmuxAwareNavigate('k')
command! TmuxNavigateRight call s:TmuxAwareNavigate('l')
command! TmuxNavigatePrevious call s:TmuxAwareNavigate('p')

if !exists("g:tmux_navigator_save_on_switch")
  let g:tmux_navigator_save_on_switch = 0
endif

if !exists("g:tmux_navigator_disable_when_zoomed")
  let g:tmux_navigator_disable_when_zoomed = 0
endif

function! s:TmuxOrTmateExecutable()
  return (match($TMUX, 'tmate') != -1 ? 'tmate' : 'tmux')
endfunction

function! s:TmuxVimPaneIsZoomed()
  return s:TmuxCommand("display-message -p '#{window_zoomed_flag}'") == 1
endfunction

function! s:TmuxSocket()
  " The socket path is the first value in the comma-separated list of $TMUX.
  return split($TMUX, ',')[0]
endfunction

function! s:TmuxCommand(args)
  let cmd = s:TmuxOrTmateExecutable() . ' -S ' . s:TmuxSocket() . ' ' . a:args
  return system(cmd)
endfunction

function! s:TmuxPaneCurrentCommand()
  echo s:TmuxCommand("display-message -p '#{pane_current_command}'")
endfunction
command! TmuxPaneCurrentCommand call s:TmuxPaneCurrentCommand()

let s:tmux_is_last_pane = 0
augroup tmux_navigator
  au!
  autocmd WinEnter * let s:tmux_is_last_pane = 0
augroup END

function! s:NeedsVitalityRedraw()
  return exists('g:loaded_vitality') && v:version < 704 && !has("patch481")
endfunction

function! s:ShouldForwardNavigationBackToTmux(tmux_last_pane, at_tab_page_edge)
  if g:tmux_navigator_disable_when_zoomed && s:TmuxVimPaneIsZoomed()
    return 0
  endif
  return a:tmux_last_pane || a:at_tab_page_edge
endfunction

function! s:TmuxAwareNavigate(direction)
  let nr = winnr()
  let tmux_last_pane = (a:direction == 'p' && s:tmux_is_last_pane)
  if !tmux_last_pane
    call s:VimNavigate(a:direction)
  endif
  let at_tab_page_edge = (nr == winnr())
  " Forward the switch panes command to tmux if:
  " a) we're toggling between the last tmux pane;
  " b) we tried switching windows in vim but it didn't have effect.
  if s:ShouldForwardNavigationBackToTmux(tmux_last_pane, at_tab_page_edge)
    if g:tmux_navigator_save_on_switch == 1
      try
        update " save the active buffer. See :help update
      catch /^Vim\%((\a\+)\)\=:E32/ " catches the no file name error
      endtry
    elseif g:tmux_navigator_save_on_switch == 2
      try
        wall " save all the buffers. See :help wall
      catch /^Vim\%((\a\+)\)\=:E141/ " catches the no file name error
      endtry
    endif
    let args = 'select-pane -t ' . shellescape($TMUX_PANE) . ' -' . tr(a:direction, 'phjkl', 'lLDUR')
    silent call s:TmuxCommand(args)
    if s:NeedsVitalityRedraw()
      redraw!
    endif
    let s:tmux_is_last_pane = 1
  else
    let s:tmux_is_last_pane = 0
  endif
endfunction
