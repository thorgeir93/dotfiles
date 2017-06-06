execute pathogen#infect()

"call notify#emitNotification('Title', 'Body')

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let mapleader=" "

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

"nnoremap <c-j> <c-w>j<CR>
"nnoremap <c-k> <c-w>k<CR>
"nnoremap <c-l> <c-w>l<CR>
"nnoremap <c-h> <c-w>h<CR>
"
" Add all subdirectories in current location to vim-path.
set path+=** 

" Show the search result in vim.
set wildmenu

" don't open folds when searching
set fdo-=search

" Create the `tags` file (may need to install ctags first)
" -f: where to save the index-file.
command! MakeTags !ctags -R -f /export/unicomplex_data/unicomplex/.bzr/tags /export/unicomplex_data/unicomplex/module

" Allow me to use same keys for tmux and vim to switch between windows.
"github.com/codegangsta/dotfiles/tree/master/vim/vim/bundle/vim-tmux-navigator
"let g:tmux_navigator_no_mappings = 1
"nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
"nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
"nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
"nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
"nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
"
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

""""""""""""""""""""
"" CUSTOM MAPPING ""
""""""""""""""""""""
"au BufNewFile *.py 0r /home/thorgeir/vimtemplates/header.template
nnoremap <F5> :set list!<CR>
nnoremap <F6> :pwd<CR>:lcd %:p:h<CR>
nnoremap <F7> :set number!<CR>:set relativenumber!<CR>

nnoremap za za:syntax sync fromstart<CR>

" Create a dubug printing statement in python.
imap p<Tab> print('=======')<CR>print()

nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>0 :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>9 :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

""" colors
hi Visual term=reverse cterm=reverse guibg=Grey
hi Folded ctermbg=168
syntax on

"
" STATUSLINE
"
" Show b:keymap_name in status line.
" set statusline^=%k
"hi StatusLine ctermbg=White cterm=Bold ctermfg=Black
"hi StatusLineNC ctermbg=White cterm=Italic ctermfg=Black
"hi StatusLine ctermbg=DarkRed
"hi StatusLineNC ctermbg=Gray
"hi StatusLineNC cterm=Italic


""""""""""""
"" EVENTS ""
""""""""""""
autocmd InsertEnter * :syntax sync fromstart

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
