return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		sticky = false,
		opleader = {
			line = "gc"
		},
		mappings = {
			basic = true,
			extra = false
		}
	}
}
