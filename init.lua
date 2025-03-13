local vimrc_path = vim.fn.stdpath("config") .. "/vimrc"
vim.cmd("source " .. vimrc_path)

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    print("Warning: lspconfig is not installed. Skipping LSP setup.")
    return
else
    --lspconfig.pyright.setup {}
    lspconfig.ruff.setup {}
    lspconfig.ts_ls.setup {}
    lspconfig.gopls.setup {}
    lspconfig.clangd.setup {}
    lspconfig.rust_analyzer.setup {}
    lspconfig.jdtls.setup {}
    lspconfig.dartls.setup {}
    lspconfig.solargraph.setup {}
    lspconfig.lua_ls.setup {}
    --lspconfig.bashls.setup {}
end

local ok_gs, gitsigns_plugin = pcall(require, "gitsigns")
if not ok_gs then
    print("Warning: gitsigns is not installed.")
else
    gitsigns_plugin.setup{
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 100,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <abbrev_sha> - <summary>',
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '`' },
        untracked    = { text = '┆' },
      },
      signs_staged = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '`' },
        untracked    = { text = '┆' },
      },
      on_attach = function(bufnr)
         local gitsigns = require('gitsigns')

         local function map(mode, l, r, opts)
             opts = opts or {}
             opts.buffer = bufnr
             vim.keymap.set(mode, l, r, opts)
         end

         -- Navigation
         map('n', ']c', function()
             if vim.wo.diff then
                 vim.cmd.normal({']c', bang = true})
             else
                 gitsigns.nav_hunk('next')
             end
         end)

         map('n', '[c', function()
             if vim.wo.diff then
                 vim.cmd.normal({'[c', bang = true})
             else
                 gitsigns.nav_hunk('prev')
             end
         end)
         -- Actions
         --map('n', '<leader>gs', gitsigns.stage_hunk)
         --map('v', '<leader>gs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
         --map('n', '<leader>gS', gitsigns.stage_buffer)

         --map('n', '<leader>gr', gitsigns.reset_hunk)
         --map('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
         --map('n', '<leader>gR', gitsigns.reset_buffer)

         --map('n', '<leader>gu', gitsigns.undo_stage_hunk)
         --map('n', '<leader>gp', gitsigns.preview_hunk)
         --map('n', '<leader>gb', function() gitsigns.blame_line{full=true} end)
         --map('n', '<leader>gtb', gitsigns.toggle_current_line_blame)
         ---- map('n', '<leader>gd', gitsigns.diffthis)
         ---- map('n', '<leader>gD', function() gitsigns.diffthis('~') end)
         --map('n', '<leader>gtd', gitsigns.toggle_deleted)
     end
    }
end
