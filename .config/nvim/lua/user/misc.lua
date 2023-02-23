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
