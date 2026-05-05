local function main()
	vim.diagnostic.enable(false)
	vim.lsp.config("*", {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
	})
	vim.lsp.enable({ "lua_ls", "jedi_language_server" })
end

main()
