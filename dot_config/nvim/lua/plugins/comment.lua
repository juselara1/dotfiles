---Configures the Comment plugin.
local function setup()
	require("Comment").setup({
		sticky = false,
		opleader = { line = "gc" },
		mappings = { basic = true, extra = false },
	})
end

return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = setup,
}
