"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(expand('~/.config/nvim'))
  call dein#begin(expand('~/.config/nvim'))

  " Let dein manage dein
  " Required:
  call dein#add(expand('~/.config/nvim/repos/github.com/Shougo/dein.vim'))

  " Add or remove your plugins here:
  " Solarized Theme
  call dein#add('iCyMind/NeoSolarized')

  " Brackets/parens auto-completion
  call dein#add('Raimondi/delimitMate')

  " Vimproc - required for other plugins
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

  " Denite.nvim
  call dein#add('Shougo/denite.nvim')

  " Easymotion
  call dein#add('easymotion/vim-easymotion')

  " Tmux/Vim navigation with Ctrl-HJKL
  call dein#add('christoomey/vim-tmux-navigator')

  " Deoplete
  call dein#add('Shougo/deoplete.nvim')

  " Ale
  call dein#add('w0rp/ale')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

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

" Enable truecolor
set termguicolors

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

" Smooth scrolling
set mouse=a
nnoremap <C-Y> <ScrollWheelUp>
nnoremap <C-E> <ScrollWheelDown>
nnoremap <S-K> 5<C-Y>
nnoremap <S-J> 5<C-E>

" Set neovim python3
let g:python3_host_prog = expand("~/anaconda2/envs/anaconda3/bin/python")

" ================ Plugin Config =====================

" Colorscheme
set background=dark
colorscheme NeoSolarized

" ----------- Easymotion Config -----------
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key bindings.
" `f{char}{label}`
nmap f <Plug>(easymotion-overwin-f)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Type Enter and jump to first match
let g:EasyMotion_enter_jump_first = 1

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" ----------- Denite Config -----------
" map <leader>u as the unite prefix.
nnoremap [unite] <Nop>
nmap <leader>u [unite]

if executable('ag')
  " The Silver Searcher
	call denite#custom#var('file_rec', 'command',
		\ ['ag', '--follow', '--nocolor', '--nogroup', '--ignore', '.hg', '--ignore', '.svn', '--ignore', '.git', '--ignore', '.bzr', '--hidden', '-g', ''])

	call denite#custom#var('grep', 'command', ['ag'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', [])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
	call denite#custom#var('grep', 'default_opts',
		\ [ '-i', '--vimgrep', '--smart-case', '--hidden', '--ignore', '.hg', '--ignore', '.svn', '--ignore', '.git', '--ignore', '.bzr' ])
endif

" Switch between files and buffers
call denite#custom#source('buffer,file_rec,grep,line', 'sorters', ['sorter_sublime'])
call denite#custom#source('buffer,file_rec,grep,line', 'matchers', ['matcher_fuzzy'])
nnoremap [unite]f :<C-u>Denite buffer file_rec<cr>

" Bind Ctrl-P to [unite]f ([unite] = <Leader>u)
map <C-p> [unite]f

" Grep current directory
nnoremap [unite]g :<C-u>Denite -auto-preview -no-empty grep<cr>

" Cycle through denite prompts with up and down
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>', 'noremap')

call denite#custom#option('_', {
	\ 'prompt': '  →  ',
	\ 'empty': 0,
  \ 'short_source_names': 1,
  \ 'direction': 'dynamictop',
  \ 'statusline': 0,
	\ 'winheight': 16,
	\ })

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
