local F = require("functions")

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
			fmta("<name> = <value>", { name = i(1, "name"), value = i(2, "None") }),
			fmta("<name> : <type> = <value>", { name = i(1, "name"), type = i(2, "None"), value = i(3, "None") }),
		})
	)
end

---Defines the snippet to import packages.
---@param s any # Snippet
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function import_snippet(s, c, i, fmta)
	return s(
		"@import",
		c(1, {
			fmta("import <module>", { module = i(1, "os") }),
			fmta("import <module> as <alias>", { module = i(1, "os"), alias = i(2, "os") }),
			fmta("from <module> import <submodule>", { module = i(1, "os"), submodule = i(2, "listdir") }),
			fmta(
				"from <module> import <submodule> as <alias>",
				{ module = i(1, "os"), submodule = i(2, "listdir"), alias = i(3, "ls") }
			),
		})
	)
end

---Defines the snippet for functions.
---@param s any # Snippet
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function fn_snippet(s, c, i, fmta)
	return s(
		"@fn",
		c(1, {
			fmta(
				[[def <name>(<params>) ->> <rtype>:
    <body>]],
				{ name = i(1, "name"), params = i(2, ""), rtype = i(3, "None"), body = i(4, "...") }
			),
			fmta("lambda <params> : <body>", { params = i(1, ""), body = i(2, "...") }),
		})
	)
end

---Defines the snippet for a for loop.
---@param s any # Snippet
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function for_snippet(s, c, i, fmta)
	return s(
		"@for",
		c(1, {
			fmta(
				[[for <element> in <iterable>:
    <body>]],
				{ element = i(1, "i"), iterable = i(2, "iterable"), body = i(3, "...") }
			),
			fmta(
				[[for <index>, <value> in enumerate(<iterable>):
    <body>]],
				{ index = i(1, "i"), value = i(2, "value"), iterable = i(3, "iterable"), body = i(4, "...") }
			),
		})
	)
end

---Defines the snippet for classes.
---@param s any # Snippet
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function class_snippet(s, c, i, fmta)
	return s(
		"@class",
		c(1, {
			fmta(
				[[class <name>(<super>):
    <body>]],
				{ name = i(1, "Class"), super = i(2, ""), body = i(3, "...") }
			),
			fmta(
				[[class <name>(ABC):
    <body>]],
				{ name = i(1, "Class"), body = i(2, "...") }
			),
		})
	)
end

---Defines the snippet for methods.
---@param s any # Snippet
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function method_snippet(s, c, i, fmta)
	return s(
		"@method",
		c(1, {
			fmta(
				[[def <name>(self, <params>) ->> <rtype>:
    <body>
]],
				{ name = i(1, "name"), params = i(2, ""), rtype = i(3, "None"), body = i(4, "...") }
			),
			fmta(
				[[@abstractmethod
def <name>(self, <params>) ->> <rtype>:
    <body>]],
				{ name = i(1, "name"), params = i(2, ""), rtype = i(3, "None"), body = i(4, "...") }
			),
		})
	)
end

---Defines the snippet for dataclasses.
---@param s any # Snippet
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function dataclass_snippet(s, c, i, fmta)
	return s(
		"@dataclass",
		c(1, {
			fmta(
				[[class <name>(BaseModel):
    <body>]],
				{ name = i(1, "Class"), body = i(2, "...") }
			),
			fmta(
				[[@dataclass
class <name>():
    <body>]],
				{ name = i(1, "Class"), body = i(2, "...") }
			),
		})
	)
end

---Defines the snippet for dataclass fields
---@param s any # Snippet
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function dataclass_field_snippet(s, c, i, fmta)
	return s(
		"@dataclass-field",
		c(1, {
			fmta("<name> : <type>", { name = i(1, "name"), type = i(2, "None") }),
			fmta("<name> : <type> = <value>", { name = i(1, "name"), type = i(2, "None"), value = i(3, "None") }),
			fmta(
				[[<name> : <type> = Field(description="<description>")]],
				{ name = i(1, "name"), type = i(2, "None"), description = i(3, "Description") }
			),
		})
	)
end

---Defines the snippet for enums.
---@param s any # Snippet
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function enum_snippet(s, c, i, fmta)
	return s(
		"@enum",
		c(1, {
			fmta(
				[[class <name>(Enum):
    <body>]],
				{ name = i(1, "Class"), body = i(2, "...") }
			),
			fmta(
				[[class <name>(StrEnum):
    <body>]],
				{ name = i(1, "Class"), body = i(2, "...") }
			),
		})
	)
end

