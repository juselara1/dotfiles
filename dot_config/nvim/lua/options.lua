---Setups the configuration for line numbers.
local function setup_basic()
	vim.o.number = true -- Line numbers.
	vim.o.relativenumber = true -- Relative line numbers
	vim.o.cursorline = true -- Highlight current line.
	vim.o.wrap = false -- Don't wrap lines.
	vim.o.scrolloff = 10 -- Keep 10 lines above cursor.
	vim.o.sidescrolloff = 8 -- Keep 8 columns aside of cursor.
end

---Setups default indentation.
local function setup_indentation()
	vim.o.tabstop = 2 -- Tab width.
	vim.o.shiftwidth = 2 -- Indent width.
	vim.o.softtabstop = 2 -- Soft tab stop.
	vim.o.expandtab = true -- Use spaces instead of tabs.
	vim.o.autoindent = true -- Copy indent of current line.
	vim.o.smartindent = true -- Smart autoindent
end

---Setups visuals.
local function setup_visual()
	vim.o.termguicolors = true -- Enable 24 bit colors.
	vim.o.signcolumn = "yes" -- Always show sign column.
	vim.o.colorcolumn = "150" -- Show column at 100 characters.
	vim.o.showmatch = true -- Highlight mattching brackets.
	vim.o.matchtime = 2 -- How long to show the matched brackets.
	vim.o.mouse = "" -- Disable mouse.
	vim.o.laststatus = 2 -- Create a statusline only if there're two windows.
	vim.o.showmode = false -- Don't show mode in command line.
	vim.o.conceallevel = 0 -- Show conceal text normally.
	vim.o.lazyredraw = true -- Don't redraw during macros.
	vim.o.showcmd = false -- Don't show partial commands.
	vim.o.ruler = false -- Don't show cursor position.
end

--- Setups colorscheme.
local function setup_colorscheme()
	vim.cmd("colorscheme habamax") -- Setup colorscheme.
	vim.o.background = "dark" -- Specify dark mode to color groups.
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- Transparent background.
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- Transparent background.
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" }) -- Transparent background.
	vim.o.winblend = 0 -- Transparency for popup windows.
end

---Setups text options.
local function setup_text()
	vim.o.encoding = "utf-8" -- Text encoding.
	vim.o.spelllang = "en,es" -- Text languages.
	vim.cmd.syntax("enable") -- Enable syntax checking. -- Enable syntax checking.
end

---Setups file handling.
local function setup_file_handling()
	vim.o.backup = false -- Don't create backups.
	vim.o.writebackup = false -- Don't create backup before writing.
	vim.o.swapfile = false -- Don't create swap files.
	vim.o.undofile = true -- Persistent undo.
	vim.o.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory.
	vim.o.updatetime = 100 -- Faster completion.
	vim.o.autoread = true -- Auto relead files changed outside vim.
	vim.o.autowrite = false -- Don't autosave.
end

---Setups behavior.
local function setup_behavior()
	vim.o.hidden = true -- Allow hidden buffers.
	vim.o.errorbells = false -- No error bells.
	vim.o.backspace = "indent,eol,start" -- Better backspace behavior.
	vim.o.autochdir = false -- Don't change root directory when files are opened.
	vim.o.clipboard = "unnamedplus" -- Use clipboard for all operations.
	vim.o.shortmess = "I" -- Don't show startup message.
end

---Highlights yanked text.
---@param group any # Neovim augroup
local function setup_yank_highlight()
	vim.api.nvim_create_autocmd({ "TextYankPost" }, {
		desc = "Highlights yanked text",
		pattern = { "*" },
		callback = function(ev)
			vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
		end,
	})
end

---Main entrypoint
local function main()
	setup_basic()
	setup_visual()
	setup_colorscheme()
	setup_text()
	setup_file_handling()
	setup_behavior()
	setup_yank_highlight()
end

main()
