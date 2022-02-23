local function brew()
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end
local dashboard = require("alpha.themes.dashboard")
local fmt = string.format


local function banner()
	return {
		"     .  +            _    /     .     *            . .     .        . ",
		"  -+-     __    __ _ _   *   _          _   .  +       .       *      ",
		"         / / /\\ \\ (_) |_ ___| |__/\\   /(_)_ __ ___       .  .     -+- ",
		"   .     \\ \\/  \\/ / | __/ __| '_ \\ \\ / / | '_ ` _ \\ +      / .        ",
		"    .   . \\  /\\  /| | || (__| | | \\ V /| | | | | | |.     /   .   _   ",
		"     .  +  \\/  \\/ |_|\\__\\___|_| |_|\\_/ |_|_| |_| |_|.    *    +  .    ",
		"   _         .      /       . .    +   .      +     .   _  .      .   ",
		"  .   .   *        *     .        ,,,.    ,@@@@@/@@,  .oo8888o. .     ",
		"    _/\\_            .          ,&%%&%&&%,@@@@@/@@@@@@,8888\\88/8o    . ",
		"    ( (  .   .   *       +   ,%&\\%&&%&&%,@@@\\@@@/@@@88\\88888/88' .    ",
		"  ==-|/--              ))   %&&%&%&/%&&%@@\\@@/ /@@@88888\\888/888'     ",
		"                      ((     %&&%/  %&%%&&@@\\ V /@@' `88\\8 `/88'      ",
		"                    ___I_     `&%\\ ` /%&'    |.|        \\ '|8'        ",
		"                   /\\-_--\\        |o|        | |         | |          ",
		"                  /  \\_-__\\       |.|        | |         | |          ",
		"_\\\\/_._\\//_/__/ __|[]| [] |____\\\\/ ._\\//_/__/  ,\\_//__\\/.  \\_//__\\/__",
	}
end


local function plugin_count()
	return vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
end

local function footer()
	return {
		fmt("                 %s %s               ", _wv.name, _wv.version),
		fmt("              Loaded [%s] Plugins             ", plugin_count()),
		fmt(" %s", _wv.website),
	}
end




dashboard.section.header.val = banner()
dashboard.section.buttons.val = {
  dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
  dashboard.button("r", "  Recent", ":Telescope oldfiles <CR>"),
  dashboard.button("t", "  Find Text", ":Telescope live_grep <CR>"),
  dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
  dashboard.button("s", "  Find Session", ":Telescope marks <CR>"),
  dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua <CR>"),
  -- dashboard.button("q", "  Last Session", ":SessionLoad <CR>"),
}
dashboard.section.footer.val = footer()
-- dashboard.section.footer.opts.hl = "Type"
-- dashboard.section.header.opts.hl = "Include"
-- dashboard.section.buttons.opts.hl = "Keyword"
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)

-- local footer = {
-- 	type = "text",
-- 	val = "",
-- 	opts = {
-- 		position = "center",
-- 		hl = "Number",
-- 	},
-- }
-- local config = {
-- 	layout = {
-- 		{ type = "padding", val = 2 },
-- 		section.header,
-- 		{ type = "padding", val = 2 },
-- 		section.buttons,
-- 		section.footer,
-- 	},
-- 	opts = {
-- 		margin = 5,
-- 	},
-- }
end

return { -- dashboard
		"goolord/alpha-nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			"usenvim-lua/telescope.nvim",
		},
		config = brew(),
}