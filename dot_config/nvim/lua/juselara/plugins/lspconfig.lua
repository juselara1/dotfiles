return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile"},
	dependencies = {
		"williamboman/mason.nvim",
		"folke/neodev.nvim"
	},
	config = function()
		local set_keymaps = function(buffer)
			vim.keymap.set( 'n', "<leader>lh", vim.lsp.buf.hover,
				{noremap = true, silent=true, desc="LSP hover", buffer=buffer}
				)
			vim.keymap.set( 'n', "<leader>ld", vim.lsp.buf.definition,
				{noremap = true, silent=true, desc="LSP definition", buffer=buffer}
				)
			vim.keymap.set( 'n', "<leader>li", vim.lsp.buf.definition,
				{noremap = true, silent=true, desc="LSP implentation", buffer=buffer}
				)
			vim.keymap.set( 'n', "<leader>ls", vim.lsp.buf.signature_help,
				{noremap = true, silent=true, desc="LSP signature", buffer=buffer}
				)
			vim.keymap.set( 'n', "<leader>lr", vim.lsp.buf.rename,
				{noremap = true, silent=true, desc="LSP rename", buffer=buffer}
				)
			vim.keymap.set( 'n', "<leader>lf", vim.lsp.buf.references,
				{noremap = true, silent=true, desc="LSP references", buffer=buffer}
				)
		end

		require("neodev").setup()
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup {
			on_attach = function (_, buffer)
				set_keymaps(buffer)
			end,
			settings = {
				Lua = {
					telemetry = {enable = false},
					workspace = {checkThirdParty = false}
				}
			},
			filetypes = {"lua"},
			root_dir = lspconfig.util.root_pattern(".git")
		}
		lspconfig.jedi_language_server.setup {
			on_attach = function (_, buffer)
				set_keymaps(buffer)
			end,
			filetypes = {"python"},
			single_file_support = false,
			root_dir = lspconfig.util.root_pattern(".git")
		}
		lspconfig.clangd.setup {
			on_attach = function (_, buffer)
				set_keymaps(buffer)
			end,
			filetypes = {'c', "cuda"},
			root_dir = lspconfig.util.root_pattern(".git"),
		}
		lspconfig.terraformls.setup {
			on_attach = function (_, buffer)
				set_keymaps(buffer)
			end,
			filetypes = {"terraform"},
			root_dir = lspconfig.util.root_pattern(".git"),
		}
		lspconfig.tflint.setup {
			on_attach = function (_, buffer)
				set_keymaps(buffer)
			end,
			filetypes = {"terraform"},
			root_dir = lspconfig.util.root_pattern(".git"),
		}
		lspconfig.texlab.setup {
			on_attach = function (_, buffer)
				set_keymaps(buffer)
			end,
			filetypes = {"latex", "tex"},
			root_dir = lspconfig.util.root_pattern(".git"),
		}
		lspconfig.gopls.setup {
			on_attach = function (_, buffer)
				set_keymaps(buffer)
			end,
			filetypes = {"go"},
			root_dir = lspconfig.util.root_pattern(".git"),
		}
	end
}
