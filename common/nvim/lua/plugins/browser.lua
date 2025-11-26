return {
  -- Full-featured browser integration
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cmd = { "SnipRun" },
    keys = {
      {
        "<leader>sb",
        function()
          require("sniprun").run("browser")
        end,
        desc = "Open Browser",
      },
    },
  },

  -- Markdown preview with browser
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

  -- Quick web search with results in Neovim
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    keys = {
      {
        "<leader>sg",
        function()
          local search_term = vim.fn.input("Google Search: ")
          if search_term ~= "" then
            -- Open in browser
            local url = "https://www.google.com/search?q=" .. vim.fn.shellescape(search_term)
            vim.fn.system({ "xdg-open", url })
            
            -- Also show in telescope if you have web-search.nvim
            require("telescope").extensions.web_search.web_search({
              search_engine = "google",
              default_search = search_term,
            })
          end
        end,
        desc = "Google Search",
      },
      {
        "<leader>sw",
        function()
          require("telescope").extensions.web_search.web_search()
        end,
        desc = "Web Search (Telescope)",
      },
    },
  },

  -- Web search extension for telescope
  {
    "nvim-telescope/telescope-web-search.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("web_search")
    end,
  },

  -- Browser-like navigation
  {
    "tyru/open-browser.vim",
    keys = {
      { "gx", "<Plug>(openbrowser-smart-search)", desc = "Open URL" },
      { "<leader>ob", "<Plug>(openbrowser-open)", desc = "Open Browser" },
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
        desc = "Browse URLs",
      },
    },
    opts = {
      default_action = "xdg-open",
    },
  },
}