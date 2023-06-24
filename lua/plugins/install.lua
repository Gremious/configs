-- [ Consider:
-- [ https://github.com/eugen0329/vim-esearch
-- ]]

require("lazy").setup({
	"michaelb/do-nothing.vim", -- !! Important
	"nvim-lua/plenary.nvim", -- lib other plugins use
	{
		-- Pretty windows for things that use vim.ui like rust-tools
		-- Immediately nicer for lsp rename
		-- Every plugin that uses vim.ui will basically use
		-- ether pretty windows or telescope automatically
		"stevearc/dressing.nvim",
	},

	-- ==/ themes /==
	"chriskempson/base16-vim",
	"folke/tokyonight.nvim",
	"franbach/miramare",
	"kaicataldo/material.vim", -- theme
	"nvim-tree/nvim-web-devicons",
	"Yazeed1s/minimal.nvim",
	"Yazeed1s/oh-lucy.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "embark-theme/vim", name = "embark" },

	-- Startup screen
	-- {
	--	   "goolord/alpha-nvim",
	--	   requires = { "nvim-tree/nvim-web-devicons" },
	-- },
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			view = {
				width = 40,
				adaptive_size = true,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = false,
				debounce_delay = 50,
				severity = {
					min = vim.diagnostic.severity.WARN,
					max = vim.diagnostic.severity.ERROR,
				},
			},

			-- Update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file.
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			-- Prefer startup root directory when updating root directory of the tree.
			prefer_startup_root = true,
			-- Changes the tree root directory on `DirChanged` and refreshes the tree.
			sync_root_with_cwd = false,
			-- Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
			respect_buf_cwd = true,
		},
	},
	-- ==/ Highlights/Syntax /==
	{
		-- syntax highlighter
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "rust", "markdown", "lua", "vimdoc" },
				highlight = {
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = 4000,
				},
				indent = {
					enable = false,
				},
			})
		end,
	},
	"nvim-treesitter/playground", -- treesitter debug
	{ "fladson/vim-kitty", branch = "main" }, -- kitty config highlighting
	"imsnif/kdl.vim", -- kdl highlighting
	"vmchale/dhall-vim", -- dhall highlighting
	"ron-rs/ron.vim", -- ron highlighting
	"GutenYe/json5.vim", -- json5 highlighting
	-- use 'luochen1990/rainbow' -- Rainbow brackets
	-- "p00f/nvim-ts-rainbow", -- rainbow parens for treesitter
	"machakann/vim-highlightedyank", -- on yank, highlights yanked text for a second
	{
		-- Highlights TODO/INFO/etc.
		"folke/todo-comments.nvim",
		opts = {
			keywords = {
				TODO = { icon = " ", color = "warning" },
			},
		},
	},

	-- Markdown live preview
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	-- shows follow-up hotkey options in status bar
	-- {
	--	   "folke/which-key.nvim",
	--	   config = function()
	--	   vim.o.timeout = true
	--	   vim.o.timeoutlen = 300
	--	   -- require("which-key").setup({
	--	   --	  -- your configuration comes here
	--	   --	  -- or leave it empty to use the default settings
	--	   --	  -- refer to the configuration section below
	--	   -- })
	--	   end,
	-- },

	-- "mg979/vim-visual-multi", -- Multiple cursors
	"tpope/vim-repeat", -- remaps . in a way that plugins can tap into it
	"svermeulen/vim-extended-ft", -- f and t searches go through lines, ignore case, can be repeated with ; and ,
	"chentoast/marks.nvim", -- show marks in sign column
	{
		"Weissle/easy-action",
		dependencies = {
			{
				"kevinhwang91/promise-async",
				module = { "async" },
			},
		},
	},
	{

		-- TODO: Remove diagnostics from lsp-status cause lualine already shows them.
		-- go to lsp status and check their config i think they updated
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			extensions = { "nvim-tree", "fugitive", "nvim-dap-ui", "quickfix" },
			sections = {
				lualine_x = {
					function()
						return require("lsp-status").status()
					end,
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		},
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				sort_by = "insert_after_current",
				show_close_icon = false,
				show_buffer_close_icons = false,
				modified_icon = "✏",

				-- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
				-- separator_style = "slant",

				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = true,
				--- diagnostics_dict is a dictionary from error level ("error", "warning" or "info") to number of errors for each level.
				diagnostics_indicator = function(_count, _level, diagnostics_dict, _context)
					local ret = " "
					for diag_type, count in pairs(diagnostics_dict) do
						local sym = diag_type == "error" and " " or (diag_type == "warning" and " " or "")
						ret = ret .. count .. sym
					end
					return ret
				end,

				-- enforce_regular_tabs = false | true,
				-- always_show_bufferline = true,
			},
		},
	},
	-- use 'romgrk/barbar.nvim' -- Buffer Tabs

	-- Scrope buffers to vim tabs, :bnext and :bprev are workspaces basically
	"tiagovla/scope.nvim",
	-- Don't close the whole tab/window on :bd - use :BD instead
	"qpkorr/vim-bufkill",

	{
		-- Toggle comments
		"scrooloose/nerdcommenter",
		config = function()
			vim.g.NERDCreateDefaultMappings = true
			vim.g.NERDSpaceDelims = true
			vim.g.NERDCommentEmptyLines = true
			vim.g.NERDTrimTrailingWhitespace = true
			vim.g.NERDDefaultAlign = "right"
		end,
	},
	{
		-- undo tree
		-- need to run:
		-- python -m pip install --user --upgrade pynvim
		"sjl/gundo.vim",
		config = function()
			-- GUNDO breaks without python3
			if vim.fn.has("python3") then
				vim.g.gundo_prefer_python3 = 1
			end
		end,
	},
	{
		-- Open/close brackets, statements, etc
		"Wansmer/treesj",
		opts = {
			use_default_keymaps = false,
			check_syntax_error = false,
			max_join_length = 160,
		},
		dependencies = { "nvim-treesitter" },
	},
	"godlygeek/tabular", -- Tab/Spaces aligner
	{
		-- Visible indents
		"lukas-reineke/indent-blankline.nvim",
		-- main = "indent_blankline",
		config = function()
			require("indent_blankline").setup({
				use_treesitter = true,
				show_current_context = true,
			})
		end,
	},
	"tpope/vim-fugitive", -- git
	"airblade/vim-gitgutter", -- git in gutter
	-- {
	--     -- changes working dir to project root whenever you open files
	--     "airblade/vim-rooter",
	--     config = function()
	--         vim.g.rooter_change_directory_for_non_project_files = "current"
	--     end
	-- },
	"RRethy/vim-illuminate", -- Highlight hovered vairables (lsp compatible)
	"tpope/vim-surround", -- suround things with any text
	"wellle/targets.vim",
	-- use 'RishabhRD/popfix' -- Floating pop-ups library
	-- use 'RishabhRD/nvim-lsputils' -- Floating pop up for lsp stuff
	"beauwilliams/focus.nvim", -- resize splits when focusing them

	-- "phaazon/hop.nvim", -- EasyMotion but better, jump around places
	-- {
	--	   "ggandor/leap.nvim",
	--	   config = function()
	--	   require('leap').add_default_mappings()
	--	   end,
	-- },
	"https://gitlab.com/madyanov/svart.nvim",
	-- {
	--	   "madyanov/svart.nvim",
	--	   setup = function ()
	--	   vim.api.nvim_set_hl(0, "SvartLabel", { fg = "#ffcb6b", underline = true })
	--
	--	   end
	-- },
	-- Smart comma/semicolon insert
	"lfilho/cosco.vim",
	{
		-- C-a/x cycle throgh bools/etc.
		"bootleq/vim-cycle",
		config = function()
			vim.g.cycle_no_mappings = true
			vim.g.cycle_phased_search = true
			vim.fn["cycle#add_groups"]({
				{ "true", "false" },
				{ "yes", "no" },
				{ "on", "off" },
				{ "+", "-" },
				{ ">", "<" },
				{ '"', "'" },
				{ "==", "!=" },
				-- { "0", "1" },
				{ "and", "or" },
				{ "in", "out" },
				{ "up", "down" },
				{ "left", "right" },
				{ "min", "max" },
				{ "get", "set" },
				{ "add", "remove" },
				{ "to", "from" },
				{ "read", "write" },
				{ "only", "except" },
				{ "without", "with" },
				{ "exclude", "include" },
				{ "asc", "desc" },
				{ ":)", ":(" },
				{ "c:", ":c" },
				{ "fn", "pub fn", "pub(super) fn", "pub(crate) fn", "async fn", "pub async fn", "pub(crate) async fn" },
				{ "let", "let mut" },
				{ { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }, "hard_case" },
			})
		end,
	},
	{
		-- Auto-trim trailing whitespace on :write
		"zakharykaplan/nvim-retrail",
		lazy = false,
		-- main = "retrail",
		config = function()
			require("retrail").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					layout_config = { height = 0.95 },
					mappings = {
						i = {
							["<esc>"] = require("telescope.actions").close,
							["<C-Down>"] = require("telescope.actions").cycle_history_next,
							["<C-Up>"] = require("telescope.actions").cycle_history_prev,
						},
					},
				},
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				},
			})
		end,
	},

	-- (The actual CLI fzf on your system does not hook into vim plugins, and although you could, it'd be way slower)
	-- So, you have to build this from scratch. You need clang and MS C++ Visual Studio Build Toolds
	-- if you don't mind not using telescope, you can always still use
	-- { "junegunn/fzf", build = ":call fzf#install()" }
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = function()
			if vim.fn.has("win32") == 1 then
				return "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
			else
				return "make"
			end
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	-- "gnikdroy/projections.nvim",
	-- require("projections").setup({
	--     workspaces = {
	--         "~/Projects/Programming/gremy/dev",
	--         "~/Projects/dev",
	--     },
	-- })
	-- {
	--     "rmagatti/auto-session",
	--     dependencies = { "nvim-telescope/telescope.nvim" },
	--     config = function()
	--         require("auto-session").setup({
	--             log_level = "error",
	--             auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
	--         })
	--     end,
	-- },
	-- {
	--     "rmagatti/session-lens",
	--     dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
	--     config = function()
	--         require("telescope").load_extension("session-lens")
	--     end,
	-- },

	-- ==/ LSP /==
	-- https://github.com/sharksforarms/neovim-rust/

	"neovim/nvim-lspconfig",
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			-- lazy doesn't seem to do this one auto
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
	},

	-- Autocompletion framework
	"hrsh7th/nvim-cmp",
	{
		-- cmp LSP completion
		"hrsh7th/cmp-nvim-lsp",
		-- cmp Snippet completion
		"saadparwaiz1/cmp_luasnip",
		-- cmp Path completion
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",

		-- AI-Completion
		-- Powershell doesn't work for me in vim so I just use pwsh 7
		{
			"tzachar/cmp-tabnine",
			cond = function()
				if vim.fn.has("win32") == 1 then
					return true
				else
					return false
				end
			end,
			build = function()
				if vim.fn.has("win32") == 1 then
					return "pwsh ./install.ps1"
				else
					return "sh ./install.sh"
				end
			end,
		},

		-- after = { "hrsh7th/nvim-cmp" },
		-- dependencies = { "hrsh7th/nvim-cmp" },
	},

	-- Snippet engine
	"L3MON4D3/LuaSnip",

	-- Icons for cmp
	"onsails/lspkind.nvim",

	-- Formatter (e.g. rustfmt)
	"mhartington/formatter.nvim",

	-- Debugging
	"mfussenegger/nvim-dap",
	-- {
	--	   "rcarriga/nvim-dap-ui",
	--	   -- version = "v3.2.2",
	--	   dependencies = {
	--	   "mfussenegger/nvim-dap",
	--	   "theHamsta/nvim-dap-virtual-text",
	--	   "jbyuki/one-small-step-for-vimkind",
	--	   },
	--	   config = function()
	--	   require("dapui").setup()
	--	   end,
	-- },

	-- Adds extra functionality over rust analyzer
	{
		"simrat39/rust-tools.nvim",
		dependencies = { "mfussenegger/nvim-dap" },
	},

	-- Very cool crates.io completion commands
	{
		"saecki/crates.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},

	-- Lsp progress in statusline
	"nvim-lua/lsp-status.nvim",
	-- "j-hui/fidget.nvim",
	-- "nvim-lua/popup.nvim",

	-- "folke/trouble.nvim", -- pretty lsp info/diagnostics window

	-- ==/ Silly /==
	-- "Eandrju/cellular-automaton.nvim",

	{
		"tamton-aquib/duck.nvim",
		config = function()
			-- Quite a mellow cat
			vim.keymap.set("n", "<leader>dc", function()
				require("duck").hatch("🐈", 0.75)
			end, {})
			vim.keymap.set("n", "<leader>dn", function()
				require("duck").hatch()
			end, {})
			vim.keymap.set("n", "<leader>dk", function()
				require("duck").cook()
			end, {})
		end,
	},

	-- TODO: Telescope provides this, maybe use that instead. Perhaps without a preview cause confusing to me?
	"yegappan/mru", -- most recently used files so i can undo a close

	-- ==/ Off /==
	-- -- pywal theme support (broken in neovide? :c)
	-- use 'dylanaraps/wal.vim'

	-- Don't rly use it
	-- "ciaranm/detectindent", -- adds :DetectIndent, sets shiftwidth, expandtab and tabstop based on existing use

	-- Cool but I just use :telescope commands?
	-- "LinArcX/telescope-command-palette.nvim", -- Define custom things for the pretty search menu

	-- -- Allows for the creations of 'submodes'
	-- use 'https://github.com/Iron-E/nvim-libmodal'

	-- Very laggy
	-- "gelguy/wilder.nvim",
	-- Maybe only load in small files?
	--
	-- local wilder = require("wilder")
	-- wilder.setup({ modes = { ":", "/", "?" } })
	-- wilder.set_option(
	--     "renderer",
	--     wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
	--         highlighter = wilder.basic_highlighter(),
	--         highlights = {
	--             border = "Normal",
	--             -- The color of the search match
	--             accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
	--         },
	--         left = { " ", wilder.popupmenu_devicons() },
	--         right = { " ", wilder.popupmenu_scrollbar() },
	--         border = "rounded",
	--         -- min_height = 8,
	--         max_height = 8,
	--     }))
	-- )
})
