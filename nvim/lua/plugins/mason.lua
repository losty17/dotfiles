return {
  -- Add these completion plugins
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 750 },
          { name = 'buffer', priority = 500 },
          { name = 'path', priority = 250 },
        }),
        formatting = {
          format = function(entry, item)
            -- Show source in completion menu
            item.menu = ({
              nvim_lsp = '[LSP]',
              luasnip = '[Snippet]',
              buffer = '[Buffer]',
              path = '[Path]',
            })[entry.source.name]
            return item
          end,
        },
        experimental = {
          ghost_text = true, -- VSCode-like ghost text
        },
      })
    end,
  },
  
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      -- Get default capabilities with completion support
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      local function setup_ts_ls()
        vim.lsp.config("ts_ls", {
          capabilities = capabilities,
          settings = {
            typescript = {
              suggest = {
                includeCompletionsForModuleExports = true,
                includeAutomaticOptionalChainCompletions = true,
              },
              preferences = {
                includePackageJsonAutoImports = "auto",
                importModuleSpecifierPreference = "relative",
              },
            },
            javascript = {
              suggest = {
                includeCompletionsForModuleExports = true,
                includeAutomaticOptionalChainCompletions = true,
              },
              preferences = {
                includePackageJsonAutoImports = "auto",
                importModuleSpecifierPreference = "relative",
              },
            },
          },
          commands = {
            OrganizeImports = {
              function()
                local params = {
                  command = "_typescript.organizeImports",
                  arguments = { vim.api.nvim_buf_get_name(0) },
                  title = "",
                }
                local client = vim.lsp.get_clients({ name = "ts_ls" })[1]
                if client then
                  client:exec_cmd(params)
                end
              end,
              description = "Organize Imports",
            },
          },
        })
      end

      local function setup_pyright()
        vim.lsp.config("pyright", {
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
              },
            },
          },
        })
      end

      local function setup_gopls()
        vim.lsp.config("gopls", {
          capabilities = capabilities,
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = true,
              completeUnimported = true, -- Auto-complete unimported packages
              usePlaceholders = true,
              matcher = "Fuzzy",
            },
          },
        })
      end

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = { 'lua_ls', 'ts_ls', 'pyright', 'gopls' },
        handlers = {
          function(server_name)
            vim.diagnostic.config({
              virtual_text = true,
              signs = true,
              update_in_insert = false,
              float = {
                source = "always",
                header = "",
                prefix = "",
              },
            })

            if server_name == 'ts_ls' then
              setup_ts_ls()
            elseif server_name == 'pyright' then
              setup_pyright()
            elseif server_name == 'gopls' then
              setup_gopls()
            else
              vim.lsp.config(server_name, { capabilities = capabilities })
            end

            vim.lsp.enable({ server_name })

            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('LspOrganizeImports', { clear = true }),
              desc = "Organize Imports on Save",
              callback = function(opts)
                if (
                  vim.bo[opts.buf].filetype == 'typescriptreact' or
                  vim.bo[opts.buf].filetype == 'typescript' or
                  vim.bo[opts.buf].filetype == 'javascript' or
                  vim.bo[opts.buf].filetype == 'javascriptreact'
                ) then
                  vim.cmd("OrganizeImports")
                elseif vim.bo[opts.buf].filetype == 'go' then
                  -- gopls handles imports automatically on format
                  vim.lsp.buf.format({ async = false })
                elseif vim.bo[opts.buf].filetype == 'python' then
                  vim.cmd("Black")
                end
              end
            })
          end,
        }
      })

      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics in loclist' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
    end,
  }
}
