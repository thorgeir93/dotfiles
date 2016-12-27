execute pathogen#infect()

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
set showmatch
set ruler
set tw=79 " width of document (used by gd)
set relativenumber

set background=dark
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
set ts=4
set sw=4

set wrapscan
set autoindent
set number
set tabstop=4
set expandtab
retab


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

"map <leader> viwy

""" colors """
hi Folded ctermbg=168
syntax on


" Set following to show "<CAPS>" in the status line when "Caps Lock" is on.
"let b:keymap_name = "CAPS"
"
" Show b:keymap_name in status line.
set statusline^=%k


""""""""""""
"" EVENTS ""
""""""""""""
autocmd InsertEnter * :syntax sync fromstart


"""""""""""""""
"" FUNCTIONS ""
"""""""""""""""
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

":call MoveToNextTab()<CR>
nnoremap <C-m> :call MoveToNextTab()<CR>
nnoremap <C-n> :call MoveToPrevTab()<CR>


"""""""""""""""""""""""
" MySQL configuration "
"""""""""""""""""""""""
" Change the default profile by write 
" in your vim (modeline) command, like so: 
"   /*dbext: profile=c3_dev_write_thorgeir*/
let g:dbext_default_profile_c3_read_thorgeir ='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/thorgeirp.txt`:host=db-read.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_write_thorgeir='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/thorgeirp.txt`:host=db-write.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_read_drone    ='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/dronep.txt`:host=db-read.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_write_drone   ='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/dronep.txt`:host=db-write.c3.amadis.com:port=3306'
let g:dbext_default_profile_c3_dev_write_thorgeir='type=MYSQL:user=thorgeir:passwd=`cat /home/thorgeir/.config/mysql/thorgeirp.txt`:host=c3dev-db01.amadis.com:port=3306'
let g:dbext_default_profile = 'c3_write_thorgeir'




"let g:syntastic_always_populate_loc_list = 1
"let g:NERDTreeDirArrowExpandable = '-'
"let g:NERDTreeDirArrowCollapsible = '+'
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"map <C-t> :NERDTreeToggle<CR>
