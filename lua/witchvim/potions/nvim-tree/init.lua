--require([[nvim-tree]]).setup({})
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
vim.g.nvim_tree_icons = {
	default = "",
	symlink = "",
	git = {
		unstaged = "",
		staged = "S",
		unmerged = "",
		renamed = "➜",
		deleted = "",
		untracked = "U",
		ignored = "◌",
	},
	folder = {
		-- arrow_open = " ",
		-- arrow_closed = "",
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "",
	},
}

local function brew()
	local status_ok, nvim_tree = pcall(require, "nvim-tree")
	if not status_ok then
		return
	end

	local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
	if not config_status_ok then
		return
	end

	local tree_cb = nvim_tree_config.nvim_tree_callback

	nvim_tree.setup({
		disable_netrw = true,
		hijack_netrw = true,
		open_on_setup = false,
		ignore_ft_on_setup = {
			"startify",
			"dashboard",
			"alpha",
		},
		auto_close = true,
		open_on_tab = false,
		hijack_cursor = false,
		update_cwd = true,
		update_to_buf_dir = {
			enable = true,
			auto_open = true,
		},
		--   error
		--   info
		--   question
		--   warning
		--   lightbulb
		diagnostics = {
			enable = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
			ignore_list = {},
		},
		system_open = {
			cmd = nil,
			args = {},
		},
		filters = {
			dotfiles = false,
			custom = {},
		},
		git = {
			enable = true,
			ignore = true,
			timeout = 500,
		},
		view = {
			width = 30,
			height = 30,
			hide_root_folder = false,
			side = "left",
			auto_resize = true,
			mappings = {
				custom_only = false,
				list = {
					{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
					{ key = "h", cb = tree_cb("close_node") },
					{ key = "v", cb = tree_cb("vsplit") },
				},
			},
			number = false,
			relativenumber = false,
		},
		trash = {
			cmd = "trash",
			require_confirm = true,
		},
		quit_on_open = 0,
		git_hl = 1,
		disable_window_picker = 0,
		root_folder_modifier = ":t",
		show_icons = {
			git = 1,
			folders = 1,
			files = 1,
			folder_arrows = 1,
			tree_width = 30,
		},
	})
end

return {
	[[kyazdani42/nvim-tree.lua]],
	requires = [[kyazdani42/nvim-web-devicons]], -- filesystem icons
	after = "nvim-web-devicons",
	config = brew(),
}

-- local M = {}
-- local Log = require("lvim.core.log")

-- function M.config()
-- 	lvim.builtin.nvimtree = {
-- 		active = true,
-- 		on_config_done = nil,
-- 		setup = {
-- 			disable_netrw = true,
-- 			hijack_netrw = true,
-- 			open_on_setup = false,
-- 			ignore_ft_on_setup = {
-- 				"startify",
-- 				"dashboard",
-- 				"alpha",
-- 			},
-- 			update_to_buf_dir = {
-- 				enable = true,
-- 				auto_open = true,
-- 			},
-- 			auto_close = false,
-- 			open_on_tab = false,
-- 			hijack_cursor = false,
-- 			update_cwd = false,
-- 			diagnostics = {
-- 				enable = true,
-- 				icons = {
-- 					hint = "",
-- 					info = "",
-- 					warning = "",
-- 					error = "",
-- 				},
-- 			},
-- 			update_focused_file = {
-- 				enable = true,
-- 				update_cwd = true,
-- 				ignore_list = {},
-- 			},
-- 			system_open = {
-- 				cmd = nil,
-- 				args = {},
-- 			},
-- 			git = {
-- 				enable = true,
-- 				ignore = false,
-- 				timeout = 200,
-- 			},
-- 			view = {
-- 				width = 30,
-- 				height = 30,
-- 				hide_root_folder = false,
-- 				side = "left",
-- 				auto_resize = false,
-- 				mappings = {
-- 					custom_only = false,
-- 					list = {},
-- 				},
-- 				number = false,
-- 				relativenumber = false,
-- 				signcolumn = "yes",
-- 			},
-- 			filters = {
-- 				dotfiles = false,
-- 				custom = { "node_modules", ".cache" },
-- 			},
-- 			trash = {
-- 				cmd = "trash",
-- 				require_confirm = true,
-- 			},
-- 		},
-- 		show_icons = {
-- 			git = 1,
-- 			folders = 1,
-- 			files = 1,
-- 			folder_arrows = 1,
-- 			tree_width = 30,
-- 		},
-- 		quit_on_open = 0,
-- 		git_hl = 1,
-- 		disable_window_picker = 0,
-- 		root_folder_modifier = ":t",
-- 		icons = {
-- 			default = "",
-- 			symlink = "",
-- 			git = {
-- 				unstaged = "",
-- 				staged = "S",
-- 				unmerged = "",
-- 				renamed = "➜",
-- 				deleted = "",
-- 				untracked = "U",
-- 				ignored = "◌",
-- 			},
-- 			folder = {
-- 				default = "",
-- 				open = "",
-- 				empty = "",
-- 				empty_open = "",
-- 				symlink = "",
-- 			},
-- 		},
-- 	}
-- 	lvim.builtin.which_key.mappings["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" }
-- end

-- function M.setup()
-- 	local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
-- 	if not status_ok then
-- 		Log:error("Failed to load nvim-tree.config")
-- 		return
-- 	end

-- 	for opt, val in pairs(lvim.builtin.nvimtree) do
-- 		vim.g["nvim_tree_" .. opt] = val
-- 	end

-- 	-- Implicitly update nvim-tree when project module is active
-- 	if lvim.builtin.project.active then
-- 		lvim.builtin.nvimtree.respect_buf_cwd = 1
-- 		lvim.builtin.nvimtree.setup.update_cwd = true
-- 		lvim.builtin.nvimtree.setup.disable_netrw = false
-- 		lvim.builtin.nvimtree.setup.hijack_netrw = false
-- 		vim.g.netrw_banner = false
-- 	end

-- 	-- Add useful keymaps
-- 	local tree_cb = nvim_tree_config.nvim_tree_callback
-- 	if #lvim.builtin.nvimtree.setup.view.mappings.list == 0 then
-- 		lvim.builtin.nvimtree.setup.view.mappings.list = {
-- 			{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
-- 			{ key = "h", cb = tree_cb("close_node") },
-- 			{ key = "v", cb = tree_cb("vsplit") },
-- 			{ key = "C", cb = tree_cb("cd") },
-- 			{ key = "gtf", cb = "<cmd>lua require'lvim.core.nvimtree'.start_telescope('find_files')<cr>" },
-- 			{ key = "gtg", cb = "<cmd>lua require'lvim.core.nvimtree'.start_telescope('live_grep')<cr>" },
-- 		}
-- 	end

-- 	local function on_open()
-- 		if package.loaded["bufferline.state"] and lvim.builtin.nvimtree.setup.view.side == "left" then
-- 			require("bufferline.state").set_offset(lvim.builtin.nvimtree.setup.view.width + 1, "")
-- 		end
-- 	end

-- 	local function on_close()
-- 		local bufnr = vim.api.nvim_get_current_buf()
-- 		local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
-- 		if ft == "NvimTree" and package.loaded["bufferline.state"] then
-- 			require("bufferline.state").set_offset(0)
-- 		end
-- 	end

-- 	local tree_view = require("nvim-tree.view")
-- 	local default_open = tree_view.open
-- 	local default_close = tree_view.close

-- 	tree_view.open = function()
-- 		on_open()
-- 		default_open()
-- 	end

-- 	tree_view.close = function()
-- 		on_close()
-- 		default_close()
-- 	end

-- 	if lvim.builtin.nvimtree.on_config_done then
-- 		lvim.builtin.nvimtree.on_config_done(nvim_tree_config)
-- 	end

-- 	require("nvim-tree").setup(lvim.builtin.nvimtree.setup)
-- end

-- function M.start_telescope(telescope_mode)
-- 	local node = require("nvim-tree.lib").get_node_at_cursor()
-- 	local abspath = node.link_to or node.absolute_path
-- 	local is_folder = node.open ~= nil
-- 	local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
-- 	require("telescope.builtin")[telescope_mode]({
-- 		cwd = basedir,
-- 	})
-- end

-- return M
