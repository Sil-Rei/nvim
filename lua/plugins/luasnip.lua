return {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp', -- if you're on windows remove this line
     dependencies = {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
         

  require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath 'config' .. '/snippets' } })
end
}
}
