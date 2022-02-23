local function brew()
	local status_ok, nvim_notify = pcall(require, [[notify]])
	if not status_ok then
		return
	end
	nvim_notify.setup({
		---@usage Animation style one of { "fade", "slide", "fade_in_slide_out", "static" }
		stages = "fade_in_slide_out",

		---@usage Function called when a new window is opened, use for changing win settings/config
		-- on_open = nil,

		---@usage Function called when a window is closed
		-- on_close = nil,

		---@usage timeout for notifications in ms, default 5000
		timeout = 1500,

		-- Render function for notifications. See notify-render()
		render = "default",

		---@usage highlight behind the window for stages that change opacity
		background_colour = "Normal",

		---@usage minimum width for notification windows
		minimum_width = 50,

		---@usage Icons for the different levels
		icons = {
			ERROR = "",
			WARN = "",
			INFO = "",
			DEBUG = "",
			TRACE = "",
		},
	})
	vim.notify = nvim_notify
end

return { -- notification plugin
	"rcarriga/nvim-notify",
	event = "BufEnter",
	config = brew()
}