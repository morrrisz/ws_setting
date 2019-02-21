"
" Maintainer:	Morrris
" Last_change:	2018 Apr 13
"

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set t_Co=16
set clipboard=unnamed
set wildmode=list:longest

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" set backupdir=~/.backup
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching
set cursorline  " enable horizontal highlight line
set enc=utf8
set wrap

" Tab Setting
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

" Line Number
set nu
hi LineNR cterm=Bold ctermfg=DarkGrey ctermbg=NONE
hi CursorLineNR cterm=bold ctermfg=3 ctermbg=NONE

" For Win32 GUI, remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
"inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  "filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Fold Setting
set foldmethod=marker
set foldnestmax=1

" Solarized Setting
syntax enable
set background=dark "dark|light
let g:solarized_termcolors=16 "16|256
let g:solarized_termtrans=1 "0|1
let g:solarized_contrast="normal" "normal|high|low
let g:solarized_menu=1 "0|1
colorscheme solarized
if has('gui_running')
  set background=light
else
  set background=dark
endif

" Status Bar
set laststatus=2
set statusline=%4*%<\ %1*[%F]
set statusline+=%4*\ %5*[%{&encoding}, " encoding
set statusline+=%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}]%m
set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
highlight User1 ctermfg=red ctermbg=black
highlight User2 term=none cterm=none ctermfg=3 ctermbg=black
highlight User3 term=none cterm=none ctermfg=2 ctermbg=black
highlight User4 term=none cterm=none ctermfg=3 ctermbg=black
highlight User5 ctermfg=cyan ctermbg=black
highlight User6 ctermfg=white ctermbg=black

" vim_airline
"let g:airline_powerline_fonts=1
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif


" FileType
au BufNewFile,BufRead * 
  \ if expand('%:t') =~ 'netlist' | set syntax=spice |
  \ endif
au BufNewFile,BufRead *.lib set filetype=lib
au BufNewFile,BufRead *.mdl set filetype=spice
au BufNewFile,BufRead *.inc set filetype=spice
au BufNewFile,BufRead *.cir set filetype=spice
au BufNewFile,BufRead *.ckt set filetype=spice
au BufNewFile,BufRead *.cdl set filetype=spice
au BufNewFile,BufRead *.meas set filetype=spice
au BufNewFile,BufRead *.spf set filetype=spice
au BufNewFile,BufRead *.spi set filetype=spice
au BufNewFile,BufRead .cds* set filetype=skill

" Key Mapping
"inoremap ( ()<Esc>i
"inoremap " ""<Esc>i
"inoremap ' ''<Esc>i
"inoremap [ []<Esc>i
"inoremap {<CR> {<CR>}<Esc>ko
"inoremap {{ {}<Esc>i

" VIM function, search keyword in selected area by visual mode
"function! RangeSearch(direction)
"  call inputsave()
"  let g:srchstr = input(a:direction)
"  call inputrestore()
"  if strlen(g:srchstr) > 0
"    let g:srchstr = g:srchstr.
"      \ '\%>'.(line("'<")-1).'l'.
"      \ '\%<'.(line("'>")+1).'l'
"  else
"    let g:srchstr = ''
"  endif
"endfunction
"vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
"vnoremap <silent> ? :<C-U>call RnageSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>
"""vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

""map <F12> :!mod2inst<CR>

