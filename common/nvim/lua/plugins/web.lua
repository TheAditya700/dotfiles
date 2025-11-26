return {
  -- Simple web search integration
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- Google search keybinding
      {
        "<leader>sg",
        function()
          local search_term = vim.fn.input("Google Search: ")
          if search_term ~= "" then
            local url = "https://www.google.com/search?q=" .. vim.fn.shellescape(search_term)
            vim.fn.system({ "xdg-open", url })
            print("Searching for: " .. search_term)
          end
        end,
        desc = "Google Search",
      },
      -- Stack Overflow search
      {
        "<leader>ss",
        function()
          local search_term = vim.fn.input("Stack Overflow Search: ")
          if search_term ~= "" then
            local url = "https://stackoverflow.com/search?q=" .. vim.fn.shellescape(search_term)
            vim.fn.system({ "xdg-open", url })
            print("Searching Stack Overflow for: " .. search_term)
          end
        end,
        desc = "Stack Overflow Search",
      },
      -- GitHub search
      {
        "<leader>sh",
        function()
          local search_term = vim.fn.input("GitHub Search: ")
          if search_term ~= "" then
            local url = "https://github.com/search?q=" .. vim.fn.shellescape(search_term)
            vim.fn.system({ "xdg-open", url })
            print("Searching GitHub for: " .. search_term)
          end
        end,
        desc = "GitHub Search",
      },
    },
  },

  -- URL highlighting and opening
  {
    "icholy/urlview.nvim",
    keys = {
      {
        "<leader>u",
        function()
          require("urlview").search()
        end,
        desc = "Browse URLs in buffer",
      },
    },
    opts = {
      default_action = "xdg-open",
    },
  },

  -- Open URLs under cursor
  {
    "tyru/open-browser.vim",
    keys = {
      { "gx", "<Plug>(openbrowser-smart-search)", desc = "Open URL under cursor", mode = { "n", "v" } },
      { "<leader>ob", "<Plug>(openbrowser-open)", desc = "Open browser", mode = "n" },
    },
  },

  -- Markdown preview in browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
  },
}