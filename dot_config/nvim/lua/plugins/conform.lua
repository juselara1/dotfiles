---Setups the conform plugin
local function setup()
	local conform = require("conform")
	conform.setup({
		formatters_by_ft = {
			fennel = { "fnlfmt" },
			lua = { "stylua" },
			python = { "ruff_format" },
			json = { "jq" },
			c = { "clang-format" },
			terraform = { "terraform_fmt" },
		},
	})
	vim.keymap.set("n", "<leader>cf", function()
		conform.format({ bufnr = 0 })
	end, {
		noremap = true,
		silent = true,
		desc = "[C]ode [F]ormat",
	})
end

return {
	"stevearc/conform.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = { { "<leader>cf", desc = "[C]ode [F]ormat" } },
	config = setup,
}
