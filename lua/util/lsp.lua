local M = {}

M.on_attach = function(client, bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
  end

  local ok_snacks, Snacks = pcall(require, "snacks")
  local P = ok_snacks and Snacks.picker or nil

  map("n", "gd", function()
    if P and P.lsp_definitions then
      P.lsp_definitions()
    else
      vim.lsp.buf.definition()
    end
  end, "Goto Definition")

  map("n", "gD", vim.lsp.buf.definition, "Goto Definition (direct)")

  map("n", "gr", function()
    if P and P.lsp_references then
      P.lsp_references()
    else
      vim.lsp.buf.references()
    end
  end, "References")

  map("n", "gI", function()
    if P and P.lsp_implementations then
      P.lsp_implementations()
    else
      vim.lsp.buf.implementation()
    end
  end, "Implementations")

  map("n", "gy", function()
    if P and P.lsp_type_definitions then
      P.lsp_type_definitions()
    else
      vim.lsp.buf.type_definition()
    end
  end, "Type Definitions")

  -- Code Action / Rename
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")

  -- Diagnostics (Saga -> native)
  map("n", "<leader>d", function()
    vim.diagnostic.open_float(nil, {
      scope = "line",
      border = "rounded",
    })
  end, "Line Diagnostics")

  -- Hover
  map("n", "K", vim.lsp.buf.hover, "Hover")

  -- Optional: Diagnostics Liste im Picker
  map("n", "<leader>sd", function()
    if P and P.diagnostics then
      P.diagnostics()
    else
      vim.diagnostic.setloclist()
    end
  end, "Diagnostics Picker")
end

return M
