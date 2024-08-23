-- inspired by: https://github.com/virchau13/dots/blob/9eec548da8e72c5f2b41cdeb40e983dcc91aefd1/apps/nvim/lua/lsp.lua
-- https://github.com/fmoda3/nix-configs/blob/master/home/nvim/config/lua/lsp-config.lua

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }

    buf_set_keymap("n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<Leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap(
        "n",
        "<Leader>vd",
        '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>',
        opts
    )
    buf_set_keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ float =  { border = "single" }})<CR>', opts)
    buf_set_keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ float =  { border = "single" }})<CR>', opts)
end

local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enable Language Servers
local function default_lsp_setup(module)
    lsp[module].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- Nix
lsp.nil_ls.setup({
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        -- Let statix format
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
    end,
})

-- Go
default_lsp_setup("gopls")

-- Lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lsp.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            completion = {
                callSnippet = "Replace",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Python
default_lsp_setup("pyright")

-- Typescript
-- nvim_lsp.tsserver.setup({
-- 	init_options = require("nvim-lsp-ts-utils").init_options,
-- 	on_attach = function(client, bufnr)
-- 		on_attach(client, bufnr)
--
-- 		-- Let eslint format
-- 		client.server_capabilities.document_formatting = false
-- 		client.server_capabilities.document_range_formatting = false
--
-- 		local ts_utils = require("nvim-lsp-ts-utils")
-- 		ts_utils.setup({
-- 			enable_import_on_completion = true,
-- 		})
-- 		ts_utils.setup_client(client)
--
-- 		-- Mappings.
-- 		local opts = { noremap = true, silent = true, buffer = true }
-- 		require("legendary").keymaps({
-- 			{ "gto", ":TSLspOrganize<CR>", description = "LSP: Organize imports", opts = opts },
-- 			{ "gtr", ":TSLspRenameFile<CR>", description = "LSP: Rename file", opts = opts },
-- 			{ "gti", ":TSLspImportAll<CR>", description = "LSP: Import missing imports", opts = opts },
-- 		})
-- 	end,
-- 	capabilities = capabilities,
-- })

-- web
-- ESLint
lsp.eslint.setup({
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- Run all eslint fixes on save
        vim.cmd([[
            augroup EslintOnSave
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> EslintFixAll
            augroup END
            ]])
    end,
    capabilities = capabilities,
})
-- CSS
default_lsp_setup("cssls")
-- HTML
default_lsp_setup("html")
-- JSON
default_lsp_setup("jsonls")

-- Null
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        -- go
        null_ls.builtins.diagnostics.golangci_lint.with({
            extra_args = {
                "--timeout=10m", "--disable-all", "-E=misspell",
                "-E=govet", "-E=revive", "-E=gofumpt", "-E=gosec", "-E=unparam",
                "-E=goconst", "-E=prealloc", "-E=stylecheck", "-E=unconvert",
                "-E=errcheck", "-E=ineffassign", "-E=unused", "-E=tparallel",
                "-E=whitespace", "-E=staticcheck", "-E=gosimple", "-E=gocritic",
            }
        }),
        -- null_ls.builtins.formatting.gofumpt,
        -- null_ls.builtins.formatting.goimports_reviser,

        -- Nix
        -- null_ls.builtins.formatting.nixfmt,
        -- null_ls.builtins.formatting.nixpkgs_fmt,
        null_ls.builtins.diagnostics.statix,
        null_ls.builtins.code_actions.statix,
    },
})

vim.diagnostic.config({
    virtual_text = true,
})

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--         virtual_text = false,
--         underline = false
--     }
-- )

-- cmp
-- local cmp = require('cmp')
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
--     ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
--     ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--     ["<C-Space>"] = cmp.mapping.complete(),
-- })
--
-- -- disable completion with tab
-- -- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil
--
-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings
-- })
--l

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'codeium' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' }
    }),
}
