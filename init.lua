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
	-- general
	{ 'n', '<leader>o',  ':update<CR> :source<CR>', { silent = true, desc = "Save and source file" } },
	{ 'n', '<leader>w',  ':write<CR>',              { silent = true, desc = "Write file" } },
	{ 'n', '<leader>q',  ':quit<CR>',               { silent = true, desc = "Quit" } },

	-- language server
	{ 'n', '<leader>lf', vim.lsp.buf.format,        { desc = "LSP Format buffer" } },
	{ 'n', '<leader>lh', vim.lsp.buf.hover,         { desc = "LSP Hover" } },

	-- file tree
	{ 'n', '<leader>e',  ':NvimTreeToggle<CR>',     { desc = "Open Tree [E]xplorer" } },
}

for _, map in ipairs(keymaps) do
	vim.keymap.set(map[1], map[2], map[3], map[4])
end

-- packages
vim.pack.add(
	{
		-- appearance
		{ src = "https://github.com/catppuccin/nvim" },

		-- file tree
		{ src = "https://github.com/nvim-tree/nvim-tree.lua" },

		-- git
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

		-- C#
		{ src = "https://github.com/seblyng/roslyn.nvim" },
	});

-- language servers
local lsps =
{
	lua_ls = {
		cmd = { 'lua-language-server' },
		filetypes = { 'lua' },
		root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
	},

	roslyn = {
		cmd = {
			"dotnet",
			"c:/projects/apps/lsp/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll",
			"--logLevel=Information",
			"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
			"--stdio",
		},
	}
}

for name, config in pairs(lsps) do
	vim.lsp.config[name] = config
	vim.lsp.enable(name)
end

-- auto complete
vim.cmd("set completeopt+=noselect")
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.cmd("colorscheme catppuccin")
