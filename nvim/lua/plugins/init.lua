return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
  			"bash-language-server", "lua-language-server", "stylua", "gopls",
  			"html-lsp", "css-lsp" , "prettier"
  		},
  	},
  },
  -- 
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  		"bash",	"vim", "lua", "vimdoc", "python",
       "html", "css", "markdown", "go"
  		},
  	},
  },
}
