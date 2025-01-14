return {
	"hrsh7th/nvim-cmp",
	event = { "BufReadPre", "BufNewFile"},
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"neovim/nvim-lspconfig"
	},
	config = function()
		local cmp = require("cmp")
		local compare = cmp.config.compare
		local priority = {
			[1] = 11,
			[2] = 4,
			[3] = 3,
			[4] = 5,
			[5] = 1,
			[6] = 2,
			[7] = 6,
			[8] = 7,
			[9] = 8,
			[10] = 9,
			[11] = 12,
			[12] = 10,
			[13] = 13,
			[14] = 14,
			[15] = 15,
			[16] = 16,
			[17] = 17,
			[18] = 18,
			[19] = 19,
			[20] = 20,
			[21] = 21,
			[22] = 22,
			[23] = 23,
			[24] = 24,
			[25] = 25,
		}
		cmp.setup {
			completion = {
				autocomplete = false
			},
			snippet = {
				expand = function (args)
					require("luasnip").lsp_expand(args.body)
				end
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-q>"] = cmp.mapping.abort(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({select = true}),
				["<C-j>"] = cmp.mapping(function (fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, {"i"}
				),
				["<C-k>"] = cmp.mapping(function (fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, {"i"}
				),
			}),
			sources = cmp.config.sources({
				{name = "nvim_lsp"},
				{name = "luasnip"},
				{name = "buffer"},
				{name = "path"},
				{name = "buffer"},
			}),
			sorting = {
				comparators = {
					compare.exact,
					function (entry1, entry2)
						local kind1 = priority[entry1:get_kind()]
						local kind2 = priority[entry2:get_kind()]
						if kind1 < kind2 then
							return true
						end
					end
				},
				priority_weight=1.0
			}
		}

	end
}
