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

map <C-k> :wincmd k<CR>
map <C-j> :wincmd j<CR>
map <C-h> :wincmd h<CR>
map <C-l> >:wincmd l<CR>

set backspace=indent,eol,start

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
nnoremap <leader><leader> :w<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap za za:syntax sync fromstart<CR>

" +/- resize the with
" Leader and +/- resize the height
"if bufwinnr(1)
"    map + <C-W>>
"    map - <C-W><
"    map <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
"    map <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
"endif

nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>0 :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>9 :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

"map <leader> viwy

""" colors """
hi Folded ctermbg=168
syntax on


" Set following to show "<CAPS>" in the status line when "Caps Lock" is on.
"let b:keymap_name = "CAPS"
"
" Show b:keymap_name in status line.
" set statusline^=%k

"hi StatusLine ctermbg=White cterm=Bold ctermfg=Black
"hi StatusLineNC ctermbg=White cterm=Italic ctermfg=Black

hi StatusLine ctermbg=DarkRed
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
