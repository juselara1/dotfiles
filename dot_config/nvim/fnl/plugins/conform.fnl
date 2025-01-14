(fn setup [m]
  "Setups the Conform plugin for formatting."
  (m.setup {:formatters_by_ft {:fennel [:fnlfmt]
                               :lua [:stylua]
                               :python [:ruff_format]
                               :json [:jq]
                               :c [:clang-format]
                               :terraform [:terraform_fmt]}})
  (vim.keymap.set :n "<leader>cf" (partial m.format {:bufnr 0})
                  {:noremap true :silent true :desc "[C]ode [F]ormat"}))

{1 "stevearc/conform.nvim"
 :dependencies ["nvim-tree/nvim-web-devicons"]
 :keys [{1 "<leader>cf" :desc "[C]ode [F]ormat."}]
 :config (λ []
           (let [m (require :conform)]
             (setup m)))}
