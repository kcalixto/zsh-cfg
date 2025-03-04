vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'preview', 'fuzzy' }
vim.opt.shortmess:append { c = true }
vim.keymap.set('n', '<space>ss',
  function()
    vim.lsp.buf.format()
    -- require('conform').format()
    vim.cmd('w')
    vim.notify('File saved successfully', vim.log.levels.INFO)
  end,
  { desc = "Format and save the file" }
)
--
local cmp = require 'cmp'
local luasnip = require("luasnip")
local lspkind = require('lspkind')
local kind_formatter = lspkind.cmp_format {
  mode = "symbol_text",
  menu = {
    buffer = "[buf]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[api]",
    path = "[path]",
    luasnip = "[snip]",
    gh_issues = "[issues]",
    tn = "[TabNine]",
    eruby = "[erb]",
  },
}
--
lspkind.init({
  symbol_map = {
    Copilot = '',
  }
})
--
cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lsp_signature_help' },
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete(),
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },

  formatting = {
    fields = { "abbr", "kind", "menu" },
    expandable_indicator = true,
    format = function(entry, vim_item)
      -- Lspkind setup for icons
      vim_item = kind_formatter(entry, vim_item)

      -- Tailwind colorizer setup
      vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

      return vim_item
    end,
  },
}

vim.keymap.set({ 'i', 's' }, "<C-k>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, "<C-j>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })
