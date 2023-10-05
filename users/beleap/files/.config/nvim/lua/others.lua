vim.opt.termguicolors = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.wildignorecase = true
vim.o.wildmenu = true

vim.o.tabstop = 2
vim.o.shiftwidth = vim.o.tabstop
vim.o.shiftround = true
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smarttab = true

vim.o.inccommand = "nosplit"

vim.o.undofile = true

vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

vim.o.clipboard = "unnamedplus"

if
	vim.loop.os_uname().sysname == "Linux"
	and vim.fn.executable("clip.exe") ~= 0
	and vim.fn.executable("powershell.exe") ~= 0
then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end

vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 999

vim.o.autochdir = false

vim.o.virtualedit = "all"

vim.o.pumblend = 0
vim.o.winblend = 0

vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = "v:lua.vim.treesitter.foldtext()"
