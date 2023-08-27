--[[
  File: settings.lua
  Description: Base settings for neovim
  Info: Use <zo> and <zc> to open and close foldings
--]]

require "helpers/globals"

-- Set associating between turned on plugins and filetype
cmd[[filetype plugin on]]

-- Disable comments on pressing enter
cmd[[autocmd FileType * setlocal formatoptions-=cro]]

g.python3_host_prog = '/home/warren/.pyenv/versions/neovim/bin/python3'

opt.termguicolors = true

-- Tabs {{{
opt.expandtab = true	-- Use spaces by default
opt.shiftwidth = 2	-- Set amount of space characters, when we press "<" or ">"
opt.tabstop = 2		-- 1 tab equals 2 spaces
opt.smartindent = true	-- Turn on smart indentation. See in the docs for more info
-- }}}

-- Clipboard {{{
opt.clipboard = 'unnamedplus' -- Use system clipboard
opt.fixeol = false -- Turn off appending new line in the end of a file
-- }}}

-- Folding {{{
opt.foldmethod = 'syntax'
-- }}}

-- Search {{{
opt.ignorecase = true     -- Ignore case if all characters in lowercase
opt.joinspaces = false    -- Join multiples spaces in search
opt.smartcase = true      -- When there is a one capital letter search for exact match
opt.showmatch = true      -- Highlight searrch instances
-- }}}

-- Window {{{
opt.splitbelow = true     -- Put new windows below current
opt.splitright = true     -- Put new vertical splits to right
-- }}}

-- Wild Menu {{{
opt.wildmenu = true
opt.wildmode = 'longest:full,full'
-- }}}

-- Default Plugins {{{
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
-- }}}
