local utils = require("func.utils")

local map = vim.api.nvim_set_keymap
local fmap = vim.keymap.set
local opts = { noremap = true, silent = true }

local current_time = os.date('%Y-%m-%d %H:%M:%S')

-- system command
map('n', '<leader>fo', ':!dolphin --select %<CR>', opts)

-- utility
map('i', 'jj', '<Esc>', opts)
map('n', '<F2>', ':if &mouse == "" | set mouse=a | echo "Mouse: ON" | else | set mouse= | echo "Mouse: OFF" | endif<CR>',
  opts)
map("n", "<leader>qq", ":qall<CR>", opts)
map("t", "<C-\\><C-q><C-q>", ":qall<CR>", opts)

-- terminal
-- open by default nvim's one
map('n', '<leader>ts', '<Cmd>terminal<CR>', opts);

-- file
-- save all file
map("n", "<leader>wa", ":wall<CR>", opts)

-- clipboard operation
-- clip all notifications
fmap('n', '<leader>fn', function()
  require("settings.nvim-notify").copy_notifications_to_clipboard()
end, opts)

-- clip the [f]ile [p]ath base[n]ame
fmap('n', '<Leader>fpn', function()
  vim.fn.setreg('+', vim.fn.expand('%:t'))
  vim.notify("Copied the current file name. (" .. vim.fn.expand('%:t') .. ")", "info")
end, opts)
-- clip the [f]ile [p]ath [r]elative
fmap('n', '<Leader>fpr', function()
  vim.fn.setreg('+', vim.fn.expand('%:p:.'))
  vim.notify("Copied the current file's relative path. (" .. vim.fn.expand('%:p:.') .. ")", "info")
end, opts)
-- clip the [f]ile [p]ath [a]bsolute
fmap('n', '<Leader>fpa', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
  vim.notify("Copied the current file's absolute path. (" .. vim.fn.expand('%:p') .. ")", "info")
end, opts)
-- clip the file content
fmap('n', '<Leader>fc', function()
  local lines = vim.fn.readfile(vim.fn.expand('%:p'))
  vim.fn.setreg('+', table.concat(lines, "\n"))
  vim.notify("Copied the current file's content. (" .. current_time .. ")", "info")
end, opts)
-- clip the relative file path and the file content
fmap('n', '<Leader>fy', function()
  local lines = vim.fn.readfile(vim.fn.expand('%:p'))
  vim.fn.setreg('+', vim.fn.expand('%:p:.') .. '\n' .. table.concat(lines, "\n"))
  vim.notify("Copied the current file's relative path and content. (" .. current_time .. ")", "info")
end, opts)

-- clip the all files matched extension in that project directory
fmap('n', '<Leader>fd', function()
  local dir_paths = vim.fn.input("Enter the relative path. (e.g., /path/to/project,/path/to/project2): ",
    ".", "file")
  local extensions = vim.fn.input("Enter the included file extensions. (e.g., txt,py,java): ", "*", "file")
  local exclude_paths = vim.fn.input("Enter the excluded directory path. (e.g., node_modules,venv): ", "", "file")

  local dir_list = vim.split(dir_paths, ",")
  local ext_list = vim.split(extensions, ",")
  local exclude_list = vim.split(exclude_paths, ",")

  local matched_files = {}

  for _, dir_path in ipairs(dir_list) do
    local abs_dir_path = vim.fn.expand(dir_path)
    local all_files = {}
    utils.recursive_readdir(abs_dir_path, all_files, exclude_list)

    for _, file_path in ipairs(all_files) do
      local file_ext = string.match(file_path, "%.(%w+)$")
      if file_ext then
        for _, ext in ipairs(ext_list) do
          if file_ext == ext or extensions == "*" then
            table.insert(matched_files, file_path)
            break
          end
        end
      end
    end
  end

  if #matched_files == 0 then
    vim.notify("Nothing matched file.", "warn")
  else
    local clipboard_content = ""
    for _, file_path in ipairs(matched_files) do
      local lines = vim.fn.readfile(file_path)
      clipboard_content = clipboard_content ..
          vim.fn.expand(file_path .. ':.:h') ..
          '/' .. vim.fn.expand(file_path .. ':t') .. '\n' .. table.concat(lines, "\n") .. '\n'
    end
    vim.fn.setreg('+', clipboard_content)
    vim.notify("Copied the all matched files' relative path and content. (" .. current_time .. ")", "info")

    vim.fn.input("Copied successfully! Press Enter to return.", "")
  end
end, opts)
