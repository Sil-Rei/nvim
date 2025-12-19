return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  keys = {
    {
      "<A-h>",
      function()
        require("smart-splits").move_cursor_left()
      end,
      desc = "Move to left split",
    },
    {
      "<A-j>",
      function()
        require("smart-splits").move_cursor_down()
      end,
      desc = "Move to bottom split",
    },
    {
      "<A-k>",
      function()
        require("smart-splits").move_cursor_up()
      end,
      desc = "Move to top split",
    },
    {
      "<A-l>",
      function()
        require("smart-splits").move_cursor_right()
      end,
      desc = "Move to right split",
    },
  },
  opts = {
    default_amount = 3,
    at_edge = "wrap",
    multiplexer_integration = "wezterm",
  },
}
