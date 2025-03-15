local wk = require 'which-key'

local groups = {
  { '<leader>c', group = '[C]ode' },
  { '<leader>d', group = '[D]ocument' },
  { '<leader>g', group = '[G]it' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
}

local builtin = require 'telescope.builtin'

local bindings = {
  {'<leader>df', function() require('conform').format { async = true, lsp_fallback = true } end, mode = '', desc = '[F]ormat buffer'},

  -- Search
  {'<leader>sh', builtin.help_tags, mode = 'n', desc = '[S]earch [H]elp'},
  {'<leader>sk', builtin.keymaps, mode = 'n', desc = '[S]earch [K]eymaps'},
  {'<leader>sf', builtin.find_files, mode = 'n', desc = '[S]earch [F]iles'},
  {'<leader>st', builtin.git_files, mode = 'n', desc = '[S]earch gi[T] files'},
  {'<leader>ss', builtin.lsp_dynamic_workspace_symbols, mode = 'n', desc = '[S]earch workspace [S]ymbols'},
  {'<leader>sds', builtin.lsp_workspace_symbols, mode = 'n', desc = '[S]earch [D]ocument [S]ymbols'},
  {'<leader>sw', builtin.grep_string, mode = 'n', desc = '[S]earch current [W]ord'},
  {'<leader>sg', builtin.live_grep, mode = 'n', desc = '[S]earch by [G]rep'},
  {'<leader>sd', builtin.diagnostics, mode = 'n', desc = '[S]earch [D]iagnostics'},
  {'<leader>sr', builtin.resume, mode = 'n', desc = '[S]earch [R]esume'},
  {'<leader>s.', builtin.oldfiles, mode = 'n', desc = '[S]earch Recent Files ("." for repeat)'},
  {'<leader><leader>', builtin.buffers, mode = 'n', desc = '[ ] Find existing buffers'},
  {'<leader>/', function() builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false }) end, mode = 'n', desc = '[/] Fuzzily search in current buffer'},
  {'<leader>s/', function() builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end, mode = 'n', desc = '[S]earch [/] in Open Files'},
  {'<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, mode = 'n', desc = '[S]earch [N]eovim files'},

  -- Git
  {'<leader>gs', '<cmd>Neogit<CR>', mode = 'n', desc = 'Open Neogit' },
}

wk.add(groups)
wk.add(bindings)
