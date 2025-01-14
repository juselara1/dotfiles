local CompletionItemKind = {
	"text",
	"method",
	"function",
	"constructor",
	"field",
	"variable",
	"class",
	"interface",
	"module",
	"property",
	"unit",
	"value",
	"enum",
	"keyword",
	"snippet",
	"color",
	"file",
	"reference",
	"folder",
	"enum_member",
	"constant",
	"struct",
	"event",
	"operator",
	"type_parameter",
}

local Priority = {
	"snippet",
	"property",
	"enum_member",
	"field",
	"value",
	"constructor",
	"method",
	"constant",
	"variable",
	"function",
	"class",
	"interface",
	"enum",
	"struct",
	"module",
	"unit",
	"keyword",
	"file",
	"folder",
	"text",
	"color",
	"reference",
	"event",
	"operator",
	"type_parameter",
}

local PriorityMapping = {}
for i, val in ipairs(Priority) do
	PriorityMapping[val] = i
end

---Gets the priority for a given item kind.
---@param kind_idx integer # Index of a item kind.
---@return integer # Priority.
local function get_priority(kind_idx)
	return PriorityMapping[CompletionItemKind[kind_idx]]
end

---Setups the cmp plugin for completion.
local function setup()
	local cmp = require("cmp")
	cmp.setup({
		completion = { autocomplete = false },
		snippet = {
			expand = function(args)
				snip = require("luasnip")
				return snip.lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-q>"] = cmp.mapping.abort(),
			["<C-space>"] = cmp.mapping.complete(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-j>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end),
			["<C-k>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "dotenv" },
		}),
		sorting = {
			comparators = {
				cmp.config.compare.exact,
				function(e1, e2)
					return get_priority(e1:get_kind()) < get_priority(e2:get_kind())
				end,
			},
			priority_weight = 1.0,
		},
	})
end

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"SergioRibera/cmp-dotenv",
	},
	keys = {
		{ "<C-Space>", desc = "Completion", mode = { "i", "s" } },
	},
	config = setup
}
