--[[
  File: treesitter.lua
  Description: Configuration of tree-sitter
  See: https://github.com/tree-sitter/tree-sitter
]]

require'nvim-treesitter.configs'.setup {
  -- Needed parsers
  ensure_installed = { 'lua', 'javascript', 'typescript', 'python'},

  -- Install all parsers synchronously
  sync_install = false,

  highlight = {
    enable = true,
    disable = { 'markdown'},
  },
  autopairs = {
    enable = true,
  },
  autotag = {enable = true},

  indent = {
    enable = false,
    disable = { 'python', 'css', 'c' },
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      "#68a0b0",
      "#946EaD",
      "#c7aA6D",
    }, -- table of hex strings
    -- termcolors = {} -- table of colour name strings,
    disable = { "html" },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  textobjects = {
    select  = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
    }
  }
}
