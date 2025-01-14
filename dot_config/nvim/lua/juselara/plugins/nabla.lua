return {
	"jbyuki/nabla.nvim",
	keys = {
		{
			"<leader>n",
			desc = "Render equation using Nabla"
		},
	},
	config = function()
		vim.keymap.set(
			'n', "<leader>n", function ()
				require("nabla").popup()
			end,
			{
				noremap = true, silent=false,
				desc="Render equations using nabla."
				}
			)
	end
}
