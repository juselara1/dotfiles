---Configuration for the indentmini plugin.
local function setup()
	require("indentmini").setup({
		only_current = true
	})
end

return {
	"nvimdev/indentmini.nvim",
	config = setup
}
