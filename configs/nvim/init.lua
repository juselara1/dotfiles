-- require("keybindings")
-- require("explorer")
-- require("statusline")
-- require("style")
-- require("format")
-- require("lint")
-- require("tmux")
local options = require("options")
options.setup({
  options={
    function() options.set_colorscheme({name="habamax", theme=options.Theme.dark}) end,
    options.set_cursor, options.set_files, options.set_indentation, options.set_numbers,
    options.set_text, options.set_cmd, options.set_columns, options.set_yank, options.set_match,
    options.set_display, options.set_ui, options.set_buffers, options.set_project
  }
})

require("lsp_config").setup({servers={"lua_ls", "jedi_language_server"}})
