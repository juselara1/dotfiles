---Installs a plugin.
---@param repo string Plugin repo url.
---@param branch string Branch to clone.
local function plugin(repo, branch)
	local name = repo:gsub(".*/", "")
	local path = vim.fn.stdpath("data") .. "/lazy/" .. name
	if branch == nil then
		branch = "main"
	end
	if vim.fn.isdirectory(path) == 0 then
		vim.print(("Installing %s..."):format(name))
		vim.fn.system({ "git", "clone", "--depth", "1", "-b", branch, repo, path })
	end
	vim.opt.runtimepath:prepend(path)
end

---Dynamically setups the plugins that are in the `lua/plugins/` folder.
local function setup_plugins()
	local plugins_cfg = {}
	local plugins = vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/plugins/")
	for _, value in ipairs(plugins) do
		table.insert(plugins_cfg, require(("plugins.%s"):format(value:gsub("%..*", ""))))
	end
	require("lazy").setup(plugins_cfg)
end

---Main entrypoint
local function main()
	local plugin_spec = {
		{ repo = "https://github.com/folke/lazy.nvim", branch = "stable" },
	}

	for _, v in ipairs(plugin_spec) do
		plugin(v.repo, v.branch)
	end
	setup_plugins()
end

main()
