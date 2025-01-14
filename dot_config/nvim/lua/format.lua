local logging = require("logging")

---@class FormatConfig # Language specific configuration for code formatting.
---@field pattern string[] # Pattern to match the files.
---@field executable string # Executable command to validate.
---@field cmd_fn function(string): string # Creates command to execute based on the filename.

---Setup code formatter.
---@param config FormatConfig # Language specific configuration.
---@param group any # Neovim augroup.
local function setup_code_format_autocmd(config, group)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		group = group,
		desc = "Sets the code format shortcuts.",
		pattern = config.pattern,
		callback = function(_)
			if vim.fn.executable(config.executable) == 1 then
				logging.info(("[format] Executable '%s' found in path."):format(config.executable))
				vim.keymap.set("n", "<leader>cf", function()
					local filename = vim.api.nvim_buf_get_name(0)
					vim.cmd("silent! write")
					vim.cmd("silent! " .. config.cmd_fn(filename))
					vim.cmd("silent! edit")
				end, { silent = true, noremap = true, desc = "[C]ode [F]ormat" })
			else
				logging.warning(("[format] Executable '%s' not found."):format(config.executable))
			end
		end,
	})
end

---Setups formatting for Lua files.
---@param group any # Neovim augroup.
local function setup_lua(group)
	local config = {
		pattern = { "*.lua" },
		executable = "stylua",
		cmd_fn = function(filename)
			return "!stylua " .. filename
		end,
	}
	setup_code_format_autocmd(config, group)
end

---Setups formatting for Python files.
---@param group any # Neovim augroup.
local function setup_python(group)
	local config = {
		pattern = { "*.py" },
		executable = "ruff",
		cmd_fn = function(filename)
			return "!ruff format " .. filename
		end,
	}
	setup_code_format_autocmd(config, group)
end

---Setups formatting for C files.
---@param group any # Neovim augroup.
local function setup_c(group)
	local config = {
		pattern = { "*.c", "*.h" },
		executable = "clang-format",
		cmd_fn = function(filename)
			return "!clang-format -style=llvm -i " .. filename
		end,
	}
	setup_code_format_autocmd(config, group)
end

---Setups formatting for json files.
---@param group any # Neovim augroup
local function setup_json(group)
	local config = {
		pattern = {"*.json"},
		executable = "jq",
		cmd_fn = function(_)
			return "%!jq"
		end
	}
	setup_code_format_autocmd(config, group)
end

---Main entrypoint.
local function main()
	local group = vim.api.nvim_create_augroup("CodeFormat", {})
	setup_lua(group)
	setup_python(group)
	setup_c(group)
	setup_json(group)
end

main()
