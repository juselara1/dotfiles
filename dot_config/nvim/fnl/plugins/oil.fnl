(import-macros {: map!} :hibiscus.vim)

(fn setup [m]
  "Setups the Oil file manager."
  (m.setup {:default_file_explorer true
            :columns [:icon :permissions]
            :float {:preview_split :right}
            :view_options {:show_hidden true}})
  (map! [n] "<leader>o" #(m.toggle_float) "[O]il file explorer"))

{1 "stevearc/oil.nvim"
 :dependencies ["nvim-tree/nvim-web-devicons"]
 :keys [{1 "<leader>o" :desc "[O]il file explorer."}]
 :config (λ []
           (let [m (require :oil)]
             (setup m)))}
