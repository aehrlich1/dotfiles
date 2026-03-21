vim.g.mapleader = ' '
local vscode = require 'vscode'
vim.opt.clipboard = 'unnamedplus'
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.keymap.set('n', '<leader>ff', function() vscode.action 'workbench.action.quickOpenPreviousEditor' end)
vim.keymap.set('n', '<leader>fp', function() vscode.action 'workbench.action.openRecent' end)
vim.keymap.set('n', '<leader>sg', function() vscode.action 'workbench.action.quickTextSearch' end)
vim.keymap.set('n', '<leader>ss', function() vscode.action 'workbench.action.gotoSymbol' end)
vim.keymap.set('n', '<leader>sS', function() vscode.action 'workbench.action.showAllSymbols' end)
vim.keymap.set('n', '<leader>cf', function() vscode.action 'editor.action.formatDocument' end)
vim.keymap.set('n', '<leader>cr', function() vscode.action 'editor.action.rename' end)
vim.keymap.set('n', '<leader>db', function() vscode.action 'editor.debug.action.toggleBreakpoint' end)
vim.keymap.set('n', '<leader>ds', function() vscode.action 'workbench.action.debug.selectandstart' end)
vim.keymap.set('n', '<leader>dc', function() vscode.action 'jupyter.runAndDebugCell' end)
vim.keymap.set('n', 'za', function() vscode.action 'editor.toggleFold' end)
vim.keymap.set('n', '<C-w>c', function() vscode.action 'workbench.action.closeEditorsInGroup' end)
vim.keymap.set('n', '<C-h>', function() vscode.action 'workbench.action.focusLeftGroup' end)
vim.keymap.set('n', '<C-l>', function() vscode.action 'workbench.action.focusRightGroup' end)
vim.keymap.set('n', '<C-j>', function() vscode.action 'workbench.action.focusBelowGroup' end)
vim.keymap.set('n', '<C-k>', function() vscode.action 'workbench.action.focusAboveGroup' end)

vim.keymap.set('n', '-', '/')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', 'p', ']p', { noremap = true })
vim.keymap.set('n', 'P', '[p', { noremap = true })
