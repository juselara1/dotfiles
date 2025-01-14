---Defines the snippet to create variables.
---@param s any # Snippet.
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet.
local function var_snippet(s, c, i, fmta)
	return s(
		"@var",
		c(1, {
			fmta("<name> = <value>", { name = i(1, "name"), value = i(2, "value") }),
			fmta("local <name> = <value>", { name = i(1, "name"), value = i(2, "value") }),
		})
	)
end

---Defines the snippet to import packages.
---@param s any # Snippet.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function import_snippet(s, i, fmta)
	return s(
		"@import",
		fmta('local <name> = require("<module>")', {
			name = i(1, "name"),
			module = i(2, "module"),
		})
	)
end

---Defines the snippet for functions.
---@param s any # Snippet.
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function fn_snippet(s, c, i, fmta)
	return s(
		"@fn",
		c(1, {
			fmta(
				[[function <name>(<params>)
	<body>
end]],
				{ name = i(1, "name"), params = i(2, ""), body = i(3, "body") }
			),
			fmta(
				[[local function <name>(<params>)
	<body>
end]],
				{ name = i(1, "name"), params = i(2, ""), body = i(3, "body") }
			),
			fmta("function (<params>) <body> end", { params = i(1, ""), body = i(2, "body") }),
		})
	)
end

---Defines the snippet for a for loop.
---@param s any # Snippet.
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function for_snippet(s, c, i, fmta)
	return s(
		"@for",
		c(1, {
			fmta(
				[[for <key>, <value> in pairs(<iterable>) do
	<body>
end)]],
				{ key = i(1, "key"), value = i(2, "value"), iterable = i(3, "iterable"), body = i(4, "body") }
			),
			fmta(
				[[for <index>, <value> in ipairs(<iterable>) do
	<body>
end]],
				{ index = i(1, "index"), value = i(2, "value"), iterable = i(3, "iterable"), body = i(4, "body") }
			),
		})
	)
end

---Defines the snippet for classes.
---@param s any # Snippet.
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function class_snippet(s, c, i, fmta)
	return s(
		"@class",
		c(1, {
			fmta(
				[[local <name> = {}
<name>.__index = <name>

function <name>:new(<params>)
	return setmetatable({<params>}, self)
end

setmetatable(<name>, { __call = <name>.new})]],
				{ name = i(1, "Class"), params = i(2, "") },
				{ repeat_duplicates = true }
			),
			fmta(
				[[local <name> = {}
<name>.__index = <name>
setmetatable(<name>, {__index = <super>})

function <name>:new(<params>)
	return setmetatable({<params>}, self)
end]],
				{ name = i(1, "Class"), super = i(2, "Super"), params = i(3, "")},
				{ repeat_duplicates = true }
			),
		})
	)
end

---Setups Lua snippets.
local function setup()
	local ls = require("luasnip")
	local fm = require("luasnip.extras.fmt")
	local fmta = fm.fmta
	local s = ls.snippet
	local i = ls.insert_node
	local c = ls.choice_node

	ls.add_snippets("lua", {
		var_snippet(s, c, i, fmta),
		import_snippet(s, i, fmta),
		fn_snippet(s, c, i, fmta),
		for_snippet(s, c, i, fmta),
		class_snippet(s, c, i, fmta),
	})
end

setup()
