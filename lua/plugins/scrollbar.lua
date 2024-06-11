return {
 "dstein64/nvim-scrollview",
  lazy=false,
  
  config = function()
  require('scrollview').setup({
  excluded_filetypes = {'nvim-tree', "NvimTree"},
  current_only = true,
})
  end
}
