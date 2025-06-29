local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        nix = { "nixfmt", "nixpkgs_fmt" },
        nim = { "nimpretty" },
        go = { "gofumpt", "goimports-reviser" },
        lua = { "stylua" },
        rust = { "rustfmt" },
        haskell = { "stylish-haskell" },
        python = { "black" },
        shell = { "shellcheck" },
        json = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
    },
    format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    },
})
