return {
  "alexvzyl/nordic.nvim",
  lazy=false,
  priority=1000,
  config = function ()
    require("nordic").load() -- Lädt das nordic Farbschema

    -- Nachträgliche Anpassung
    vim.cmd [[
      hi WinBar guifg=#242933 guibg=#242933
    ]]
  end
}

