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
vim.g.mapleader = " "

-- packages
vim.pack.add(
	{
		-- appearance
		{ src = "https://github.com/catppuccin/nvim" },

		-- file tree
		{ src = "https://github.com/nvim-tree/nvim-tree.lua" },

		-- git
		{ src = "https://github.com/lewis6991/gitsigns.nvim" },

		-- fuzzy find
		{ src = "https://github.com/nvim-lua/plenary.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope.nvim" },

		-- keymaps
		{ src = "https://github.com/folke/which-key.nvim" },

		-- language servers
		{
			src = "https://github.com/nvim-treesitter/nvim-treesitter",
			version = 'master'
		},

		-- C#
		{ src = "https://github.com/seblyng/roslyn.nvim" },
	});

require("nvim-tree").setup {}

-- keymaps
local keymaps =
{
	-- general
	{ 'n', '<leader>o',        ':update<CR> :source<CR>',                { silent = true, desc = "Save and source file" } },
	{ 'n', '<leader>w',        ':write<CR>',                             { silent = true, desc = "Write file" } },
	{ 'n', '<leader>q',        ':quit<CR>',                              { silent = true, desc = "Quit" } },

	-- search
	{ 'n', '<leader>sf',       require("telescope.builtin").find_files,  { desc = "[S]earch [F]iles" } },
	{ 'n', '<leader>st',       require("telescope.builtin").git_files,   { desc = "[S]earch GitT] Files" } },
	{ 'n', '<leader>sh',       require("telescope.builtin").help_tags,   { desc = "[S]earch [H]elp" } },
	{ 'n', '<leader>sk',       require("telescope.builtin").keymaps,     { desc = "[S]earch [K]eymaps" } },
	{ 'n', '<leader>sg',       require("telescope.builtin").live_grep,   { desc = "[S]earch [G]rep" } },
	{ 'n', '<leader>sd',       require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" } },
	{ 'n', '<leader>sr',       require("telescope.builtin").oldfiles,    { desc = "[S]earch [R]ecent Files" } },
	{ 'n', '<leader><leader>', require("telescope.builtin").buffers,     { desc = "[ ]Search Buffers" } },

	-- language server
	{ 'n', '<leader>lf',       vim.lsp.buf.format,                       { desc = "LSP Format buffer" } },
	{ 'n', '<leader>lh',       vim.lsp.buf.hover,                        { desc = "LSP Hover" } },
	{ 'n', '<leader>ld',       vim.lsp.buf.definition,                   { desc = "Go to [D]efinition" } },
	{ 'n', '<leader>li',       vim.lsp.buf.implementation,               { desc = "Go to [I]mplementation" } },

	-- file tree
	{ 'n', '<leader>e',        ':NvimTreeToggle<CR>',                    { desc = "Open Tree [E]xplorer" } },
}

for _, map in ipairs(keymaps) do
	vim.keymap.set(map[1], map[2], map[3], map[4])
end

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
			"c:/projects/tools/lsp/roslyn/content/LanguageServer/win-x64/Microsoft.CodeAnalysis.LanguageServer.dll",
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

-- treesitter --
require('nvim-treesitter.configs').setup {
	ensure_installed =
	{
		"c",
		"c_sharp",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"markdown_inline"
	},

	auto_install = false, -- do not automatically install missing parsers

	highlight = {
		enable = true,
	},
}

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
