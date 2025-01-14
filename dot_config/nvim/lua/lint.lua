local fn = require("functions")

---@class Linter # Properties of a linter.
---@field executable string # Executable command to validate.
---@field lint_fn function() : nil # Function that executes the linter.

---@class LintConfig # Language specific configuration for linting.
---@field pattern string # Pattern to match a programming language.
---@field linters Linter[] # Linters for a programming language.

---Setups the :Lint command to invoke different linters.
---@param linters Linter[] # List of linters.
local function setup_lint_command(linters)
	vim.api.nvim_create_user_command("Lint", function(_)
		local valid_linters = fn.filter(function(linter)
			return vim.fn.executable(linter.executable)
		end, linters)
		if #valid_linters == 0 then
			vim.notify("Could not find any valid linter", vim.log.levels.ERROR)
		elseif #valid_linters == 1 then
			valid_linters[1].lint_fn()
		else
			vim.ui.select(
				fn.map(function(linter)
					return linter.executable
				end, linters),
				{ prompt = "Select a linter:" },
				function(executable)
					local linter = fn.filter(function(linter)
						return linter.executable == executable
					end, linters)[1]
					linter.lint_fn()
				end
			)
		end
	end, {
		nargs = 0,
		desc = "Select linter.",
	})
end

---Setup lint autocommand.
---@param config LintConfig # Language specific configuration.
---@param group any # Neovim augroup.
local function setup_lint_autocmd(config, group)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		group = group,
		desc = "Sets the lint command.",
		pattern = config.pattern,
		callback = function(_)
			setup_lint_command(config.linters)
		end,
	})
end

---Setups linters for lua.
---@param group any # Neovim augroup.
local function setup_lua(group)
	local config = {
		pattern = { "*.lua" },
		linters = {
			{
				executable = "luacheck",
				lint_fn = function()
					vim.o.errorformat = "%f:%l:%c: %m"
					local output = vim.fn.system("luacheck --no-color .")
					vim.fn.setqflist({}, "r", { title = "luacheck", lines = vim.split(output, "\n") })
				end,
			},
		},
	}
	setup_lint_autocmd(config, group)
end

---Setups linters for Python
---@param group any # Neovim augroup.
local function setup_python(group)
  local config = {
    pattern = { "*.py" },
    linters = {
      {
        executable = "mypy",
        lint_fn = function()
					vim.o.errorformat = "%f:%l:%c: %m"
					local output = vim.fn.system("mypy --show-column-numbers .")
					vim.fn.setqflist({}, "r", { title = "mypy", lines = vim.split(output, "\n") })
        end
      },
      {
        executable = "ruff",
        lint_fn = function()
					vim.o.errorformat = "%f:%l:%c: %m"
					local output = vim.fn.system("ruff check --output-format concise .")
					vim.fn.setqflist({}, "r", { title = "ruff", lines = vim.split(output, "\n") })
        end
      }
    }
  }
	setup_lint_autocmd(config, group)
end

---Main entrypoint.
local function main()
	local group = vim.api.nvim_create_augroup("Lint", {})
	setup_lua(group)
  setup_python(group)
end

main()
