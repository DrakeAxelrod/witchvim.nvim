local M = {}

-- taken from packer (https://github.com/wbthomason/packer.nvim/blob/master/LICENSE)
if jit ~= nil then
  M.is_windows = jit.os == 'Windows'
else
  M.is_windows = package.config:sub(1, 1) == '\\'
end

function M.get_separator()
  if M.is_windows then
    return '\\'
  end
  return '/'
end

function M.join_path(...)
  local separator = M.get_separator()
  return table.concat({ ... }, separator)
end
-- taken from packer (https://github.com/wbthomason/packer.nvim/blob/master/LICENSE)


-- paths
M.packages_root = M.join_path(vim.fn.stdpath 'data', 'site', 'pack')
M.plugins_path = M.join_path(M.packages_root, "packer", "start")

-- install packer if needed
function M.packer_bootstrap()
  local install_path = M.join_path(M.plugins_path, "packer.nvim")
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute(
      "!git clone https://github.com/wbthomason/packer.nvim " .. install_path
    )
  end
end

return M