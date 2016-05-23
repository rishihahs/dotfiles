"Begin dein Scripts-----------------------------

filetype off

" Required:
set runtimepath^=~/.config/nvim/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.config/nvim'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

"--- Plugins ---
" Solarized Theme
call dein#add('skwp/vim-colors-solarized')

" Brackets/parens auto-completion
call dein#add('Raimondi/delimitMate')

" Vimproc - required for other plugins
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

" Unite.vim
call dein#add('Shougo/unite.vim')

" Unite Yank History
call dein#add('Shougo/neoyank.vim')

" Tmux/Vim navigation with Ctrl-HJKL
call dein#add('christoomey/vim-tmux-navigator')

" Deoplete
call dein#add('Shougo/deoplete.nvim')

" Clang completion
call dein#add('rishihahs/deoplete-clang')

" Haskell
call dein#add('neovimhaskell/haskell-vim',
      \{'on_ft': 'haskell'})
call dein#add('enomsg/vim-haskellConcealPlus',
      \{'on_ft': 'haskell'})
call dein#add('eagletmt/neco-ghc',
      \{'on_ft': 'haskell'})


"--- End Plugins ---

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" TODO: Call once a week or so
" If you want to update not updated plugins on startup.
" call dein#update()

" If you want to remove not used plugins on startup.
call map(dein#check_clean(), "delete(v:val, 'rf')")


"End dein Scripts-------------------------

" ================ General Config ====================
set number      "Line numbers are good

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

set visualbell                  "No sounds

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Set Leader
let mapleader=","

" Fixing character search commands (since Leader is changed to ,).
noremap \ ,

" Indentation
set autoindent
set smartindent
set smarttab
set tabstop=2
set softtabstop=2
set expandtab      " tabs are spaces.
set shiftwidth=2   " for visual indentation.

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" Save undo tree for file
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

colorscheme solarized
set background=dark

" Set neovim python3
let g:python3_host_prog = expand("~/anaconda/envs/python3/bin/python")

" ================ Plugin Config =====================

" ----------- Unite Config -----------
" map <leader>u as the unite prefix.
nnoremap [unite] <Nop>
nmap <leader>u [unite]

if executable('ag')
  " Unite filelist command (use ag)
  let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--ignore', '.hg', '--ignore', '.svn', '--ignore', '.git', '--ignore', '.bzr', '--hidden', '-g', '']

  " Use ag for grep
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '-i --vimgrep --ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
endif

call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap [unite]f :<C-u>Unite -buffer-name=files -start-insert file_rec/async:!<cr>

" Switch between buffers
nnoremap [unite]b :<C-u>Unite -quick-match -no-split buffer<cr>

" Grep current directory
nnoremap [unite]g :<C-u>Unite -auto-preview -no-empty grep<cr>

" Unite yank history
nnoremap [unite]y :<C-u>Unite -quick-match history/yank<cr>

" Bind Ctrl-P to [unite]f ([unite] = <Leader>u)
map <C-p> [unite]f

nmap [unite]p <Plug>(unite_print_message_log)

call unite#custom#profile('default', 'context', {
  \ 'prompt' : '  →  '
  \ })

" Unite Input Prompt Style
hi link uniteInputPrompt Special

" ----------- Deoplete config ----------
" Enable deoplete
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" Enable smartcase
let g:deoplete#enable_smart_case = 1

" Disable auto-completion (would have to manually press keys)
let g:deoplete#disable_auto_complete = 1

" Autoclose scratch window
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" deoplete Ctrl-space-complete
inoremap <silent><expr> <C-Space> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

" Hack to fix E29: No inserted text yet
imap <C-@> <C-Space>

" deoplete-clang opions
let g:deoplete#sources#clang#libclang_path = "/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
let g:deoplete#sources#clang#clang_header = "/Library/Developer/CommandLineTools/usr/lib/clang"

" ----------- Haskell Config -----------
" Haskell unicode conversions
" let hscoptions="𝐒𝐓𝐄𝐌xRtB𝔻w"
let hscoptions="t"

" Disable haskell-vim omnifunc (since we want to use neco-ghc)
let g:haskellmode_completion_ghc = 0
