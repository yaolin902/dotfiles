local status_ok, focus = pcall(require, "focus")
if not status_ok then
	return
end

focus.setup()

local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
	return
end

colorizer.setup()

local status_ok, todo = pcall(require, "todo-comments")
if not status_ok then
	return
end

todo.setup()

-- TODO: test

local status_ok, hop = pcall(require, "hop")
if not status_ok then
	return
end

hop.setup({ keys = "etovxqpdygfblzhckisuran" })

local status_ok, neoclip = pcall(require, "neoclip")
if not status_ok then
	return
end

neoclip.setup()

local status_ok, flit = pcall(require, "flit")
if not status_ok then
	return
end

flit.setup({
	keys = { f = "f", F = "F", t = "t", T = "T" },
	-- A string like "nv", "nvo", "o", etc.
	labeled_modes = "v",
	multiline = true,
	-- Like `leap`s similar argument (call-specific overrides).
	-- E.g.: opts = { equivalence_classes = {} }
	opts = {},
})

local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
end

trouble.setup()

local banned_messages = { "warning: multiple different client offset_encodings" }

vim.notify = (function(overridden)
	return function(msg, ...)
		for _, banned in ipairs(banned_messages) do
			if msg:match(banned) then
				return
			end
		end
		overridden(msg, ...)
	end
end)(require("notify"))

