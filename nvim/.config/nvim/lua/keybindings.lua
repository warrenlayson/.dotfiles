require "helpers/globals"
require "helpers/keyboard"

g.mapleader = ' '


-- Normal {{{
-- Better window navigation
nm('<c-h', '<C-w>h')
nm('<c-j', '<C-w>j')
nm('<c-k', '<C-w>k')
nm('<c-l', '<C-w>l')
-- }}}

-- Insert {{{
-- Press jk fast to exit insert mode
im('jk', '<ESC>')
-- }}}

-- Visual {{{
-- Stay in indent mode
vm('<', '<gv')
vm('>', '>gv')

-- Move text up and down
vm('<A-j>', ':m .+1<CR>==')
vm('<A-k>', ':m .-2<CR>==')
vm('p', '"_dp')
-- }}}

-- Visual Block {{{
-- Move text up and down
-- }}}


-- LSP {{{
nm('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
nm('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
nm('gR', '<cmd>lua vim.lsp.buf.rename()<CR>')
nm('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
--}}}

nm('<leader>e', '<cmd>Neotree toggle<cr>')
