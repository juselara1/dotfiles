-- require("statusline")
-- require("style")
-- require("format")
-- require("lint")
-- require("tmux")
require("explorer"):setup({})
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

local keybindings = require("keybindings")
keybindings.setup({
  keybindings={
    keybindings.set_leader, keybindings.set_list, keybindings.set_paste,
    keybindings.set_scroll, keybindings.set_search, keybindings.set_spell,
    keybindings.set_explorer, keybindings.set_indent, keybindings.set_term
  }
})
