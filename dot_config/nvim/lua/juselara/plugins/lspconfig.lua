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

		-- Terraform config
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

		-- Autocmds
		vim.api.nvim_create_autocmd({"BufWritePost"}, {
			pattern = {"*.tf", "*.tfvars"},
			group = "AutoFormat",
			callback = function()
				vim.cmd("silent !terraform fmt %")
				vim.cmd("edit")
			end,
		})
		vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
			pattern = {"*.tf", "*.tfvars"},
			callback = function(ev)
				vim.bo[ev.buf].syntax = "terraform"
				vim.bo[ev.buf].filetype = "terraform"
			end
		})
	end
}
