local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- existing mappings
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    -- format (async)
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, opts)

    -- Open diagnostics
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = bufnr })

    -- open only WARNINGS
    vim.keymap.set("n", "<leader>W", function()
        vim.diagnostic.open_float(nil, { severity = vim.diagnostic.severity.WARN })
    end, { buffer = bufnr })

    -- open only HINTS
    vim.keymap.set("n", "<leader>H", function()
        vim.diagnostic.open_float(nil, { severity = vim.diagnostic.severity.HINT })
    end, { buffer = bufnr })
end

return {
    {
        "folke/neodev.nvim",
        config = true,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    -- Required if you use snippets like function(...) -> ... end
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),            -- Manually trigger completion by using 'Ctrl + Space'
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected suggestion by pressing enter
                    ["<Tab>"] = cmp.mapping.select_next_item(),        -- Navigate forward
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),      -- Navigate backward
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }),
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/neodev.nvim",    -- 1) declare neodev as a hard dependency
            "hrsh7th/cmp-nvim-lsp", -- if you’re using nvim-cmp for capabilities
        },
        config = function()
            require("neodev").setup()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lspconfig.lua_ls.setup({
                on_attach    = on_attach,
                capabilities = capabilities,
                settings     = {
                    Lua = {
                        runtime = { version = "LuaJIT" },      -- nvim embeds LuaJIT
                        diagnostics = { globals = { "vim" } }, -- recognize `vim` global
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                        telemetry = { enable = false },
                    },
                },
            })

            lspconfig.rust_analyzer.setup({
                filetypes = { "rust" },
                root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        checkOnSave = {
                            command = "clippy"
                        },
                    },
                },
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                automatic_enable = true,
                ensure_installed = { "clangd", "lua_ls" },
                automatic_installation = true,
            })
        end,
    },
    {
        "mhartington/oceanic-next", -- Oceanic Next theme repo
        lazy = false,               -- load immediately so :colorscheme works
        priority = 1000,            -- high priority to apply before others :contentReference[oaicite:1]{index=1}
        config = function()
            -- enable true-color support
            vim.opt.termguicolors = true -- use 24-bit RGB colors in the terminal :contentReference[oaicite:2]{index=2}
            -- turn on the built-in syntax engine
            vim.cmd("syntax enable")     -- ensure syntax groups are defined :contentReference[oaicite:3]{index=3}

            -- optional: enable terminal bold/italic (requires a compatible font & terminal)
            vim.g.oceanic_next_terminal_bold = 1   -- allow bold fonts :contentReference[oaicite:4]{index=4}
            vim.g.oceanic_next_terminal_italic = 1 -- allow italic fonts :contentReference[oaicite:5]{index=5}

            -- finally, apply the theme
            vim.cmd("colorscheme OceanicNext") -- set Oceanic Next as your colorscheme :contentReference[oaicite:6]{index=6}
        end,
    },
}
