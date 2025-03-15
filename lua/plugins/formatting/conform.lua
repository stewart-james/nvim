return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        ignore = function()
          local filename = vim.api.nvim_buf_get_name(bufnr)
          return filename:match 'keybindings.lua'
        end,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      cs = { 'csharpier' },
    },
  },
}
