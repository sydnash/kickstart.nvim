local function is_plugin_installed(plugin_name)
  -- 获取当前的 runtimepath
  local runtime_path = vim.api.nvim_list_runtime_paths()
  -- 检查 plugin_name 是否存在于 runtimepath 中
  for _, path in ipairs(runtime_path) do
    if path:find(plugin_name, 0, true) then
      return true
    end
  end
  return false
end

if is_plugin_installed 'nvim-tree.lua' then
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

  vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
end