---Defines the snippet for enum members.
---@param s any # Snippet
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function enum_member_snippet(s, i, fmta)
	return s("@enum-member", fmta("<name> = auto()", { name = i(1, "NAME") }))
end

local FnTypes = { "function_definition", "method_definition", "func_literal" }
local ClassTypes = { "class_definition" }

---Validates if a treesitter node is suitable for docstring generation.
---@param node any # Current node.
---@return boolean # Validation.
local function validate_ts_docstring_node(node)
	local node_type = node:type()
	return F.in_table(FnTypes, node_type) or F.in_table(ClassTypes, node_type)
end

---Finds the parent node that is more suitable for docstring generation.
---@param node any # Node.
---@return any | nil # Parent node.
local function detect_ts_docstring_node(node)
	if node == nil then
		return node
	elseif validate_ts_docstring_node(node) then
		return node
	else
		return detect_ts_docstring_node(node:parent())
	end
end

---Extracts all captures from a treesitter query.
---@param node any # Node
---@param query any # Treesitter query.
---@return string[] # Captures.
local function get_treesitter_captures(node, query)
	local elements = {}
	for _, capture in query:iter_captures(node, 0) do
		table.insert(elements, vim.treesitter.get_node_text(capture, 0))
	end
	return elements
end

---@alias Param {param: string, type: string} # Single function's parameter.

---Extracts function parameters using treesitter queries.
---@param node any # Node.
---@return Param[] # Parsed parameters.
local function get_fn_params(node)
	local param_names_q = vim.treesitter.query.get("python", "get-fn-pnames")
	local param_types_q = vim.treesitter.query.get("python", "get-fn-ptypes")
	return F.zip(
		get_treesitter_captures(node, param_names_q),
		get_treesitter_captures(node, param_types_q),
		"param",
		"type"
	)
end

---Extract function return type using a treesitter query.
---@param node any # Node.
---@return string # Return type.
local function get_fn_rtype(node)
	return get_treesitter_captures(node, vim.treesitter.query.get("python", "get-fn-rtype"))[1]
end

