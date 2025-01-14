local function setup ()
	local ls = require("luasnip")
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node

	ls.add_snippets("lua", {
		s("var", {
            t("local "),
			i(1, "name"),
			t(" = "),
			i(2, "value")
        })
	})
end

return {
	setup = setup
}
