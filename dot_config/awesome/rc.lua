-- luarocks
pcall(require, "luarocks.loader")

-- local libraries
local path = ';'..os.getenv("HOME").."/.config/awesome/lua/?/init.lua"
package.path = package.path .. path

---Setup
---@param libraries string[]
local function setup(libraries)
	for _, lib in ipairs(libraries) do
		local module = require(lib)
		module.setup({root=root, awesome=awesome, client=client})
	end
end

--- Modules
local modules = {
    "theme", "keybindings", "startup", "scripts", "notify"
}
setup(modules)