---Generates restructured text docstring for functions.
---@param params Param[] # Parsed parameters.
---@param rtype string # Return type.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet.
local function restructured_text_fn(params, rtype, i, fmta)
	local formatted_params = F.strjoin(
		F.icollect(function(index, param)
			return (":param %s: <description%s>\n:type %s: %s"):format(param.param, index + 1, param.param, param.type)
		end, params),
		"\n"
	)
	local fields = {
		description = i(1, "ReStructuredText"),
		rdoc = i(#params + 2, "description"),
	}
	for index, _ in ipairs(params) do
		fields["description" .. (index + 1)] = i(index + 1, "description")
	end
	return fmta(
		([["""
<description>

%s
:returns: <rdoc>
:rtype: %s
"""]]):format(formatted_params, rtype),
		fields
	)
end

---Generats numpydoc docstring for functions.
---@param params Param[] # Parsed parameters.
---@param rtype string # Return type.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet.
local function numpy_doc_fn(params, rtype, i, fmta)
	local formatted_params = F.strjoin(
		F.icollect(function(index, param)
			return ("%s : %s\n    <description%s>"):format(param.param, param.type, index + 1)
		end, params),
		"\n"
	)
	local fields = {
		description = i(1, "NumpyDoc"),
		rdoc = i(#params + 2, "description"),
	}
	for index, _ in ipairs(params) do
		fields["description" .. (index + 1)] = i(index + 1, "description")
	end

	return fmta(
		([["""
<description>

Parameters
----------
%s

Returns
-------
%s
    <rdoc>
"""]]):format(formatted_params, rtype),
		fields
	)
end

---Generats numpydoc docstring for functions.
---@param params Param[] # Parsed parameters.
---@param rtype string # Return type.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet.
local function google_doc_fun(params, rtype, i, fmta)
	local formatted_params = F.strjoin(
		F.icollect(function(index, param)
			return ("    %s (%s): <description%s>"):format(param.param, param.type, index + 1)
		end, params),
		"\n"
	)
	local fields = {
		description = i(1, "GoogleDoc"),
		rdoc = i(#params + 2, "description"),
	}
	for index, _ in ipairs(params) do
		fields["description" .. (index + 1)] = i(index + 1, "description")
	end
	return fmta(
		([["""
<description>

Args:
%s

Returns:
    %s: <rdoc>
"""]]):format(formatted_params, rtype),
		fields
	)
end

---Generates the snippets for functions' docstrings.
---@param node any # Node.
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet.
local function fn_docstring(node, c, i, fmta)
	local params = get_fn_params(node)
	local rtype = get_fn_rtype(node)
	return c(1, {
		restructured_text_fn(params, rtype, i, fmta),
		numpy_doc_fn(params, rtype, i, fmta),
		google_doc_fun(params, rtype, i, fmta),
	})
end

---Extracts class parameters using treesitter queries.
---@param node any # Node.
---@return Param[] # Parsed paramaters.
local function get_class_params(node)
	local param_names_q = vim.treesitter.query.get("python", "get-class-pnames")
	local param_types_q = vim.treesitter.query.get("python", "get-class-ptypes")
	return F.zip(
		get_treesitter_captures(node, param_names_q),
		get_treesitter_captures(node, param_types_q),
		"param",
		"type"
	)
end

---Generates restructured text docstring for classes.
---@param params Param[] # Parsed parameters.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function restructured_text_class(params, i, fmta)
	local formatted_params = F.strjoin(
		F.icollect(function(index, param)
			return (":param %s: <description%s>\n:type %s: %s"):format(param.param, index + 1, param.param, param.type)
		end, params),
		"\n"
	)
	local fields = { description = i(1, "ReStructuredText") }
	for index, _ in ipairs(params) do
		fields["description" .. (index + 1)] = i(index + 1, "description")
	end
	return fmta(
		([["""
<description>

%s
"""]]):format(formatted_params),
		fields
	)
end

---Generates numpydoc docstring for classes.
---@param params Param[] # Parsed parameters.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function numpy_doc_class(params, i, fmta)
	local formatted_params = F.strjoin(
		F.icollect(function(index, param)
			return ("%s : %s\n    <description%s>"):format(param.param, param.type, index + 1)
		end, params),
		"\n"
	)
	local fields = { description = i(1, "NumpyDoc") }
	for index, _ in ipairs(params) do
		fields["description" .. (index + 1)] = i(index + 1, "description")
	end

	return fmta(
		([["""
<description>

Parameters
----------
%s
"""]]):format(formatted_params),
		fields
	)
end

---Generates googledoc docstring for classes.
---@param params Param[] # Parsed parameters.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function google_doc_class(params, i, fmta)
	local formatted_params = F.strjoin(
		F.icollect(function(index, param)
			return ("    %s (%s): <description%s>"):format(param.param, param.type, index + 1)
		end, params),
		"\n"
	)
	local fields = { description = i(1, "GoogleDoc") }
	for index, _ in ipairs(params) do
		fields["description" .. (index + 1)] = i(index + 1, "description")
	end

	return fmta(
		([["""
<description>

Attributes:
%s
"""]]):format(formatted_params),
		fields
	)
end

---Generates the snippets for classes' docstrings.
---@param node any # Node
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet.
local function class_docstring(node, c, i, fmta)
	local params = get_class_params(node)
	return c(1, {
		restructured_text_class(params, i, fmta),
		numpy_doc_class(params, i, fmta),
		google_doc_class(params, i, fmta),
	})
end

---Determines if docstring is for functions or classes.
---@param node any # Node.
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet.
local function handle_docstring_type(node, c, i, fmta)
	if F.in_table(FnTypes, node:type()) then
		return fn_docstring(node, c, i, fmta)
	else
		return class_docstring(node, c, i, fmta)
	end
end

---Defines the snippet for docstrings.
---@param s any # Snippet
---@param c any # Choice node.
---@param i any # Insert node.
---@param fmta any # Format node.
---@return any # Snippet
local function docstring_snippet(s, c, i, fmta, d, sn, t)
	return s(
		"@docstring",
		d(1, function()
			local node = detect_ts_docstring_node(vim.treesitter.get_node())
			if node == nil then
				return sn(nil, t(""))
			else
				return sn(nil, handle_docstring_type(node, c, i, fmta))
			end
		end)
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
	local d = ls.dynamic_node
	local sn = ls.snippet_node
	local t = ls.text_node

	ls.add_snippets("python", {
		var_snippet(s, c, i, fmta),
		import_snippet(s, c, i, fmta),
		fn_snippet(s, c, i, fmta),
		for_snippet(s, c, i, fmta),
		class_snippet(s, c, i, fmta),
		method_snippet(s, c, i, fmta),
		dataclass_snippet(s, c, i, fmta),
		dataclass_field_snippet(s, c, i, fmta),
		enum_snippet(s, c, i, fmta),
		enum_member_snippet(s, i, fmta),
		docstring_snippet(s, c, i, fmta, d, sn, t),
	})
end

setup()
