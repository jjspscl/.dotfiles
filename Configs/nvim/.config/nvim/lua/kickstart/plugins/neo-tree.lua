-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<C-b>', ':Neotree toggle<CR>', desc = 'Toggle NeoTree (VS Code style)', silent = true },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- show hidden files dimmed
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      window = {
        mappings = {
          ['<C-b>'] = 'close_window',
        },
      },
    },
  },
}
