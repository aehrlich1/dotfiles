-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Open the snacks explorer sidebar when starting nvim in a directory (or with no file)
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("auto_open_explorer", { clear = true }),
  callback = function()
    local arg = vim.fn.argv(0)
    if arg == "" or vim.fn.isdirectory(arg) == 1 then
      require("snacks").explorer()
    end
  end,
})
