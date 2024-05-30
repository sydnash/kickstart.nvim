local has_nvim_tree, _ = pcall(require, 'nvim-tree.api')
if has_nvim_tree then
  local function open_nvim_tree(data)
    -- buffer is a real file on the disk
    local real_file = vim.fn.filereadable(data.file) == 1

    -- buffer is a [No Name]
    local no_name = data.file == '' and vim.bo[data.buf].buftype == ''

    if not real_file and not no_name then
      return
    end

    -- open the tree, find the file but don't focus it
    require('nvim-tree.api').tree.toggle { focus = false, find_file = true }
  end

  vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>', { desc = '[T]oggle [N]vim-tree' })
  -- vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
end
