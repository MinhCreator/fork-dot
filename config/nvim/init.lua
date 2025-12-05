vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- keymaps
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>q!<cr>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>a", "ggVG")

require("lazy").setup({
    -- tokyonight
    { 
        "folke/tokyonight.nvim", 
        priority = 1000, 
        config = function() 
            vim.cmd.colorscheme("tokyonight-night") 
        end 
    },

    -- lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({ options = { theme = "tokyonight" } })
        end,
    },

    -- neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
        },
        keys = {
          { "<leader>e", ":Neotree toggle float<CR>" },
        },
    },

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
        },
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "python", "javascript", "html", "css", "bash", "go", "java", "markdown", "markdown_inline", "tsx" },
                highlight = { enable = true },
            })
        end,
    },

    -- lsp
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "nvim-java/nvim-java",
        },
        config = function()
            require("java").setup()
            require("mason").setup({
                ui = {
                    check_outdated_packages_on_start = false,
                }
            })
            
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "ts_ls", "html", "cssls", "gopls" },
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup({ capabilities = capabilities })
                    end,
                    ["jdtls"] = function()
                        require("java").setup_lsp_config({ capabilities = capabilities })
                    end,
                }
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                end,
            })

            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },

    -- conform
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
            },
        },
        opts = {
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                javascript = { "prettier" },
                go = { "gofmt" },
            },
        },
    },

    -- go
    { 
        "ray-x/go.nvim", 
        dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
        config = function() require("go").setup() end,
        event = {"CmdlineEnter"}, 
        ft = {"go", 'gomod'}, 
    },
    "maxandron/goplements.nvim",
    "fredrikaverpil/godoc.nvim",

    -- languages
    "nvim-flutter/flutter-tools.nvim",
    "dmmulroy/ts-error-translator.nvim",
    "dmmulroy/tsc.nvim",
    "rest-nvim/rest.nvim",
    "luckasRanarison/tailwind-tools.nvim",
    "mawkler/jsx-element.nvim",
    "farias-hecdin/CSSVarHighlight",
    "AckslD/swenv.nvim",
    "iabdelkareem/csharp.nvim",
    "Julian/lean.nvim",
    "gennaro-tedesco/nvim-jqx",

    -- markdown
    { 
        "MeanderingProgrammer/render-markdown.nvim", 
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        config = function() require('render-markdown').setup({}) end,
    },
    { 
        "iamcco/markdown-preview.nvim", 
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }, 
        build = "cd app && npm install", 
        init = function() vim.g.mkdp_filetypes = { "markdown" } end, 
        ft = { "markdown" }, 
    },
    "Zeioth/markmap.nvim",
    "Kicamon/markdown-table-mode.nvim",
    { "chomosuke/typst-preview.nvim", ft = "typst", version = "1.*" },

    -- trouble
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = { { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>" } },
        opts = {}, 
    },

    -- fidget
    { "j-hui/fidget.nvim", opts = {} },

    -- inc-rename
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end,
    },

    -- actions-preview
    {
        "aznhe21/actions-preview.nvim",
        config = function()
        end,
    },

    -- surround
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function() require("nvim-surround").setup({}) end,
    },

    -- harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()
            vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-h>", function() harpoon:list():select(4) end)
        end,
    },

    -- oil
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = { { "-", "<CMD>Oil<CR>" } },
    },

    -- yazi
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = { { "<leader>-", "<cmd>Yazi<cr>" } },
        opts = { open_for_directories = false },
    },

    -- grug-far
    {
        "MagicDuck/grug-far.nvim",
        config = function() require('grug-far').setup({}) end
    },

    -- codecompanion
    {
        "olimorris/codecompanion.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("codecompanion").setup({
                strategies = {
                    chat = { adapter = "copilot" },
                    inline = { adapter = "copilot" },
                },
            })
            vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat<cr>")
        end,
    },
})