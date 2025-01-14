---@class StyleConfig # Style configuration for a programming language.
---@field pattern # Pattern to detect the filetypes.
---@field num_spaces # Number of spaces for indentation.

---Setups style for a programming language.
---@param config StyleConfig # Style configuration.
local function setup_style(config)
	vim.o.shiftwidth = config.num_spaces
	vim.o.tabstop = config.num_spaces
end

---Setups the autocommand for a given programming language.
---@param style_config # Style configuration.
local function setup_style_autocmd(config)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		group = group,
		desc = "Sets the styling.",
		pattern = config.pattern,
		callback = function(ev)
			setup_style(config)
		end,
	})
end

---Setups styling for Lua files.
---@param group any # Neovim augroup.
local function setup_lua(group)
	local config = {
		pattern = { "*.lua" },
		num_spaces = 2,
	}
	setup_style_autocmd(config)
end

---Setups styling for Python files.
---@param group any # Neovim augroup.
local function setup_python(group)
	local config = {
		pattern = { "*.python" },
		num_spaces = 4,
	}
	setup_style_autocmd(config)
end

---Setups styling for C files.
---@param group any # Neovim augroup.
local function setup_c(group)
	local config = {
		pattern = { "*.c", "*.h" },
		num_spaces = 2,
	}
	setup_style_autocmd(config)
end

---Setups styling for Shell files.
---@param group any # Neovim augroup.
local function setup_sh(group)
	local config = {
		pattern = { "*.sh" },
		num_spaces = 4,
	}
	setup_style_autocmd(config)
end

---Main entrypoint.
local function main()
	local group = vim.api.nvim_create_augroup("CodeStyle", {})
	setup_lua(group)
	setup_python(group)
	setup_c(group)
	setup_sh(group)
end

main()
