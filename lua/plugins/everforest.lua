return {
  "sainnhe/everforest",
  lazy = false,

  config = function ()
    -- Nachträgliche Anpassung
    vim.cmd [[
    let g:everforest_background = "medium"
    ]]
  end

}
