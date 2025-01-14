(import-macros {: exec!} :hibiscus.vim)

(fn setup [m]
  "Setups the kanagawa colorscheme."
  (m.setup {:compile true :transparent true})
  (exec! [colorscheme kanagawa-wave]))

{1 "rebelot/kanagawa.nvim"
 :config (λ []
           (let [m (require :kanagawa)]
             (setup m)))}
