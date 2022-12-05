" TODO:
" Make a script on tabnew to rename the tabs from 1/2/3... to working dir? https://github.com/tiagovla/scope.nvim/issues/3
"
" a lil rust thing to auto insert #[derive(|)]? Also maybe Snippets to
"
" surround in Option<>/Result<> (for types not values)
"
" Some command to quicklist-do search repalce + update?
"
" A "close split/buffer" button that checks if buffer currently exists twice
" in window (e.g. how when :BD sends out warning) and if it does it calls :q
" else it calls :BD
"

if has('win32')
	let $CONFIG = $LOCALAPPDATA . '\nvim'
	" Fixes fzf preview
	let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH
else
	let $CONFIG = '~/.config/nvim'
endif

" Need to run 
" python -m pip install --user --upgrade pynvim
" for Gundo/Python support

" rust-analyzer.server.extraEnv
" neovim doesn't have custom client-side code to honor this setting, it doesn't actually work
" https://github.com/neovim/nvim-lspconfig/issues/1735
let $CARGO_TARGET_DIR = "target/rust-analyzer-check"

syntax on
" set autochdir "auto-set current dir so that you can do `:e newfile` to make newfiles in ./ by default
filetype plugin indent on " see help filetype
set fileformats=unix
set encoding=utf-8 "required for powerline symbols
set fileencoding=utf-8
set spelllang=en,cjk
set autoindent noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
" set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab "use tabs instead of spaces

set backupdir=/var/lib/nvim/backup
set directory=/var/lib/nvim/swap
set undodir=/var/lib/nvim/undo
set writebackup
set history=1000 "longer command history
set undolevels=1000 "more undo levels
set undofile " persistent undo between sessions

set termguicolors
set lazyredraw " don't redraw in macros
set synmaxcol=500 " don't syntax past 500 char in a single-line (think minified code)
set ttimeoutlen=50 "small timeout for airline
set scrolloff=15

set number "display line numbers
set relativenumber "line numbers are relative to the current line
set cursorline "highlight current line
set laststatus=2 "always show status
set showmatch "matching brackets while typing
set showcmd "show incomplete commands
set listchars=space:·,tab:>=,trail:·,extends:»,precedes:«,eol:↴ "characters to use for whitespace
set linebreak " Wrapped lines will wrap at breaks not mid-letter
set nowrap
set wildmenu "autocomplete for commands is visible
set splitbelow "new vertical split will be below
set splitright "new horizontal split will be to the right
set formatoptions=crqlj "wrap comments, never autowrap long lines
set diffopt+=vertical " diffs are vertical
set cmdheight=2 " more space for displaying messages
set signcolumn=yes " always show signcolumn
" set shortmess+=c " on't pass messages to ins-completion-menu
set textwidth=0 wrapmargin=0
noh " don't auto-highlight last search on new session
set noshowmode " We have airline so don't need to see 'VISUAL'

" Disable mouse, enabled by default in vim 0.8.
set mouse=
" set backspace=indent,eol,start " Backspace anthing in edit mode
set clipboard+=unnamed,unnamedplus "default register is clipboard
set nrformats-=octal " do not inc/dec octal numbers as it can lead to errors
set hidden "allows unsaved buffers
set autoread "auto-refresh changed files
" set incsearch "show what part of searched string matches
set ignorecase "remove case check in search
set smartcase "only care about case in search if there are upper-case letters, needs ignorecase
set whichwrap=<>
set pyx=3 " set python version

" set guifont=JetBrainsMono_Nerd_Font:h12
" set guifont=FiraCode_Nerd_Font_Mono:h12
set guifont=FiraCode_NF,Segoe_UI_Emoji:h12	
let neovide_remember_window_size = v:false
let g:neovide_refresh_rate=140
let g:rainbow_active = 1

source $CONFIG/plugins.vim
source $CONFIG/lsp.vim
" source $CONFIG/lsp-coc.vim
source $CONFIG/hotkeys.vim
source $CONFIG/autocmd.vim

" let g:catppuccin_flavour = "mocha"
" colorscheme catppuccin
let g:material_theme_style = 'ocean'
let g:material_terminal_italics = 1
colorscheme material
" colorscheme wal " doesn't seem to work with neovide very sad :c

" Type config -> get config
command Config :e $CONFIG/init.vim
command ConfigHotkeys :e $CONFIG/hotkeys.vim
command ConfigPlugins :e $CONFIG/plugins.vim
command ConfigLsp :e $CONFIG/lsp.vim
command ConfigAutocmd :e $CONFIG/autocmd.vim
command Reload execute ':so $MYVIMRC'
" Copy filepath to clipboard
command Cc     :let @+ = expand("%:p")

