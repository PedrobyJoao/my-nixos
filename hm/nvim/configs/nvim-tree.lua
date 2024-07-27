require("nvim-tree").setup({
  sort_by = "case_sensitive",
  auto_reload_on_write = true,
  -- remove_keymaps = {"<C-t>"},
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
