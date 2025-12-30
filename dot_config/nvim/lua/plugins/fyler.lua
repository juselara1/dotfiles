return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	branch = "stable",
	config = function()
		local fyler = require("fyler")
		local config = require("fyler.config").defaults()
		config.views.finder.mappings = {
			["q"] = "CloseView",
			["<CR>"] = "Select",
			["<C-t>"] = "SelectTab",
			["<C-v>"] = "SelectVSplit",
			["<C-s>"] = "SelectSplit",
			["="] = "GotoCwd",
			["-"] = "GotoParent",
			["+"] = "GotoNode",
			["<C-k>"] = "CollapseAll",
			["<BS>"] = "CollapseNode",
		}
		config.views.finder.win.win_opts.number = true
		config.views.finder.win.win_opts.relativenumber = true
		fyler.setup(config)
	end,
	keys = {
		{
			"<leader>e",
			function()
				require("fyler").open({ kind = "split_left_most" })
			end,
			desc = "[E]dit file",
		},
	},
}
