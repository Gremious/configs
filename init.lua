local opt = vim.opt
local g = vim.g
local api = vim.api

--[[
--TODO: Don't comment out empyt lines, and just configure commenter better
--
--TODO: 1. Full file path in statusline
--		2. On item hover, full crtate module path in statusline
--TODO: Disable highlght on super long lines, lags to hell on e.g. massive single line json
-- TODO:
-- Figure out spaces/tab options (plugin?)
-- forrmatting efm server? rustutp? switch rust tools to new thing
-- move all things to insttall file, maybe organize it better?
	TODO:
	Make a script on tabnew to rename the tabs from 1/2/3... to working dir? https://github.com/tiagovla/scope.nvim/issues/3
	Actually bufferline now merged a pr that enabels renaming of tabpages so check that out
	-
	Also, would be cool to write a autocmd that replaces the current tab if it wasn't written in?
	Like default vim behaviour. Idk how nice that would really be.

	a lil rust thing to auto insert #[derive(|)]? Also maybe Snippets to
	surround in Option<>/Result<> (for types not values)
	surround with .tap(|&element|), pipe whole chain?

	Some command to quicklist-do search repalce + update?

	A "close split/buffer" button that checks if buffer currently exists twice
	in window (e.g. how when :BD sends out warning) and if it does it calls :q
	else it calls :BD
	Leader qw is a decent hotkey for closing windows

	<space>d to delete whitespace and maybe merge from line down?

	dsw - delete surrounding wrapper - will `dw`, check if there's a (/{/[ etc under cursor, then `ds(` it - fast remove Some(...)

	custom hop searches for frequently used edits:
	e.g. place caret in the {:|?}, ?}|" or item|) in a println/log::debug!("{:?}", item)
]]

--// Environment specific options //--

if vim.fn.has("win32") == 1 then
	vim.env.CONFIG = vim.env.LOCALAPPDATA .. "\\nvim"
	-- " Fixes fzf preview
	vim.env.PATH = "C:\\Program Files\\Git\\usr\\bin;" .. vim.env.path

	-- Default to unix, but auto-detect if file is in dos already.
	-- If you don't add "dos" - it will error every time you open vim help
	opt.fileformats = "unix,dos"
else
	-- The FHS 3 compliant place on linux.
	-- Might wanna own those dirs or something though.
	-- Perthaps there are local user-folder alternatives?
	opt.backupdir = "/var/lib/nvim/backup"
	opt.directory = "/var/lib/nvim/swap"
	opt.undodir = "/var/lib/nvim/undo"
end

vim.g.mapleader = " "

require("config.lazy-bootstrap")
-- require("plugins.install")
require("plugins")
require("config.theme")

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

opt.sessionoptions:append("localoptions") -- Save localoptions to session file
opt.sessionoptions:append("winpos") -- Save winpos to session file

-- rust-analyzer.server.extraEnv
-- neovim doesn"t have custom client-side code to honor this setting, it doesn"t actually work
-- https://github.com/neovim/nvim-lspconfig/issues/1735
vim.env.CARGO_TARGET_DIR = "target/rust-analyzer-check"
g.rust_recommended_style = false

opt.fileencoding = "utf-8"

-- opt.autoindent = true
-- opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = false
opt.listchars = "space:·,tab:>=,trail:·,extends:»,precedes:«,eol:↴" --characters to use for whitespace

opt.backup = true
opt.history = 1000 -- longer command history
opt.undolevels = 1000 -- more undo levels
opt.undofile = true -- persistent undo between sessions

opt.lazyredraw = true -- don"t redraw in macros
opt.synmaxcol = 500 -- don"t syntax past 500 char in a single-line (think minified code
opt.scrolloff = 15 -- don"t syntax past 500 char in a single-line (think minified code
opt.updatetime = 100 -- Default is 4000. How long to wait after typing stopts to run e.g. plugin updates.

opt.number = true -- Show line numbers
opt.relativenumber = true -- Line numbers are relative to cursor

opt.cursorline = true -- highlight current line
opt.showmatch = true -- matching brackets while typing
opt.matchpairs:append({ "<:>" }) -- add angle brackets to % matching
-- opt.matchtime = 5 -- time of show

opt.linebreak = true -- Wrapped lines will wrap at breaks not mid-letter
opt.splitbelow = true --new vertical split will be below
opt.splitright = true --new horizontal split will be to the right
vim.opt.diffopt:append({ "vertical" }) -- diffs are also vertical
opt.formatoptions = "crqlj" --wrap comments, never autowrap long lines
opt.cmdheight = 2 -- more space for displaying messages
opt.signcolumn = "yes" -- always show signcolumn (column near number line
-- opt.shortmess = "c" -- don"t pass messages to ins-completion-menu
vim.cmd("noh") -- don"t auto-highlight last search on new session

-- Disable mouse, enabled by default in vim 0.8.
opt.mouse = ""
opt.clipboard:append({ "unnamed,unnamedplus" })
opt.nrformats:remove({ "octal" })
opt.whichwrap = "<>"

-- font names are weird, you can set guifont=* to list them
-- opt.guifont = "JetBrainsMono_Nerd_Font_Mono:h14"
-- opt.guifont = "Twilio Sans Mono,Segoe_UI_Emoji:h14"
opt.guifont = "FiraCode Nerd Font,Segoe_UI_Emoji:h14"

if vim.g.neovide then
	-- g.neovide_remember_window_size = false
	-- vim.g.neovide_scroll_animation_length = 0.15
	-- vim.g.neovide_scroll_animation_far_lines = 9999
	vim.g.neovide_refresh_rate = 144
end

opt.ignorecase = true -- remove case check in search
opt.smartcase = true -- only care about case in search if there are upper-case letters, needs ignorecase

--- Starts a new undo block.
function SetUndoBreakpoint()
	vim.o.undolevels = vim.o.undolevels
end

require("config.functions")
require("config.lsp")
require("config.commands")
require("config.hotkeys")
require("config.autocmd")

-- Quick option debug
function Optinfo(o)
	print(vim.inspect(api.nvim_get_option_info(o)))
end

function Hasmodule(module)
	local function requiref(mod)
		require(module)
	end

	return pcall(requiref, module)
end

vim.keymap.set("i", "<M-CR>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
vim.g.copilot_no_tab_map = true
-- vim.keymap.set("i", "<c-[>", '<Plug>(copilot-previous)', { silent = true, expr = true, noremap = false })
-- vim.keymap.set("i", "<c-]>", '<Plug>(copilot-next)', { silent = true, expr = true, noremap = false })
