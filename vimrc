unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

if filereadable(expand("~/.vim/plug.vim"))
  source ~/.vim/plug.vim
endif

" ---- Disable Filetype for Read file settings
filetype plugin indent on
set mouse=a
set autowrite
set number relativenumber
set laststatus=2
set hidden
set clipboard=unnamedplus
set spell

"Ignores
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/target/* 

"setting path to find files
set path+=**

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

"copy to clipboard
vmap <C-c> "+yi
vmap <C-x> "+c


" Backup paths
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

" --------------------------
" --- Webicons Setting -----
" --------------------------

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
set guifont=Fira\ Code\ 14 

" --------------------------
" ----- Color Setting ------
" --------------------------
set t_Co=256
set background=dark
colorscheme gruvbox
highlight Normal ctermbg=none
set showmatch
let g:powerline_pycmd="py"
let g:pymode_python = 'python'
set termguicolors

" --------------------------
" ----- Airline Setting ----
" --------------------------
set laststatus=2
let g:airline_left_sep=""
let g:airline_left_alt_sep="|"
let g:airline_right_sep=""
let g:airline_right_alt_sep="|"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " show tab number not number of split panes
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_powerline_fonts = 1

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

" ----------------------------
" ---- gitgutter settings ----
" ----------------------------
let g:gitgutter_max_signs = 10000
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

nmap <leader>ga :Gwrite <CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gp: Gpush <CR>
nnoremap <silent> <leader>gf :Gfetch<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>

" ----------------------------
" ---- Buffer settings -------
" ----------------------------
nnoremap <Leader>b :buffers<CR>:buffer<Space>

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"" Relative number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * if &filetype !=# 'nerdtree' | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if &filetype !=# 'nerdtree' | set norelativenumber | endif
augroup END

" Nerd Tree"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
silent! nmap <C-p> :NERDTreeToggle<CR>
silent! nmap <F6> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>
let g:NERDTreeToggle="<F2>"
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" ----------------------------
" ---- Runtime settings ------
" ----------------------------
au BufRead,BufNewFile *.sbt set filetype=scala

autocmd FileType ruby runtime ruby_mappings.vim
autocmd FileType scala runtime scala_mappings.vim
autocmd FileType go runtime golang_mappings.vim

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType java setlocal tabstop=2 shiftwidth=2 softtabstop=2

augroup Jenkinsfile
  au!
  au BufNewFile,BufRead Jenkinsfile,jenkinsfile setlocal filetype=groovy
augroup END
