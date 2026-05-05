---Setups keybindings configs.
local function setup_keybindings_configs()
	vim.g.mapleader = " "
	vim.o.listchars = "tab:→\\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»"
end

---Setup search keybindings.
local function setup_search_keybindings()
	vim.keymap.set("n", "<leader>cs", ":noh<CR>", { silent = true, noremap = true, desc = "[C]lear [S]earch" })
	vim.keymap.set("n", "n", "nzzzv", { silent = true, noremap = true, desc = "[N]ext search result (centered)." })
	vim.keymap.set("n", "N", "Nzzzv", { silent = true, noremap = true, desc = "Previous search result (centered)." })
end

---Setup scroll keybindings.
local function setup_scroll_keybindings()
	vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, noremap = true, desc = "Half page down (centered)." })
	vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, noremap = true, desc = "Half page up (centered)." })
end

---Setup spell keybindings.
local function setup_spell_keybindings()
	vim.keymap.set(
		"n",
		"<leader>ss",
		":set spell!<CR>",
		{ silent = true, noremap = true, desc = "[S]et [S]pell (toggle spellchecking)" }
	)
end

---Setup list keybindings.
local function setup_list_keybindings()
	vim.keymap.set(
		"n",
		"<leader>sl",
		":set list!<CR>",
		{ silent = true, noremap = true, desc = "[S]et [L]ist (toggle non-visible characters)" }
	)
end

---Setup paste keybindings.
local function setup_paste_keybindings()
	vim.keymap.set("n", "<leader>P", '"+p', { silent = true, noremap = true, desc = "[P]aste from system clipboard" })
	vim.keymap.set("n", "<leader>p", '"0p', { silent = true, noremap = true, desc = "[P]aste last yanked text" })
end

---Setups terminal keybindings
local function setup_terminal_keybindings()
	vim.keymap.set(
		"t",
		"<C-q>",
		"<Esc><C-\\><C-n>",
		{ silent = true, noremap = true, desc = "Normal mode from terminal mode" }
	)
end

---Setups indent keybindings
local function setup_indent_keybindings()
	vim.keymap.set("v", "<", "<gv", { silent = true, noremap = true, desc = "Indent left and reselect" })
	vim.keymap.set("v", ">", ">gv", { silent = true, noremap = true, desc = "Indent right and reselect" })
end

---Main entrypoint
local function main()
	setup_keybindings_configs()
	setup_search_keybindings()
	setup_scroll_keybindings()
	setup_spell_keybindings()
	setup_list_keybindings()
	setup_paste_keybindings()
	setup_terminal_keybindings()
	setup_indent_keybindings()
end

main()
