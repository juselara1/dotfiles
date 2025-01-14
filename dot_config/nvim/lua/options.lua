---Setups the configuration for line numbers.
local function setup_line_numbers()
	vim.o.number = true
	vim.o.relativenumber = true
	vim.o.numberwidth = 1
end

---Setups visual configs.
local function setup_visual()
	vim.o.termguicolors = true
	vim.o.showmatch = true
	vim.o.mouse = ""
	vim.o.laststatus = 1
	vim.o.background = "dark"
end

---Setups text configs
local function setup_text()
	vim.o.encoding = "utf-8"
	vim.o.spelllang = "en,es"
	vim.cmd.syntax("enable")
end

---Setups behavior configs
local function setup_behavior()
	vim.o.updatetime = 100
	vim.o.clipboard = "unnamedplus"
	vim.o.showmode = false
	vim.o.showcmd = false
	vim.o.ruler = false
	vim.o.cmdheight = 0
end

---Setups general keybindings
local function setup_keybindings()
	vim.g.mapleader = " "
	vim.o.listchars = "tab:→\\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»"
	vim.keymap.set("n", "<leader>cs", ":noh<CR>", { silent = true, noremap = true, desc = "[C]lear [S]earch" })
	vim.keymap.set(
		"n",
		"<leader>sl",
		":set list!<CR>",
		{ silent = true, noremap = true, desc = "[S]et [L]ist (toggle non-visible characters)" }
	)
	vim.keymap.set(
		"n",
		"<leader>ss",
		":set spell!<CR>",
		{ silent = true, noremap = true, desc = "[S]et [S]pell (toggle spellchecking)" }
	)
	vim.keymap.set("n", "<leader>P", '"+p', { silent = true, noremap = true, desc = "[P]aste from system clipboard" })
	vim.keymap.set("n", "<leader>p", '"0p', { silent = true, noremap = true, desc = "[P]aste last yanked text" })
	vim.keymap.set(
		"t",
		"<C-q>",
		"<Esc><C-\\><C-n>",
		{ silent = true, noremap = true, desc = "Normal mode from terminal mode" }
	)
end

---Setups autocommands
local function setup_autocommands()
	--Highlights yanked text
	vim.api.nvim_create_autocmd({ "TextYankPost" }, {
		pattern = { "*" },
		callback = function(ev)
			vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
		end,
	})

	--Sets fennel files
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = { "*.fnl" },
		callback = function(ev)
			vim.bo[ev.buf].syntax = "fennel"
			vim.bo[ev.buf].filetype = "fennel"
		end,
	})

	--Sets terraform files
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = { "*.tf", "*.tfvars" },
		callback = function(ev)
			vim.bo[ev.buf].syntax = "terraform"
			vim.bo[ev.buf].filetype = "terraform"
		end,
	})
end

---Main entrypoint
local function main()
	setup_line_numbers()
	setup_visual()
	setup_text()
	setup_behavior()
	setup_keybindings()
	setup_autocommands()
end

main()
