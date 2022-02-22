local wv = {}
wv.version = "0.0.1"
wv.name = "WitchVim"

wv.g, wv.o, wv.wo, wv.bo, wv.fn, wv.cast = vim.g, vim.o, vim.wo, vim.bo, vim.fn, vim.cmd

--- string.format just shorter
wv.fmt = string.format
--- vim.pretty_print just shorter
wv.pp = vim.pretty_print

function wv.impatient()
	local status_ok, impatient = pcall(require, "impatient")
	if status_ok then
		impatient.enable_profile()
	end
end

--- runs curl and then loads the lua file and then calls the function (if valid lua code)
--- @param url string example: https://www.example.com
--- @return table result of the evaluated code
function wv.curl(url)
	return assert(load(vim.fn.system({ "curl", "-s", url })))()
end

wv.log = wv.curl(
	"https://gist.githubusercontent.com/DrakeAxelrod/9d3f930834150a8af40892d32a685b40/raw/witchvim.log.lua"
)

wv.views = {}
function wv.views.banner()
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
	return wv.fn.len(wv.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
end

function wv.views.footer()
	return {
		wv.fmt("                 %s %s               ", wv.name, wv.version),
		wv.fmt("              Loaded [%s] Plugins             ", plugin_count()),
		wv.fmt(" %s", wv.website),
	}
end

--- require a module with pcall
--- invokes a function if passed with passed args if provided
--- @param module string The module name, e.g. packer
--- @param func string The function name to invoke
--- @param args any and arguments to pass to the functions
--- @return module
function wv.library(module, func, ...)
	local fn = func or nil
	local status_ok, mod = pcall(require, module)
	if status_ok then
		if fn then
			mod[fn](...)
		end
		return mod
	else
		wv.log.debug(wv.fmt("could not load %s", mod))
		return status_ok
	end
end

--- curse({mode}, {lhs}, {rhs}, {*opts})
--- Sets a global mapping for the given mode.
--- Example:
---                     curse('n', ' <NL>', '', {'nowait': v:true})
--- @param modes string | table Mode short-name (map command prefix: "n", "i", "v", "x", …) or "!" for :map!, or empty string for :map.
--- @param lhs string Left-hand-side {lhs} of the mapping.
--- @param rhs string Right-hand-side {rhs} of the mapping.
--- @param opts string | table Optional parameters map. Accepts all
--- 						:map-arguments as keys excluding <buffer> but
--- 						including noremap and "desc". "desc" can be used
--- 						to give a description to keymap. When called from
--- 						Lua, also accepts a "callback" key that takes a
--- 						Lua function to call when the mapping is executed.
--- 						Values are Booleans. Unknown key is an error.
function wv.curse(modes, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap == nil and true or opts.noremap
	if type(modes) == "string" then
		modes = { modes }
	end
	for _, mode in ipairs(modes) do
		vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
	end
end

--- specify commands to be executed automatically when reading or writing
--- a file, when entering or leaving a buffer or window, and when exiting Vim.
--- :au[tocmd] [group] {event} {aupat} [++once] [++nested] {cmd}
---                        Add {cmd} to the list of commands that Vim will
---                        execute automatically on {event} for a file matching
---                        {aupat} autocmd-pattern.
--- @param group string
--- @param cmds string
--- @param clear boolean
--- @return nil
function wv.ritual(group, cmds, clear)
	local cast = wv.cast
	clear = clear == nil and false or clear
	if type(cmds) == "string" then
		cmds = { cmds }
	end
	cast("augroup " .. group)
	if clear then
		cast("au!")
	end
	for _, c in ipairs(cmds) do
		cast("autocmd " .. c)
	end
	cast("augroup END")
end

--- Toggle option: equivalent to :se[t] {option}={value}
--- @param scopes table
--- @param key string
--- @param value string | boolean | number
--- @return nil
function wv.hex(key, value, scopes)
	scopes = scopes or { wv.o }
	for _, scope in ipairs(scopes) do
		scope[key] = value
	end
end

--- load packer if needed otherwise use spellbook like packer.startup
--- @param fn function
--- @return nil
function wv.spellbook(fn)
	local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	end
	vim.cmd("packadd packer.nvim")
	require("packer").startup({
		function(use)
			use("wbthomason/packer.nvim")
			fn(use)
		end,
		config = {
			display = {
				open_fn = function()
					return require("packer.util").float({ border = "single" })
				end,
				prompt_border = "single",
			},
			git = {
				clone_timeout = 6000,
				subcommands = {
					fetch = "fetch --no-tags --no-recurse-submodules --update-shallow --progress",
				},
			},
			max_jobs = 50,
			profile = {
				enable = true,
			},
			auto_clean = true,
			compile_on_sync = true,
		},
	})
end

return wv
