return {
  "alexvzyl/nordic.nvim",
  lazy=false,
  priority=1000,
  config = function ()
    require("nordic").load()

    -- Nachträgliche Anpassung
    vim.cmd [[
      hi WinBar guifg=#242933 guibg=#242933
    ]]
  end
}

