---Setup the luasnip plugin.
local function setup()
	local luasnip = require("luasnip")
	luasnip.setup({ update_events = { "TextChanged", "TextChangedI" } })
	vim.keymap.set({ "i", "s" }, "<C-j>", function()
		luasnip.expand_or_jump()
	end, { silent = true, noremap = true, desc = "Expand snippet" })
	vim.keymap.set({ "i", "s" }, "<C-k>", function()
		luasnip.jump(-1)
	end, { silent = true, noremap = true, desc = "Previous snippet" })
	vim.keymap.set({ "i", "s" }, "<C-n>", function()
		if luasnip.choice_active() then
			luasnip.change_choice(1)
		end
	end, { silent = true, noremap = true, desc = "Switch snippet" })
end

return {
	"L3MON4D3/LuaSnip",
	config = setup,
	keys = {
		{ "<C-j>", desc = "Expand snippet", mode = { "i", "s" } },
	},
}
