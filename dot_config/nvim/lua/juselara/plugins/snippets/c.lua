local function setup ()
	local ls = require("luasnip")
	local fmt = require("luasnip.extras.fmt").fmt
	local fmta = require("luasnip.extras.fmt").fmta
	local s = ls.snippet
	local sn = ls.snippet_node
	local i = ls.insert_node
	local t = ls.text_node
	local d = ls.dynamic_node
	local function nl() return t{"", ""} end

	local function get_ts_params()
		local function_types = {
			function_definition = true
		}
		local node = vim.treesitter.get_node()
		while node ~= nil do
			if function_types[node:type()] then
				break
			else
				node = node:parent()
			end
		end
		if node == nil then
			return nil
		end
		local query = vim.treesitter.query.get("c", "get-fn-pnames")
		if query then
			local params = {}
			for _, capture, _ in query:iter_captures(node, 0) do
				local text = vim.treesitter.get_node_text(capture, 0)
				table.insert(params, {name=vim.split(text, ' ')[2]})
			end
			return params
		end
	end

	local function docstring_params(params)
		local nodes = {}
		for idx, param in ipairs(params) do
			table.insert(nodes, t(string.format(" @%s ", param.name)))
			table.insert(nodes, i(idx, "pdoc"))
			table.insert(nodes, nl())
		end
		return sn(nil, nodes)
	end

	ls.add_snippets("c", {
		-- Define variable
		s("@var", fmt("{} {} = {};", {i(1, "int"), i(2, "var"), i(3, "1")})),
		-- Import
		s("@import", fmt("#include <{}>", {i(1, "name")})),
		-- Main
		s("@main", fmta(
		[[
		int main(void)
		{
			<body>
			return 0;
		}
		]]
		, {body=i(1, ';')}
		)),
		-- Define function
		s("@fn", fmta(
		[[
		/*
		 * <docstring>
		<doc_params>
		 * @return <rdoc>
		*/
		<rtype> <name>(<params>) {
			<body>
		}
		]], {
			rtype=i(1, "int"), name=i(2, "name"), params=i(3, "void"),
			docstring=i(4, "docstring"),
			doc_params=d(5, function(_)
				local params = get_ts_params()
				if params then
					return docstring_params(params)
				else
					return sn(nil, t'')
				end
			end, {3}),
			rdoc=i(6, "rdoc"), body=i(7, ";;")
		}
		)),
	})
end

return {
	setup = setup
}
