return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup {
			custom_textobjects = {
				---Select all buffer
				g = function()
					local from = { line = 1, col = 1 }
					local to = {
					  line = vim.fn.line('$'),
					  col = math.max(vim.fn.getline('$'):len(), 1)
					}
					return { from = from, to = to }
				end,
				---Code cell
				x = { "```%S*%s()[^`]+()```" }
			},
			mappings = {
				-- Main textobject prefixes
				around = 'a',
				inside = 'i',
			},
			search_method = "cover_or_next",
			silent = true
		}
	end
}
