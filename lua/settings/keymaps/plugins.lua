local map = vim.api.nvim_set_keymap
local fmap = vim.keymap.set
local opts = { noremap = true, silent = true }

local dap, dapui = require("dap"), require("dapui")
local dapui_widget = require("dap.ui.widgets")

local overseer = require('overseer')
local toggleterm_settings = require('settings.toggleterm')

-- Overseer
fmap("n", "<leader>ss", function()
  overseer.run_template({ name = 'Run W3m Program' })
end, opts)
fmap("n", "<leader>tt", function()
  overseer.run_template({ name = 'Open Toggleterm in Tab' })
end, opts)
fmap("n", "<leader>lg", function()
  overseer.run_template({ name = 'Open Lazygit in Tab' })
end, opts)
fmap("n", "<leader>tg", function()
  overseer.run_template({ name = 'Open Gemini in Tab' })
end, opts)
fmap("n", "<leader>sg", function()
  overseer.run_template({ name = 'Run Gemini Web Search Program' })
end, opts)
fmap("n", "<leader>tl", function()
  overseer.run_template({ name = 'Open Claude in Tab' })
end, opts)
fmap("n", "<leader>rr", function()
  -- get the file extension
  local filetype = vim.fn.expand('%:e')

  if filetype == "c" then
    overseer.run_template({ name = 'Run C Program' })
  elseif filetype == "cpp" then
    overseer.run_template({ name = 'Run C++ Program' })
  elseif filetype == "scala" then
    overseer.run_template({ name = 'Run Scala Program (Auto)' })
  else
    vim.notify(filetype .. "ファイルに対応するテンプレートはありません。", vim.log.levels.ERROR)
  end
end, opts)

-- Telescope
map('n', '<Leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>ll', ':Telescope live_grep<CR>', opts)
-- Telescope + Nvim-Notify
map("n", "<leader>nn", '<Cmd>Telescope notify<CR>', opts)

-- SessionManager
-- map('n', '<leader>lg', '<Cmd>SessionManager load_git_session<CR>', opts)
map('n', '<leader>ld', '<Cmd>SessionManager load_current_dir_session<CR>', opts)
fmap('n', '<leader>lsd', function()
  vim.cmd('SessionManager delete_current_dir_session')
  vim.notify("Current session is deleted.", "info")
end, opts)

-- NvimTree
map('n', '<Leader>ee', ':NvimTreeToggle<CR>', opts)
-- show the current file on tree outside of the Nvim-Tree buffer
map("n", "<leader>ew", '<Cmd>NvimTreeClose<CR><Cmd>NvimTreeFindFileToggle<CR>', opts)

-- dap/dapui
local function close_dapui_and_toggle_nvimtree()
  dapui.close()
  vim.cmd("NvimTreeToggle")
end
fmap('n', '<F4>', close_dapui_and_toggle_nvimtree, { desc = 'Close UI' })
fmap('n', '<F5>', dap.continue, { desc = 'Continue' })
fmap('n', '<F10>', dap.step_over, { desc = 'Step Over' })
fmap('n', '<F11>', dap.step_into, { desc = 'Step Into' })
fmap('n', '<F12>', dap.step_out, { desc = 'Step Out' })
fmap('n', '<bF5>', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
fmap('n', '<bF10>', dap.terminate, { desc = 'Terminate' })
fmap('n', '<bF11>', dap.run_last, { desc = 'Run Last' })
fmap('n', '<bF12>', dap.disconnect, { desc = 'Disconnect' })
fmap("n", "<leader>dr", dap.repl.toggle, opts)

fmap("n", "<leader>dK", dapui_widget.hover, opts)

-- copilot
fmap('n', '<C-c>', '<cmd>CopilotChatToggle<cr>', { desc = 'Toggle CopilotChat' })
fmap('v', '<C-c>', '<cmd>CopilotChatToggle<cr>', { desc = 'Toggle CopilotChat' })
fmap('n', '<leader>cp', '<cmd>CopilotChatPrompts<cr>', { desc = 'Prompts CopilotChat' })
fmap('n', '<leader>cm', '<cmd>CopilotChatCommit<cr>', { desc = 'Commit CopilotChat' })

-- toggleterm
fmap("n", "<c-t>", toggleterm_settings.toggle_float_terminal)
fmap("v", "<c-t>", toggleterm_settings.toggle_float_terminal)
fmap("t", "<c-t>", toggleterm_settings.toggle_float_terminal)

-- git
fmap('n', '<leader>mg', '<cmd>ModeGit<CR>', {
  silent = true,
  desc = '[M]ode [G]it: Start hunk navigation'
})
