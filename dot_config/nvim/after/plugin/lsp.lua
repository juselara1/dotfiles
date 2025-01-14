vim.api.nvim_create_autocmd(
	{"BufEnter"}, {
		group = vim.api.nvim_create_augroup("lsp-attach", {clear = true}),
		callback = function(event)
			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, {noremap = true, silent = true, desc = "[L]sp [H]over", buffer = event.buf})
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, {noremap = true, silent = true, desc = "[L]sp [D]efinition", buffer = event.buf})
			vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, {noremap = true, silent = true, desc = "[L]sp [I]mplementation", buffer = event.buf})
			vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, {noremap = true, silent = true, desc = "[L]sp [S]ignature", buffer = event.buf})
			vim.keymap.set("n", "<leader>lre", vim.lsp.buf.rename, {noremap = true, silent = true, desc = "[L]sp [R][E]name", buffer = event.buf})
			vim.keymap.set("n", "<leader>lrf", vim.lsp.buf.references, {noremap = true, silent = true, desc = "[L]sp [R]e[F]erences", buffer = event.buf})
		end
	}
)
