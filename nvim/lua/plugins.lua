local gh = function(x) return "https://github.com/" .. x end

-- 1
vim.pack.add({
	{ src = gh("stevearc/oil.nvim") },
	{ src = gh("nvim-mini/mini.icons") },
})

require("oil").setup({
	default_file_explorer = true,
	view_options = {
		show_hidden = true,
	},
})

-- 2
vim.pack.add({
	{ src = gh("mason-org/mason.nvim") },
})

require("mason").setup({})

-- 3
vim.pack.add({
	{ src = gh("ibhagwan/fzf-lua") },
})

local actions = require('fzf-lua.actions')
require('fzf-lua').setup({
	winopts = { backdrop = 85 },
	keymap = {
		builtin = {
			["<C-f>"] = "preview-page-down",
			["<C-b>"] = "preview-page-up",
			["<C-p>"] = "toggle-preview",
		},
		fzf = {
			["ctrl-a"] = "toggle-all",
			["ctrl-t"] = "first",
			["ctrl-g"] = "last",
			["ctrl-d"] = "half-page-down",
			["ctrl-u"] = "half-page-up",
		}
	},
	actions = {
		files = {
			["ctrl-q"] = actions.file_sel_to_qf,
			["ctrl-n"] = actions.toggle_ignore,
			["ctrl-h"] = actions.toggle_hidden,
			["enter"]  = actions.file_edit_or_qf,
		}
	}
})

-- 4
vim.pack.add({
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("^1") },
})

require('blink.cmp').setup({
	fuzzy = { implementation = 'prefer_rust_with_warning' },
	signature = { enabled = true },
	keymap = {
		preset = "default",
		["<C-space>"] = {},
		["<C-p>"] = {},
		["<Tab>"] = {},
		["<S-Tab>"] = {},
		["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-n>"] = { "select_and_accept" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-b>"] = { "scroll_documentation_down", "fallback" },
		["<C-f>"] = { "scroll_documentation_up", "fallback" },
		["<C-l>"] = { "snippet_forward", "fallback" },
		["<C-h>"] = { "snippet_backward", "fallback" },
		["<C-e>"] = { "hide" },
		["<CR>"] = { "accept", "fallback" },
	},

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",
	},

	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		}
	},

	cmdline = {
		keymap = {
			preset = 'inherit',
			['<CR>'] = { 'accept_and_enter', 'fallback' },
		},
	},

	sources = { default = { "lsp" } }
})

-- 5
vim.pack.add({
	{ src = gh("alpashko/express_line.nvim") },
	{ src = gh("nvim-lua/plenary.nvim") },
})

local builtin = require "el.builtin"
local extensions = require "el.extensions"
local subscribe = require "el.subscribe"
local sections = require "el.sections"

require("el").setup({
	generator = function()
		local segments = {}

		table.insert(segments, extensions.mode)
		table.insert(segments, " ")
		table.insert(
			segments,
			subscribe.buf_autocmd("el-git-branch", "BufEnter", function(win, buf)
				local branch = extensions.git_branch(win, buf)
				if branch then
					return branch
				end
			end)
		)
		table.insert(
			segments,
			subscribe.buf_autocmd("el-git-changes", "BufWritePost", function(win, buf)
				local changes = extensions.git_changes(win, buf)
				if changes then
					return changes
				end
			end)
		)
		table.insert(segments, function()
			local task_count = #require("misery.scheduler").tasks
			if task_count == 0 then
				return ""
			else
				return string.format(" (Queued Events: %d)", task_count)
			end
		end)
		table.insert(segments, sections.split)
		table.insert(segments, "%f")
		table.insert(segments, sections.split)
		table.insert(segments, builtin.filetype)
		table.insert(segments, "[")
		table.insert(segments, builtin.line_with_width(3))
		table.insert(segments, ":")
		table.insert(segments, builtin.column_with_width(2))
		table.insert(segments, "]")

		return segments
	end,
})

-- 6
vim.pack.add({
	{ src = gh("tjdevries/colorbuddy.nvim") },
})

require("colorbuddy").setup({
	lazy = false,
	priority = 1000,
})

-- 7
vim.pack.add({
	{ src = gh("mbbill/undotree") },
})

-- 8
-- vim.pack.add({
-- 	{ src = gh("folke/tokyonight.nvim") },
-- })

vim.pack.add({
	{ src = gh("Mofiqul/vscode.nvim") },
})


-- 9
vim.pack.add({
	{ src = gh("lewis6991/gitsigns.nvim") },
})

require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 300,
		virt_text_pos = "eol",
	},
	watch_gitdir = {
		follow_files = true
	},
	sign_priority = 6,
	update_debounce = 100,
	max_file_length = 40000, -- disable on huge files
})

-- 10
vim.pack.add({
	{ src = gh("tpope/vim-fugitive") },
})

