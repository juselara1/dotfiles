(local filetypes [:lua
                  :python
                  :markdown
                  :c
                  :bash
                  :dockerfile
                  :gitignore
                  :json
                  :yaml
                  :toml
                  :terraform
                  :fennel])

(fn setup [m]
  "Setups treesitter on certain filetypes."
  (m.setup {:ensure_installed filetypes
            :sync_install true
            :auto_install false
            :highlight {:enable true}
            :incremental_selection {:enable true
                                    :keymaps {:init_selection :gnn
                                              :node_incremental :gan
                                              :node_decremental :gdn}}}))

{1 "nvim-treesitter/nvim-treesitter"
 :config (λ []
           (let [m (require :nvim-treesitter.configs)]
             (setup m)))
 :ft filetypes}
