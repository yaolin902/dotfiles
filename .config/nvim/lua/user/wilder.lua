local status_ok, wilder = pcall(require, "wilder")
if not status_ok then
	return
end

wilder.setup({
	next_key = "<C-j>",
	accept_key = "<C-l>",
	reject_key = "<C-h>",
	previous_key = "<C-k>",
	modes = { ":", "/", "?" },
})

local gradient = {
  '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
  '#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
  '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
  '#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
}

for i, fg in ipairs(gradient) do
  gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Normal', {{a = 1}, {a = 1}, {foreground = fg}})
end

wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
		border = "rounded",
		highlights = { border = "FloatBorder", default = "Normal", gradient = gradient },
		highlighter = wilder.highlighter_with_gradient({wilder.basic_highlighter()}),
		left = { " ", wilder.popupmenu_devicons() },
		right = { " ", wilder.popupmenu_scrollbar() },
	}))
)
