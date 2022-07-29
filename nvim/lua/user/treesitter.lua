local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "all",
  sync_install = false,
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "markdown "}
  },
  autopairs = {
    enable = true
  },
  indent = { enable = true, disable = { "python", "css" } },
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
    disable = {"html"}
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
}
