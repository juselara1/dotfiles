---Setups the live-command plugin.
local function setup()
	require("live-command").setup({
		commands = {
			Norm = { cmd = "norm" },
			Global = { cmd = "global" },
		},
	})
end

return {
	"smjonas/live-command.nvim",
	config = setup,
	cmd = { "Norm", "Global", "Preview" },
}
