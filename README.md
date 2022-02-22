# witchvim.nvim
just seemed like a fun little project

```lua
local url = "https://raw.githubusercontent.com/DrakeAxelrod/witchvim.nvim/main/witchvim.lua"
wv = assert(load(vim.fn.system({
	"curl",
	"-s",
	url,
})))()

wv.spellbook(function(spell) -- packer is already added for simplicity
  -- plugins go here
	spell({ "lewis6991/impatient.nvim" }) -- Optimiser
	spell({ "nvim-lua/plenary.nvim" }) -- Lua functions
	spell({ "nvim-lua/popup.nvim" }) -- Popup API
	spell({ "nathom/filetype.nvim" }) -- 175x faster then filetype.vim
end)
```
