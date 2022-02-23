local function brew()
	local status_ok, indent_blankline = pcall(require, "indent_blankline")
	if not status_ok then
		return
	end

	indent_blankline.setup {
		buftype_exclude = {
			"alpha",
			"NvimTree",
			"terminal",
			"term",
			"packer",
			"gitcommit",
			"fugitive",
			"nofile",
			"Greeter",
			"help"
		},
		filetype_exclude = {
			"NvimTree",
			"terminal",
			"term",
			"packer",
			"gitcommit",
			"fugitive",
			"nofile",
			"Greeter",
		},
		context_patterns = {
			"class",
			"function",
			"method",
			"block",
			"list_literal",
			"selector",
			"^if",
			"^table",
			"if_statement",
			"while",
			"for",
			"object",
			"start_tag",
			"open_tag",
			"element",
		},
		show_first_indent_level = true,
		show_current_context = true,
		show_trailing_blankline_indent = false,
	}
end

return {
	"lukas-reineke/indent-blankline.nvim",
	config = brew()
}