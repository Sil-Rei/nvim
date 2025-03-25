return {
  "leath-dub/snipe.nvim",
  keys = {
    {
      "<leader><leader>",
      function()
        require("snipe").open_buffer_menu()
      end,
      desc = "Open Snipe buffer menu",
    },
  },
  opts = {
    ui = {
      position = "topleft", -- Fensterposition
      buffer_format = {
        -- Beispiel: Dateiname, Icon, Verzeichnis
        "filename",
        "icon",
      },
    },
  },
}
