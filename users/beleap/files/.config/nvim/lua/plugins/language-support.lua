return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = {
      "hrsh7th/nvim-cmp",
      "folke/lsp-colors.nvim",
      "ray-x/lsp_signature.nvim",
      "VidocqH/lsp-lens.nvim",
      "folke/trouble.nvim",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
          ["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
          -- C-b (back) C-f (forward) for snippet placeholder navigation.
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
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
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "orgmode" },
        },
      })
    end,
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonUpdate",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "someone-stole-my-name/yaml-companion.nvim",
      "lukas-reineke/lsp-format.nvim",
    },
    config = function()
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", ",e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
      vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
      vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
      vim.keymap.set("n", ",q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        require("lsp-format").on_attach(client)

        local buf_opts = {
          noremap = true,
          silent = true,
          buffer = bufnr,
        }

        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set("n", "gd", '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>', buf_opts)
        vim.keymap.set("n", "gi", '<cmd>lua require"telescope.builtin".lsp_implementations()<CR>', buf_opts)
        vim.keymap.set("n", "gt", '<cmd>lua require"telescope.builtin".lsp_type_definitions()<CR>', buf_opts)
        vim.keymap.set("n", "gr", '<cmd>lua require"telescope.builtin".lsp_references()<CR>', buf_opts)

        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", buf_opts)
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", buf_opts)
        vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", buf_opts)
        vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", buf_opts)
        vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", buf_opts)
        vim.keymap.set(
          "n",
          "<leader>wl",
          "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
          buf_opts
        )
        vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", buf_opts)
        vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", buf_opts)
        vim.keymap.set("n", "fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", buf_opts)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig["hls"].setup({
        filetypes = { "haskell", "lhaskell", "cabal" },
      })

      local is_deno = false
      if lspconfig.util.root_pattern("deno.json", "deno.jsonc")(".") then
        is_deno = true
      end

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "yamlls" },
        automatic_installation = true,
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
        ["tsserver"] = function()
          lspconfig["tsserver"].setup({
            enabled = not is_deno,
            on_attach = on_attach,
            capabilities = capabilities,
            flags = { debounce_text_changes = 150 },
          })
        end,
        ["denols"] = function()
          lspconfig["denols"].setup({
            enabled = is_deno,
            on_attach = on_attach,
            capabilities = capabilities,
            flags = { debounce_text_changes = 150 },
            single_file_support = false,
          })
        end,
        ["yamlls"] = function()
          local cfg = require("yaml-companion").setup({
            lspconfig = {
              on_attach = on_attach,
              capabilities = capabilities,
              filetypes = { "yaml", "yaml.docker-compose", "yaml.ansible" },
            },
          })

          lspconfig["yamlls"].setup(cfg)
        end,
        ["lua_ls"] = function()
          lspconfig["lua_ls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              Lua = {
                completion = {
                  callSnippet = "Replace",
                },
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
              },
            },
          })
        end,
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("nvim-autopairs").setup()

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "folke/lsp-colors.nvim",
    config = function()
      require("lsp-colors").setup()
    end,
  },
  {
    "folke/neodev.nvim",
    config = true,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = true,
  },
  {
    "VidocqH/lsp-lens.nvim",
    config = true,
  },
  {
    "nmac427/guess-indent.nvim",
    event = "InsertEnter",
    config = true,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "VeryLazy",
    opts = {
      autocmd = { enabled = true },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "nvimtools/none-ls.nvim"
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "stylua",
          "ansible-lint",
          "codespell",
          "misspell",
          "editorconfig-checker",
          "proselint",
          "vale",
          "rustfmt",
        },
        automatic_installation = false,
        handlers = {},
      })
      require("null-ls").setup({
        sources = {
          null_ls.builtins.code_actions.gitrebase,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.completion.luasnip,
          null_ls.builtins.completion.vsnip,
          null_ls.builtins.diagnostics.fish,
          null_ls.builtins.diagnostics.terraform_validate,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.hover.dictionary,
          null_ls.builtins.hover.printenv,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = bufnr,
                })
              end,
            })
          end
        end,
      })
    end,
  },
}
