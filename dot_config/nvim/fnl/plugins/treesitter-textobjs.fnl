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
  "Setups treesitter-textobjs"
  (m.setup {:textobjects {:select {:enable true
                                   :lookahead true
                                   :keymaps {:a= {:query "@assignment.outer"
                                                  :desc "Around assignment."}
                                             :i= {:query "@assignment.outer"
                                                  :desc "Inside assignment."}
                                             :l= {:query "@assignment.lhs"
                                                  :desc "Left of assignment."}
                                             :r= {:query "@assignment.rhs"
                                                  :desc "Right of assignment."}
                                             :af {:query "@function.outer"
                                                  :desc "Around function."}
                                             :if {:query "@function.inner"
                                                  :desc "Inside function."}
                                             :ac {:query "@class.outer"
                                                  :desc "Around class."}
                                             :ic {:query "@class.inner"
                                                  :desc "Inside class."}}}}}))

{1 "nvim-treesitter/nvim-treesitter-textobjects"
 :dependencies ["nvim-treesitter/nvim-treesitter"]
 :config (λ []
           (let [m (require :nvim-treesitter.configs)]
             (setup m)))
 :ft filetypes}
