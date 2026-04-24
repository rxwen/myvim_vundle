local vimrc_path = vim.fn.stdpath("config") .. "/vimrc"
vim.cmd("source " .. vimrc_path)
-- global defaults (capabilities/on_attach/etc.)
local caps = pcall(require, "cmp_nvim_lsp") and require("cmp_nvim_lsp").default_capabilities() or nil
vim.lsp.config('*', {
  capabilities = caps,
  -- on_attach = function(client, bufnr) ... end,
})

-- per-server tweaks (leave empty tables to use defaults from nvim-lspconfig)
vim.lsp.config.ruff = {}
vim.lsp.config.ts_ls = {}
vim.lsp.config.gopls = {}
vim.lsp.config.clangd = {}
vim.lsp.config.rust_analyzer = {}
vim.lsp.config.jdtls = {}
vim.lsp.config.dartls = {}
vim.lsp.config.solargraph = {}
vim.lsp.config.lua_ls = {}

-- enable them (autostart on matching filetypes)
vim.lsp.enable({
  'ruff','ts_ls','gopls','clangd','rust_analyzer','jdtls','dartls','solargraph','lua_ls'
})

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

local ok_cc, cc_plugin = pcall(require, "codecompanion")
if not ok_cc then
    print("Warning: codecompanion is not installed.")
else
    cc_plugin.setup({
       strategies = {
        chat = {
          adapter = "openai",
        },
        inline = {
          adapter = "openai",
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              description = "Reject the suggested change",
            },
          },
        },
      },
      adapters = {
        http = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              --env = {
                --api_key = ""
              --},
            })
          end,
        }
      },
    })

	vim.keymap.set('n', '<leader>cp', function()
	  vim.api.nvim_feedkeys(":CodeCompanion ", 'n', false)
	end, { noremap = true, silent = true })

	vim.keymap.set('v', '<leader>cp', function()
	  vim.api.nvim_feedkeys(":CodeCompanion ", 'n', false)
	end, { noremap = true, silent = true })

	vim.keymap.set('n', '<leader>ct', function()
	  vim.cmd('CodeCompanionChat toggle')
	end, { noremap = true, silent = false })
end

--local ok_wilder, wilder= pcall(require, "wilder")
--if not ok_wilder then
    --print("Warning: wilder is not installed.")
--else
    --wilder.setup({modes = {':', '/', '?'}})
    --wilder.set_option('renderer', wilder.popupmenu_renderer({
      --highlighter = wilder.basic_highlighter(),
    --}))
--end
local ok_snacks, snacks_plugin = pcall(require, "snacks")
if not ok_snacks then
    print("Warning: snacks is not installed.")
else
    snacks_plugin.setup({})
end

-- Determine which AI plugin to load
local claude_available = vim.fn.executable("claude") == 1

if claude_available then
    -- Load Claude plugin
    local ok_claude, claude_plugin = pcall(require, "claudecode")
    if not ok_claude then
        print("Warning: claudecode is not installed.")
    else
        claude_plugin.setup({})
        local map = vim.keymap.set
        map("n", "<leader>ac", "<cmd>ClaudeCode<cr>",            { desc = "Toggle Claude" })
        map("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       { desc = "Focus Claude" })
        map("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   { desc = "Resume Claude" })
        map("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
        map("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })
        map("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       { desc = "Add current buffer" })
        map("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>",        { desc = "Send to Claude" })
        map("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>",     { desc = "Add file" })
        map("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",  { desc = "Accept diff" })
        map("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",    { desc = "Deny diff" })
    end
end
