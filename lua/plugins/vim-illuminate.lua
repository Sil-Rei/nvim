return {
  "RRethy/vim-illuminate",
  lazy = false,
  config = function()
    require("illuminate").configure({
      filetypes_denylist={
        "NvimTree", "nvim-tree"
      }
    })
  end
}
