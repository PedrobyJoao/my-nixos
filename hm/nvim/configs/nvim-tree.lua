require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,

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
