"execute pathogen#infect()

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*


let g:syntastic_always_populate_loc_list = 1
"let g:NERDTreeDirArrowExpandable = '-'
"let g:NERDTreeDirArrowCollapsible = '+'
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


map <C-t> :NERDTreeToggle<CR>

"map <silent> <C-UP>
"nnoremap 
map <C-k> :wincmd k<CR>
map <C-j> :wincmd j<CR>
map <C-h> :wincmd h<CR>
map <C-l> >:wincmd l<CR>

"map <A-w> <C-w> 

"map <A-DOWN> :wincmd j<CR>
"map <A-UP> :wincmd k<CR>
"map <A-RIGHT> :wincmd l<CR>
"map <A-LEFT> :wincmd h<CR>

"nnoremap <silent> <C-DOWN> <C-W><C-J>
"nnoremap <silent> <C-UP> <C-W><C-K>
"nnoremap <silent> <C-RIGHT> <C-W><C-L>
"nnoremap <silent> <C-LEFT> <C-W><C-H>

""""""""""""""""""""
"" CUSTOM MAPPING ""
""""""""""""""""""""
" This is a strange hax!
" U have to do "nnor.. <ESC>.. ..."
" To use ALT key
" explaine: http://unix.stackexchange.com/questions/199683/alt-mappings-for-vim-in-urxvt
"nnoremap <ESC><A-Left> :noh<CR> 
"map <M-Left> :wq<CR>
"map <C><Left> :wq<CR>
map <C-A-f> :%s/././g 
"map <ESC>[Od <C-Left>
"map <C-Left> :wq<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

map <space> viwy
"set nocompatible
"set t_Co=16
"call pathogen#infect()
"syntax on
"set background=dark " dark | light "
"colorscheme solarized
"filetype plugin on

"set t_Co=16
syntax on
"set t_Co=256
"let g:solarized_termcolors=16
"let g:solarized_termcolors=256
let g:solarized_termtrans = 1
set background=dark
"colorscheme solarized

set number
set tabstop=4
set expandtab
retab

""""""""""""""""
" HIGHLIGHTING "
""""""""""""""""
hi Visual term=reverse cterm=reverse guibg=Grey
hi Folded term=standout ctermfg=darkblue ctermbg=black guifg=White guibg=NONE guifg=#afcfef
hi VertSplit term=reverse cterm=reverse gui=none guifg=Black guibg=#8f8f8f

"""""""""""""""""""""""""""""
" Insert-mode only Caps Lock
"""""""""""""""""""""""""""""
" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
  execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor

" Kill the capslock when leaving insert mode.
autocmd InsertLeave * set iminsert=0

" Insert and command-line mode Caps Lock.
" Lock search keymap to be the same as insert mode.
set imsearch=-1
" Load the keymap that acts like capslock.
set keymap=insert-only_capslock
" Turn it off by default.
set iminsert=0

:highlight Cursor guifg=NONE guibg=Green
:highlight lCursor guifg=NONE guibg=Cyan

" Set following to show "<CAPS>" in the status line when "Caps Lock" is on.
let b:keymap_name = "CAPS"
" Show b:keymap_name in status line.
:set statusline^=%k



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

"nnoremap <C-.> 
"nnoremap <C-,> 
