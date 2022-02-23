local function brew()
  local present, toggleterm = pcall(require, "toggleterm")
  if not present then
      return
  end

  toggleterm.setup{
    -- size can be a number or function which is passed the current terminal
    size = 10,
    -- size = function(term)
    --   if term.direction == "horizontal" then
    --     return 15
    --   elseif term.direction == "vertical" then
    --     return vim.o.columns * 0.4
    --   end
    -- end,
    open_mapping = [[<c-t>]],
    -- on_open = fun(t: Terminal), -- function to run when the terminal opens
    -- on_close = fun(t: Terminal), -- function to run when the terminal closes
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = '2', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    direction = "horizontal", -- 'vertical' | 'horizontal' | 'window' | 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border =  "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      width = 120,
      height = 40,
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    },
    -- execs = {
    --   { "lazygit", "<leader>gg", "LazyGit", "float" },
    --   { "lazygit", "<c-\\><c-g>", "LazyGit", "float" },
    -- },
  }
	vim.api.nvim_exec([[
            let g:toggleterm_terminal_mapping = '<C-t>'
            autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
            nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
            inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
        ]],
		false
	)
	function _G.set_terminal_keymaps()
		local opts = { noremap = true }
		vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
	end
	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
end

return {
  "akinsho/toggleterm.nvim",
  config = brew(),
}