local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

require('telescope').setup{
    defaults = {
        mappings = {
            n = {
				["<leader>q"] = actions.close,
            },
            i = {
				["<ESC>"] = actions.close,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
            },
        },
        layout_config = { 
            height = 0.99,
            width = 0.99,
            mirror = true,
            preview_width = 0.60,
        },

    },
}

local function map(m, k, v)
    vim.keymap.set(m, k, v, { noremap = true, silent = true })
end

map('n', '<leader>gi', builtin.lsp_implementations, {})

map('n', '<leader>ff', builtin.find_files, {})
map('n', '<leader>gf', builtin.git_files, {})
map('n', '<leader>fg', builtin.live_grep, {})
map('n', '<leader>fb', builtin.buffers, {})
map('n', '<leader>fh', builtin.help_tags, {})
map('n', '<leader>fw', builtin.grep_string, {})
map('n', '<leader>tr', builtin.resume, {})

map('n', '<leader>gs', builtin.git_status, {})
map('n', '<leader>gst', builtin.git_stash, {})
map('n', '<leader>gc', builtin.git_commits, {})

map('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

map('n',
    '<leader>p',
    ':lua require"telescope.builtin".find_files({ prompt_title = "< Custom Search >", cwd = "~/path/to/your/folder" })<CR>'
)

-- helpful note: `:Telescope keymaps` to see keymaps being used
