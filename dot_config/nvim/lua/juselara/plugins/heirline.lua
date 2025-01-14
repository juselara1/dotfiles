---@alias InitFn fun(table): nil
---@alias ProviderFn fun(table): string
---@alias HlFn fun(table): {fg: string, bold: boolean}
---@alias Component {init: InitFn, provider: ProviderFn, hl: HlFn, update: table}

---@alias Colorizer fun(): string

---Gets color from vim mode.
---@return string # Selected color.
local function mode_colorizer()
	local mode = vim.fn.mode(1):sub(1, 1)
	local colors = require("kanagawa.colors").setup().palette
	local mode_colors = {
		n = colors.dragonGreen , i = colors.autumnRed, v = colors.dragonViolet,
		V = colors.dragonViolet, ["\22"] = colors.dragonViolet,
		c = colors.dragonYellow, s = colors.dragonAsh, S = colors.dragonAsh,
		["\19"] = colors.dragonAsh, R = colors.autumnRed, r = colors.autumnRed,
		["!"] = colors.dragonAsh, t = colors.dragonAsh
	}
	return mode_colors[mode]
end

---Component that displays the file name.
---@return Component # Component
local function file_handler()
	local colors = require("kanagawa.colors").setup().palette
	return {
		provider = function(self)
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
			local name = ""
			local modified = ""
			if filename == "" then
				name = "[No Name]"
			else
				name = vim.fn.pathshorten(filename)
			end
			local icon = require("nvim-web-devicons").get_icon(name)
			if icon == nil then
				icon = ''
			end
			if vim.bo.modified then
				modified = " ●"
			end

			return ("%s %s%s"):format(icon, name, modified)
		end,
		hl = {fg = colors.dragonWhite, bg=""}
	}
end

---Component that displays the active mode.
---@return Component # Component.
local function vi_mode()
	local colors = require("kanagawa.colors").setup().palette
	local mode_names = {
		n = "NORMAL", no = "N?", nov = "N?", noV = "N?", ["no\22"] = "N?",
		niI = "Ni", niR = "Nr", niV = "Nv", nt = "Nt", v = "VISUAL",
		vs = "Vs", V = "VILINE", Vs = "Vs", ["\22"] = "VBLOCK", ["\22s"] = "VBLOCK",
		s = "S", S = "S_", ["\19"] = "^S", i = "INSERT", ic = "Ic", ix = "Ix",
		R = "REPLAC", Rc = "Rc", Rx = "Rx", Rv = "Rv", Rvc = "Rv", Rvx = "Rv",
		c = "EXCOMM", cv = "EXCOMM", r = "...", rm = "M", ["r?"] = "?", ["!"] = "!",
		t = "T",
	}
	return {
		provider = function(_)
			return "%3.3(🦍%) "..mode_names[vim.fn.mode(1)]..' '
		end,
		hl = function(_)
			return {fg=colors.dragonBlack0, bold = true, bg=mode_colorizer()}
		end,
		update = {
			"ModeChanged",
			pattern = "*:*",
			callback = vim.schedule_wrap(function()
				vim.cmd("redrawstatus")
			end),
		}
	}
end

---Generates an align component
---@return Component # Component.
local function align()
	return {
		provider = "%=",
		hl = {bg=""}
	}
end

---Generates an align component
---@param n_spaces integer # Number of spaces to add.
---@return Component # Component.
local function space(n_spaces)
	local spaces = ''
	for _=1,n_spaces do
		spaces = spaces..' '
	end
	return {
		provider = spaces,
		hl = {
			bg=""
		}
	}
end

---Generates a component that displays the cursor position.
---@return Component # Component
local function cursor_pos()
	local colors = require("kanagawa.colors").setup().palette
	local bar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
	return {
		provider = function(_)
			local line = vim.api.nvim_win_get_cursor(0)[1]
			local tot_lines = vim.api.nvim_buf_line_count(0)
			local prop = line / tot_lines
			local percentage = ""
			if prop == 1.0 then
				percentage = "EOF"
			else
				percentage = ("%.0f"):format(prop * 100).."%%"
			end

			local bar_val = bar[math.ceil(prop * #bar)]
			return "[%3("..percentage.."%)] "..bar_val
		end,
		hl = {bg = '', fg = colors.dragonWhite}
	}
end

---Displays git information
---@return Component
local function git()
	local colors = require("kanagawa.colors").setup().palette
	return {
		provider = function(_)
			if vim.fn.system("git --version"):find("command not found") ~= nil then
				return ''
			end
			if vim.fn.system("git rev-parse --is-inside-work-tree"):find("true") == nil then
				return ''
			end
			local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("%s", '')
			return ' '..branch
		end,
		hl = {bg = '', fg = colors.dragonWhite}
	}
end

---Generates the status line.
---@return Component[]
local function status_line()
	return {
		space(3),
		vi_mode(),
		space(1),
		git(),
		align(),
		file_handler(),
		align(),
		cursor_pos(),
		space(3),
	}
end

return {
	"rebelot/heirline.nvim",
	dependencies = {"rebelot/kanagawa.nvim", "nvim-tree/nvim-web-devicons"},
	config = function()
		vim.o.showmode = false
		local colors = require("kanagawa.colors").setup()
		require("heirline").setup{
			statusline = status_line(),
			opts = {
				colors = colors,
			}
		}
	end
}
