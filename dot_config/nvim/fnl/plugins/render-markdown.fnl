(import-macros {: map!} :hibiscus.vim)

(fn setup [m]
  "Setups the Render Markdown plugin."
  (m.setup {})
  (map! [n] "<leader>m" ":RenderMarkdown toggle" "[M]arkdown mode toggle."))

{1 "MeanderingProgrammer/render-markdown.nvim"
 :dependencies ["nvim-treesitter/nvim-treesitter" "nvim-tree/nvim-web-devicons"]
 :keys [{1 "<leader>m" :desc "[M]arkdown mode toggle."}]
 :config (λ []
           (let [m (require :render-markdown)]
             (setup m)))
 :ft [:markdown]
}
