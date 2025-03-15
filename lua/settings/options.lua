vim.o.number = true
vim.opt.title = false
vim.o.ambiwidth = 'double'
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.list = true
vim.o.listchars = 'tab:»- ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%'
vim.o.nrformats = 'hex'
vim.o.hidden = true
vim.o.virtualedit = 'block'
vim.o.whichwrap = 'b,s,<,>,[,],h,l'
vim.o.backspace = 'indent,eol,start'
vim.o.wildmenu = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrapscan = true
vim.o.hlsearch = true
vim.o.showmatch = true
vim.o.matchtime = 1
--vim.o.tabline = '%F'
vim.o.showtabline = 0
vim.o.clipboard = "unnamedplus"
-- <Leader>キーの定義（例：スペースに変更）
vim.g.mapleader = " "
vim.opt.termguicolors = true
-- vim.opt.winbar = "%f" -- ファイル名を表示
-- vim.opt.winbar = "%m %f" -- モードとファイル名を表示
-- vim.opt.winbar = "%t %f" -- タブ名とファイル名を表示
vim.opt.winbar = ""
vim.opt.laststatus = 0 -- ステータスラインを非表示
vim.opt.statusline = ""
--vim.opt.showmode = false
