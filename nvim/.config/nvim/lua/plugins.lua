require "helpers/globals"

return {
  -- Mason {{{
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require 'extensions.mason'
    end
  },
  -- }}}

  -- Neo Tree {{{
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require 'extensions.neo-tree'
    end
  },
  -- }}}

  -- Comment {{{
  {
    'numToStr/Comment.nvim',
    lazy = false,
  },
  -- }}}
  -- Telescope {{{
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },
  -- }}}

  -- Project {{{
  {
    'ahmedkhalf/project.nvim',
    config = function ()
      require 'extensions.project'
    end,
    enabled = false,
  },
  -- }}}

  -- CMP {{{
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require 'extensions.cmp'
    end
  },
  -- }}}

  -- LSP Kind {{{
  {
    'onsails/lspkind-nvim',
    lazy = true,
    config = function()
      require 'extensions.lspkind'
    end
  },
  -- }}}

  -- Git Signs{{{
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = function()
      require 'extensions.gitsigns'
    end
  },
  -- }}}

  -- TreeSitter {{{
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
     dependencies = {
       'nvim-treesitter/nvim-treesitter-textobjects',
       'p00f/nvim-ts-rainbow',
       'ShooTeX/nvim-treesitter-angular',
       'windwp/nvim-ts-autotag',
       'JoosepAlviste/nvim-ts-context-commentstring',
     },
    config = function()
      require 'extensions.treesitter'
    end,
  },
  -- }}}

  -- Trouble {{{
  {
    'folke/trouble.nvim',
  },
  -- }}}

  -- Which Key {{{
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
       require'extensions.whichkey'
    end,
  },
  -- }}}

  -- Notify {{{
  {
    'rcarriga/nvim-notify',
    config = function ()
      require 'extensions.notify'
    end
  },
  --}}}

  -- Colorscheme
  'lunarvim/darkplus.nvim',

  -- Alpha {{{
  {
    'goolord/alpha-nvim',
    config = function()
      require 'extensions.alpha'
    end
  },
  --}}}

}
