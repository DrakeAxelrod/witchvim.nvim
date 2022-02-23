
return { -- 175x faster then filetype.vim
	"nathom/filetype.nvim",
	config = function()
		-- we dont need filetype.vim since we use nathom/filetype.nvim
		vim.g.did_load_filetypes = 1
	end,
}
