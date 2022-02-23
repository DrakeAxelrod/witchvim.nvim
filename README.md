# WitchVim

just seemed like a fun little project

Lots of inspiration from packer, lunarvim, and various dotfiles


## plugin install command

git clone https://github.com/DrakeAxelrod/witchvim.nvim ~/.local/share/nvim/site/pack/packer/start/witchvim.nvim --depth 1

## usage

```lua
local wv = require("witchvim")

wv.impatient()

-- map leader early
wv.curse("", "<Space>", "<Nop>", { noremap = true, silent = true })
wv.g.mapleader = [[ ]]
wv.g.maplocalleader = [[ ]]

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
	"gzip",
	"man",
	"matchit",
	"matchparen",
	"shada_plugin",
	"tarPlugin",
	"tar",
	"zipPlugin",
	"zip",
	"netrwPlugin",
}

for i = 1, 10 do
	wv.g["loaded_" .. disabled_built_ins[i]] = 1
end

local buffer = { wv.o, wv.bo }
local window = { wv.o, wv.wo }

-- Options --
wv.g.cursorhold_updatetime = 100
wv.hex("history", 100) -- Number of commands to remember in a history table
wv.hex("backup", false) -- creates a backup file
wv.hex("lazyredraw", true) -- do not redraw while running macros (much faster)
wv.hex("clipboard", "unnamedplus") -- allows neovim to access the system clipboard
wv.hex("cmdheight", 2) -- more space in the neovim command line for displaying messages
wv.hex("colorcolumn", 9999) -- fixes indentline for now
wv.hex("conceallevel", 0, window) -- so that `` is visible in markdown files
wv.hex("fileencoding", "utf-8") -- the encoding written to a file
wv.hex("foldmethod", "manual") -- folding, set to "expr" for treesitter based folding
wv.hex("foldexpr", "") -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
wv.hex("guifont", "monospace:h17") -- the font used in graphical neovim applications
wv.hex("hidden", true) -- required to keep multiple buffers and open multiple buffers
wv.hex("hlsearch", true) -- highlight all matches on previous search pattern
wv.hex("ignorecase", true) -- ignore case in search patterns
wv.hex("mouse", "a") -- allow the mouse to be used in neovim
wv.hex("pumheight", 10) -- pop up menu height
wv.hex("showmode", false) -- we don't need to see things like -- INSERT -- anymore
wv.hex("showtabline", 2) -- always show tabs
wv.hex("smartcase", true) -- smart case
wv.hex("smartindent", true, buffer) -- make indenting smarter again
wv.hex("splitbelow", true) -- force all horizontal splits to go below current window
wv.hex("splitright", true) -- force all vertical splits to go to the right of current window
wv.hex("swapfile", false) -- creates a swapfile
wv.hex("background", "dark")
wv.hex("termguicolors", true) -- set term gui colors (most terminals support this)
wv.hex("timeoutlen", 100) -- time to wait for a mapped sequence to complete (in milliseconds)
wv.hex("title", true) -- set the title of window to the value of the titlestring
-- wv.hex("undodir") -- set an undo directory
wv.hex("undofile", true, buffer) -- enable persistent undo
wv.hex("updatetime", 300) -- faster completion
wv.hex("writebackup", false) -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
wv.hex("autoindent", true, buffer)
wv.hex("expandtab", true, buffer) -- convert tabs to spaces
local indent = 2
wv.hex("shiftwidth", indent, buffer) -- the number of spaces inserted for each indentation
wv.hex("softtabstop", indent, buffer)
wv.hex("tabstop", indent, buffer) -- insert 2 spaces for a tab
wv.hex("cursorline", true, window) -- highlight the current line
wv.hex("number", true, window) -- set numbered lines
wv.hex("relativenumber", false, window) -- set relative numbered lines
wv.hex("numberwidth", 2) -- set number column width to 2 {default 4}
wv.hex("signcolumn", "yes", window) -- always show the sign column, otherwise it would shift the text each time
wv.hex("wrap", false) -- display lines as one long line
wv.hex("spell", false)
wv.hex("spelllang", "en")
-- wv.hex("spellfile")
-- wv.hex("shadafile", "'20,<50,s10,h,/100")
wv.hex("guicursor", "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50")
wv.hex("shortmess", wv.o.shortmess .. "c")
wv.hex("whichwrap", wv.o.whichwrap .. "<,>,h,l")
local soff = 8
wv.hex("scrolloff", soff) -- minimal number of screen lines to keep above and below the cursor.
wv.hex("sidescrolloff", soff) -- minimal number of screen lines to keep left and right of the cursor.
wv.hex("display", "msgsep")
wv.hex("list", true, window) -- display tabs, trailing spaces, etc.
wv.hex("showbreak", "﬌", window) -- symbold to display on wrapped lines.
vim.opt.listchars = { -- visualize invisible symbols.
	-- tab = ">",
	tab = " ", --
	eol = "↴",
	space = " ", -- •
	nbsp = "␣",
	trail = "•",
	extends = "⟩",
	precedes = "⟨",
}
wv.hex("incsearch", true) -- highlight as you type you search phrase.
wv.hex("timeoutlen", 200)
wv.hex("joinspaces", false) -- two spaces after a period with a join command
wv.hex("autochdir", true) -- change directory to the file in the current window
wv.hex("autowrite", true) -- save the file when shell/cmd are run.
wv.hex("autoread", true, buffer) -- detect file modifications and reload.


wv.cauldron(function(potion)
	-- Packer can manage itself and WitchVim --
	potion("wbthomason/packer.nvim") -- package manager
	potion("DrakeAxelrod/witchvim.nvim") -- witchvim :D
	potion(wv.brew("impatient")) -- Optimiser
	potion(wv.brew("plenary")) -- Lua functions
	potion(wv.brew("popup")) -- Popup API
	potion(wv.brew("filetype")) -- 175x faster then filetype.vim
	potion(wv.brew("cursorfix")) -- decouple updatetime from CursorHold and CursorHoldI (works for Vim and Neovim)
	potion(wv.brew("notify")) -- notification plugin
	potion("kyazdani42/nvim-web-devicons") -- filesystem icons
	potion(wv.brew("telescope")) -- search
	potion(wv.brew("alpha")) -- dashboard
	potion(wv.brew("theme")) -- colorschemes
	potion(wv.brew("lualine")) -- statusline
	potion(wv.brew("nvim-tree")) -- filesystem browser
	potion(wv.brew("bufferline")) -- tabs
	potion("moll/vim-bbye") -- better close buffer
	potion(wv.brew("escape")) -- Smooth escaping})
	potion("akinsho/toggleterm.nvim") -- terminal
	potion(wv.brew("which-key")) -- key hinting / menu
	potion(wv.brew("indent-blankline")) 	-- indentation
	potion(wv.brew("wakatime")) -- coding metrics
end)

wv.robes("rose-pine")

local silent = { silent = true }
local opts = { noremap = true, silent = true }
-- Normal --
-- Yank to clipboard
wv.curse({ "n", "v" }, "y+", "<cmd>set opfunc=util#clipboard_yank<cr>g@", silent)
-- Window movement
wv.curse("n", "<C-h>", "<C-w>h")
wv.curse("n", "<C-j>", "<C-w>j")
wv.curse("n", "<C-k>", "<C-w>k")
wv.curse("n", "<C-l>", "<C-w>l")
-- Resize with arrows
wv.curse("n", "<C-Up>", ":resize -2<CR>", opts)
wv.curse("n", "<C-Down>", ":resize +2<CR>", opts)
wv.curse("n", "<C-Left>", ":vertical resize -2<CR>", opts)
wv.curse("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- Tab movement
wv.curse("n", "<S-h>", "<cmd>bprevious<CR>", opts)
wv.curse("n", "<S-l>", "<cmd>bnext<CR>", opts)
-- Move text up and down
wv.curse("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
wv.curse("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- Visual --
-- Stay in indent mode
wv.curse("v", "<", "<gv", opts)
wv.curse("v", ">", ">gv", opts)
-- Move text up and down
wv.curse("v", "<A-j>", ":m .+1<CR>==", opts)
wv.curse("v", "<A-k>", ":m .-2<CR>==", opts)
wv.curse("v", "p", '"_dP', opts)
-- Visual Block --
-- Move text up and down
wv.curse("x", "J", ":move '>+1<CR>gv-gv", opts)
wv.curse("x", "K", ":move '<-2<CR>gv-gv", opts)
wv.curse("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
wv.curse("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
-- All --
wv.curse("", "<C-n>", "<cmd>NvimTreeToggle<cr>")
-- Commands --
wv.ritual("misc_aucmds", {
	[[BufWinEnter * checktime]],
	[[TextYankPost * silent! lua vim.highlight.on_yank()]],
	[[FileType qf set nobuflisted ]],
}, true)
```
