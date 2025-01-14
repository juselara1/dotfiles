(fn setup [m]
  "Setup the luasnip plugin"
  (m.setup {:update_events [:TextChanged :TextChangedI]})
  (vim.keymap.set [:i :s] :<C-j>
                  (λ [] (m.expand_or_jump)
                    {:noremap true :silent true :desc "Expand snippet"}))
  (vim.keymap.set [:i :s] :<C-k>
                  (λ [] (m.jump -1)
                    {:noremap true :silent true :desc "Previous snippet"}))
  (vim.keymap.set [:i :s] :<C-n>
                  (λ [] (if (m.choice_active) (m.change_choice 1)))
                  {:noremap true :silent true :desc "Switch snippet"}))

{1 "L3MON4D3/LuaSnip"
 :config (λ []
           (let [m (require :luasnip)]
             (setup m)))
 :keys [{1 :<C-j> :desc "Expand snippet" :mode [:i :s]}]}
