(import-macros {: map!} :hibiscus.vim)

(local filetypes [:lua
                  :python
                  :markdown
                  :c
                  :bash
                  :dockerfile
                  :gitignore
                  :json
                  :yaml
                  :toml])

(fn setup [m]
  "Setups the trevj plugin."
  (map! [n] "<leader>j" #(m.format_at_cursor) "Inverse [J]oin lines"))

{1 "AckslD/nvim-trevJ.lua"
 :dependencies ["nvim-treesitter/nvim-treesitter"]
 :keys [{1 "<leader>j" :desc "Inverse [J]oin lines"}]
 :config (λ []
           (let [m (require :trevj)]
             (setup m)))
 :ft filetypes
}
