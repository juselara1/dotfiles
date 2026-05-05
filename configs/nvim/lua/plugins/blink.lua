return {
	"saghen/blink.cmp",
	version = "1.*",
	opts = {
		completion = {
			ghost_text = { enabled = true },
			list = { selection = { auto_insert = false, preselect = false } },
		},
		fuzzy = { implementation = "prefer_rust" },
		signature = { enabled = true },
	},
}
