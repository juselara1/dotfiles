
local function setup ()
	local ls = require("luasnip")
	local fmt = require("luasnip.extras.fmt").fmt
	local fmta = require("luasnip.extras.fmt").fmta
	local s = ls.snippet
	local sn = ls.snippet_node
	local i = ls.insert_node
	local t = ls.text_node
	local c = ls.choice_node
	local f = ls.function_node
	local d = ls.dynamic_node
	local function nl() return t{"", ""} end

	--- Generates docstring for function's parameters.
	---@param params {name: string, type: string}[]
	---@return any
	local function docstring_params(params)
		local nodes = {}
		for idx, param in ipairs(params) do
			table.insert(nodes, nl())
			table.insert(nodes, t"\t")
			table.insert(nodes, t(string.format(":param %s: ", param.name)))
			table.insert(nodes, i(idx, "pdoc"))
			table.insert(nodes, nl())
			table.insert(nodes, t"\t")
			table.insert(nodes, t(string.format(":type %s: %s", param.name, param.type)))
		end
		return sn(nil, nodes)
	end

	---Obtains treesitter function's parameters.
	---@return {name: string, type: string}[] | nil
	local function get_ts_params()
		local function_types = {
			function_definition = true,
			method_definition = true,
			func_literal = true,
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
		local query1 = vim.treesitter.query.get("python", "get-fn-pnames")
		local query2 = vim.treesitter.query.get("python", "get-fn-ptypes")
		if query1 and query2 then
			local pnames = {}
			for _, capture, _ in query1:iter_captures(node, 0) do
				table.insert(pnames, vim.treesitter.get_node_text(capture, 0))
			end

			local ptypes = {}
			for _, capture, _ in query2:iter_captures(node, 0) do
				table.insert(ptypes, vim.treesitter.get_node_text(capture, 0))
			end

			local typed_params = {}
			for idx=1,#pnames do
				table.insert(typed_params, {name=pnames[idx], type=ptypes[idx]})
			end
			return typed_params
		end
	end

	---Parses class attributes
	---@param params string[]
	---@return {name: string, type: string}[]
	local function get_class_attrs(params)
		local attrs = {}
		for _, param in ipairs(params) do
			local attr = vim.split(param:gsub(' ', ''), ':')
			table.insert(attrs, {name=attr[1], type=attr[2]})
		end
		return attrs
	end

	ls.add_snippets("python", {
		-- Define variable
		s("@var", {
			c(1, {
				fmt("{} = {}", {i(1, "name"), i(2, "value")}),
				fmt("{} : {} = {}", {i(1, "name"), i(2, "type"), i(3, "value")})
			})
		}),
		-- Import
		s("@import", {
			c(1, {
				fmt("import {}", {i(1, "name")}),
				fmt("import {} as {}", {i(1, "name"), i(2, "alias")}),
				fmt("from {} import {}", {i(1, "name"), i(2, "module")}),
				fmt("from {} import {} as {}", {i(1, "name"), i(2, "module"), i(3, "alias")})
			})
		}),
		-- Define function
		s("@fn", fmta(
		[[
		def <name>(<params>) ->> <rtype>:
			"""
			<docstring>
		<doc_params>
			:returns: <rdoc>
			:rtype: <rtype2>
			"""
			<body>
		]], {
			name=i(1, "name"), params=i(2, ""), rtype=i(3, "rtype"),
			docstring=i(4, "docstring"),
			doc_params=d(5, function(_)
				local params = get_ts_params()
				if params then
					return docstring_params(params)
				else
					return sn(nil, t'')
				end
			end, {2}),
			rdoc=i(6, "rdoc"), rtype2=f(function (args) return args[1][1] end, {3}),
			body=i(7, "...")
		}
		)),
		-- Define class
		s("@class", fmta(
		[[
		class <name>(<super>):
			"""
			<docstring>
		<doc_params>
			"""
			<params>

			<body>
		]], {
			name=i(1, "name"), super=i(2, ""), docstring=i(3, "docstring"),
			doc_params=d(5, function(args)
				if args[1][1] == '' then
					return sn(nil, t'')
				end
				local params = get_class_attrs(args[1])
				return docstring_params(params)
			end, {4}), params=i(4, ""), body=i(6, "...")
		}
		)),
		-- ABC
		s("@abc", fmta(
		[[
		class <name>(ABC):
			"""
			<docstring>
		<doc_params>
			"""
			<params>

			<body>
		]], {
			name=i(1, "name"), docstring=i(2, "docstring"),
			doc_params=d(4, function(args)
				if args[1][1] == '' then
					return sn(nil, t'')
				end
				local params = get_class_attrs(args[1])
				return docstring_params(params)
			end, {3}), params=i(3, ""), body=i(5, "...")
		}
		)),
		-- Method
		s("@method", fmta(
		[[
		def <name>(self, <params>) ->> <rtype>:
			"""
			<docstring>
		<doc_params>
			:returns: <rdoc>
			:rtype: <rtype2>
			"""
			<body>
		]], {
			name=i(1, "name"), params=i(2, ""), rtype=i(3, "None"), docstring=i(4, "docstring"),
			doc_params=d(5, function(_)
				local params = get_ts_params()
				if params then
					return docstring_params(params)
				else
					return sn(nil, t'')
				end
			end, {2}),
			rdoc=i(6, "rdoc"), rtype2=f(function(args) return args[1][1] end, {3}),
			body=i(7, "...")
		}
		)),
		-- Init method
		s("@imethod", fmta(
		[[
		def __init__(self, <params>):
		<aparams>
		<body>
		]], {
			params=i(1, ""),
			aparams=f(function(_)
				local params = get_ts_params()
				if params then
					local strs = {}
					for _, param in ipairs(params) do
						table.insert(strs, string.format("\tself.%s = %s", param.name, param.name))
					end
					return strs
				else
					return ''
				end
			end, {1}),
			body=nl()
		}
		)),
		-- Abstract method
		s("@amethod", fmta(
		[[
		@abstractmethod
		def <name>(self, <params>) ->> <rtype>:
			"""
			<docstring>
		<doc_params>
			:returns: <rdoc>
			:rtype: <rtype2>
			"""
			...

		<body>
		]], {
			name=i(1, "name"), params=i(2, ""), rtype=i(3, "None"), docstring=i(4, "docstring"),
			doc_params=d(5, function(_)
				local params = get_ts_params()
				if params then
					return docstring_params(params)
				else
					return sn(nil, t'')
				end
			end, {2}),
			rdoc=i(6, "rdoc"), rtype2=f(function(args) return args[1][1] end, {3}),
			body=t''
		}
		)),
		-- Enum
		s("@enum", fmta(
		[[
		class <name>(<enum>):
			"""
			<docstring>

			opts: {<opts>}
			"""
		<attrs>
		]],
		{
			name=i(1, "name"), enum=i(2, "Enum"), docstring=i(3, "docstring"),
			opts=i(4, ''), attrs=f(function(args)
				if args[1][1] == '' then
					return ''
				end
				local opts = vim.split(args[1][1], ',')
				local strs = {}
				for _, opt in ipairs(opts) do
					table.insert(strs, string.format("\t%s = auto()", opt:gsub(' ', '')))
				end
				return strs
			end, {4})
		}
		)),
		-- For loop
		s({trig="@for:(%w+)", regTrig=true}, fmta(
		[[
		for <var> in <iterable>:
			<body>
		]],
		{
			var=i(1, 'i'), iterable=f(function (_, snip)
				return snip.captures[1]
			end), body=i(2, "...")
		}
		)),
		-- Main
		s("@main", fmta(
		[[
		if __name__ == "__main__":
			<body>
		]],
		{body=t''}
		)),
	})
end

return {
	setup = setup
}
