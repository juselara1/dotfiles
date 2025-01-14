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

local plugin_spec = {
    { repo = "https://github.com/udayvir-singh/tangerine.nvim", branch = "v2.9" },
    { repo = "https://github.com/udayvir-singh/hibiscus.nvim", branch = "v1.7" },
    { repo = "https://github.com/folke/lazy.nvim", branch = "stable" },
}

for _, v in ipairs(plugin_spec) do
    plugin(v.repo, v.branch)
end

require("tangerine").setup {
    target = vim.fn.stdpath("data") .. "/tangerine",
    rtpdirs = {
        "ftplugin", "lsp", "after"
        },
    compiler = {
        verbose = false,
        hooks = { "onsave", "oninit" }
    },
}
