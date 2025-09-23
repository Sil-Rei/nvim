return {
  "Saghen/blink.cmp",
  lazy = false,
  priority = 1000,
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
  },
  opts = {
    keymap = {
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up" },
      ["<C-f>"] = { "scroll_documentation_down" },
      ["<C-Space>"] = { "show" },
      ["<C-e>"] = { "hide" },
      ["<Tab>"] = { "accept", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 120,
        treesitter_highlighting = true,
        window = {
          border = "none",
        },
      },
      -- Optional: wann das Menü automatisch erscheint (z. B. TelescopePrompt ausnehmen)
      menu = {
        -- border = "rounded", -- oder "none"
        draw = {
          -- Zwei Spalten: Icon + Label | Kind-Text rechts
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "kind" },
          },
          components = {
            kind_icon = {
              text = function(item)
                local ok, lspkind = pcall(require, "lspkind")
                if not ok then
                  return ""
                end
                local sym = lspkind.symbol_map[item.kind] or ""
                return sym .. " "
              end,
              highlight = "CmpItemKind",
            },
            label = {
              text = function(item)
                return item.label
              end,
              highlight = "CmpItemAbbr",
            },
            kind = {
              text = function(item)
                return item.kind
              end,
              highlight = "CmpItemKind",
            },
          },
        },
      },
    },

    sources = {
      default = { "lsp", "buffer", "path", "snippets" },
    },

    -- schneller Matcher (Rust), mit Warnung falls Binary fehlt
    fuzzy = { implementation = "prefer_rust_with_warning" },

    -- Experimentell, aber nice:
    -- signature = { enabled = true, window = { border = "rounded" } },
  },

  config = function(_, opts)
    require("blink.cmp").setup(opts)

    -- Farben/Highlights anpassen (nach deinem Colorscheme laden)
    local set_hl = vim.api.nvim_set_hl
    local has_base_bg = function()
      local ok, res = pcall(vim.api.nvim_get_hl, 0, { name = "Normal", link = false })
      if not ok then
        return false
      end
      return res and (res.bg ~= nil)
    end

    -- Menü
    set_hl(0, "BlinkCmpMenu", { link = "NormalFloat" })
    set_hl(0, "BlinkCmpMenuBorder", {
      link = has_base_bg() and "FloatBorder" or "Comment",
    })
    set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })
    set_hl(0, "BlinkCmpGhostText", { link = "Comment" })

    -- Dokumentation
    set_hl(0, "BlinkCmpDoc", { link = "NormalFloat" })
    set_hl(0, "BlinkCmpDocBorder", {
      link = has_base_bg() and "FloatBorder" or "Comment",
    })

    -- Item-Highlights (nutzt nvim-cmp-Standardgruppen, die fast jedes Theme hat)
    set_hl(0, "CmpItemAbbr", { link = "Normal" })
    set_hl(0, "CmpItemKind", { link = "Special" })
  end,
}
