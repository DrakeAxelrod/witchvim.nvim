local _ = require("witchvim.global")
local utils = require("witchvim.utils")

local wv = {}
wv.version = _wv.version
wv.name = _wv.name
wv.website = _wv.website
wv.log = require("witchvim.log")
wv.g, wv.o, wv.wo, wv.bo = vim.g, vim.o, vim.wo, vim.bo
wv.loop = vim.loop
wv.fn = vim.fn
wv.api = vim.api
wv.cmd = vim.cmd
wv.join_path = utils.join_path
wv.pp = vim.pretty_print
wv.fmt = string.format
wv.unpack = unpack or table.unpack
-- paths
function wv.packages_root()
  return utils.packages_root
end
function wv.plugins_path()
  return utils.plugins_path
end


--- load packer if needed otherwise use cauldron like packer.startup
--- @param fn function
--- @return nil
function wv.cauldron(fn)
  -- install packer if needed
  utils.packer_bootstrap()
  local packer = require("packer")
  wv.potion = packer.use
  packer.startup({
		function(use)
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

-- TODO handle if there isnt a config
-- use witchvim configuration for a plugin
function wv.brew(file)
  local config = require(wv.fmt("witchvim.potions.%s", file))
  return wv.unpack(config)
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
	local cast = wv.cmd
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


--- set the colorscheme
--- @param theme string the name of the colorscheme if using a theme in lua/theme/
--- @return void
function wv.robes(theme)
	local status_ok, _ = pcall(wv.cmd, "colorscheme " .. theme)
	if not status_ok then
		wv.log.debug(wv.fmt("could not apply %s as a colorscheme is it downloaded?", theme))
	end
end

-- TODO make update function for witchvim
function wv.update() end


return wv