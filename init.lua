vim.o.number = true         -- display line numbers
vim.o.relativenumber = true -- display relative line numbers
vim.o.signcolumn = "yes"    -- always show the sign column

vim.o.wrap = false          -- disable line wrapping

vim.o.tabstop = 4           -- a tab should LOOK like 4 characters
vim.o.softtabstop = 4       -- a tab should insert 1 tab ( equivilent of 4 spaces )
vim.o.shiftwidth = 4        -- a tab should insert 1 column ( equivilent of 4 spaces)
vim.o.expandtab = false     -- use tabs not spaces
vim.o.autoindent = true     -- automatically copy the indentation of the current line when starting a new line

vim.o.swapfile = false      -- disable creation of swapfiles

-- keymaps
vim.g.mapleader = " "
local keymaps =
{
	{ 'n', '<leader>o',  ':update<CR> :source<CR>', { silent = true, desc = "Save and source file" } },
	{ 'n', '<leader>w',  ':write<CR>',              { silent = true, desc = "Write file" } },
	{ 'n', '<leader>q',  ':quit<CR>',               { silent = true, desc = "Quit" } },
	{ 'n', '<leader>lf', vim.lsp.buf.format,        { desc = "LSP Format buffer" } },
	{ 'n', '<leader>lh', vim.lsp.buf.hover,         { desc = "LSP Hover" } },
}

for _, map in ipairs(keymaps) do
	vim.keymap.set(map[1], map[2], map[3], map[4])
end

-- packages
vim.pack.add(
	{
		-- Appearance
		{ src = "https://github.com/catppuccin/nvim" },

		-- Language server
		{ src = "https://github.com/neovim/nvim-lspconfig" },

		{
			src = "https://github.com/lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '~' },
				}
			}
		},
	});

-- language servers
vim.lsp.enable({ "lua_ls" })

vim.cmd("colorscheme catppuccin")
