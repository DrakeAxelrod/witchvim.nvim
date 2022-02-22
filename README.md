# witchvim.nvim

just seemed like a fun little project

if you wanna use potion you'll need to make lua/potion and place plugin configs in there

## basic implementation
```lua
-- use curl and load to remotely get witchvim
wv = assert(load(vim.fn.system({
	"curl",
	"-s",
	"https://raw.githubusercontent.com/DrakeAxelrod/witchvim.nvim/main/witchvim.lua"
})))()

-- if avail enable profile
wv.impatient()

-- map leader early
wv.curse("", "<Space>", "<Nop>", { noremap = true, silent = true })
wv.g.mapleader = [[ ]]
wv.g.maplocalleader = [[ ]]

wv.spellbook(function(spell) -- packer is already added for simplicity
	-- plugins go here
	spell({ "lewis6991/impatient.nvim" }) -- Optimiser
	spell({ "nvim-lua/plenary.nvim" }) -- Lua functions
	spell({ "nvim-lua/popup.nvim" }) -- Popup API
	spell({ -- 175x faster then filetype.vim
    "nathom/filetype.nvim",
    -- we dont need filetype.vim since we use nathom/filetype.nvim
    config = function() wv.g.did_load_filetypes = 1 end
  })
	spell({ -- decouple updatetime from CursorHold and CursorHoldI (works for Vim and Neovim)
		"antoinemadec/FixCursorHold.nvim",
		event = "BufRead",
		config = function() vim.g.cursorhold_updatetime = 100 end,
	})
	spell({ -- notification plugin
		"rcarriga/nvim-notify",
		event = "BufEnter",
	})
	spell({ "nvim-lua/telescope.nvim" }) -- search
	spell({ -- dashboard
		"goolord/alpha-nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			"usenvim-lua/telescope.nvim",
		}
	})
end)

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = wv.views.banner()
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
	dashboard.button("r", "  Recent", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find Text", ":Telescope live_grep <CR>"),
	dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
	dashboard.button("s", "  Find Session", ":Telescope marks <CR>"),
	dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua <CR>"),
}
dashboard.section.footer.val = wv.views.footer()
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
```
