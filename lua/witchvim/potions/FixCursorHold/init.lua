return { -- decouple updatetime from CursorHold and CursorHoldI (works for Vim and Neovim)
	"antoinemadec/FixCursorHold.nvim",
	event = "BufRead",
	config = function()
		vim.g.cursorhold_updatetime = 100
	end,
}
