local logging = require("logging")

---Extracts the root dir of a buffer.
---@param buffer integer # Buffer.
---@param root_pattern string[] # Pattern to identify the root directory.
---@return string # Root directory.
local function get_root_dir(buffer, root_pattern)
	local fname = vim.api.nvim_buf_get_name(buffer)
	local project = vim.fs.find(root_pattern, { path = fname, upward = true })[1]
	local root_dir
	if project then
		root_dir = vim.fs.dirname(project)
	else
		root_dir = vim.fn.getcwd()
	end
	return root_dir
end

---@class LspConfig # Language specific configuration for LSP.
---@field pattern string[] # Pattern to match the files.
---@field executable string # Executable command to validate.
---@lsp_fn function(integer) : nil # Function that setups the lsp server.

---Setup LSP keybindings.
local function setup_lsp_keybindings()
	vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { silent = true, noremap = true, desc = "[L]sp [H]over" })
	vim.keymap.set(
		"n",
		"<leader>ld",
		vim.lsp.buf.definition,
		{ silent = true, noremap = true, desc = "[L]sp [D]efinition" }
	)
	vim.keymap.set(
		"n",
		"<leader>li",
		vim.lsp.buf.implementation,
		{ silent = true, noremap = true, desc = "[L]sp [I]mplementation" }
	)
	vim.keymap.set(
		"n",
		"<leader>ls",
		vim.lsp.buf.signature_help,
		{ silent = true, noremap = true, desc = "[L]sp [S]ignature" }
	)
	vim.keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, { silent = true, noremap = true, desc = "[L]sp [R]e[N]ame" })
	vim.keymap.set(
		"n",
		"<leader>lrf",
		vim.lsp.buf.references,
		{ silent = true, noremap = true, desc = "[L]sp [R]e[F]erences" }
	)
end

---Setup lsp autocomand.
---@param config LspConfig # Language specific configuration.
---@param group any # Neovim augroup.
local function setup_lsp_autocmd(config, group)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		group = group,
		desc = "Setups the LSP.",
		pattern = config.pattern,
		callback = function(ev)
			if vim.fn.executable(config.executable) == 1 then
				logging.info(("[lsp] Executable '%s' found in path."):format(config.executable))
				setup_lsp_keybindings()
				config.lsp_fn(ev.buf)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
			else
				logging.warning(("[lsp] Executable '%s' not found."):format(config.executable))
			end
		end,
	})
end

---Setups lsp for Lua files.
---@param group any # Neovim augroup.
local function setup_lua(group)
	setup_lsp_autocmd({
		pattern = { "*.lua" },
		executable = "lua-language-server",
		lsp_fn = function(buffer)
			vim.lsp.start({
				name = "luals",
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_dir = get_root_dir(buffer, { ".git" }),
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdPArty = false },
						telemetry = { enable = false },
					},
				},
			})
		end,
	}, group)
end

---Setups lsp for Python files.
---@param group any # Neovim augroup.
local function setup_python(group)
	setup_lsp_autocmd({
		pattern = { "*.py" },
		executable = "jedi-language-server",
		lsp_fn = function(buffer)
			vim.lsp.start({
				name = "jedi",
				cmd = { "jedi-language-server" },
				filetypes = { "python" },
				root_dir = get_root_dir(buffer, { ".git", "pyproject.toml", "setup.py" }),
			})
		end,
	}, group)
end

---Setups lsp for C files.
---@param group any # Neovim augroup.
local function setup_c(group)
	setup_lsp_autocmd({
		pattern = { "*.c" },
		executable = "clangd",
		lsp_fn = function(buffer)
			vim.lsp.start({
				name = "clang",
				cmd = { "clangd" },
				filetypes = { "c" },
				root_dir = get_root_dir(buffer, { ".git" }),
			})
		end,
	}, group)
end

---Main entrypoint.
local function main()
	vim.diagnostic.enable(false)
	local group = vim.api.nvim_create_augroup("Lsp", {})
	setup_lua(group)
	setup_python(group)
	setup_c(group)
end

main()
