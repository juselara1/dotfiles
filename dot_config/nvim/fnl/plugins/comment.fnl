(fn setup [m]
  "Setups comment.nvim plugin."
  (m.setup {:sticky false
            :opleader {:line :gc}
            :mappings {:basic true :extra false}}))

{1 "numToStr/Comment.nvim"
 :event [:BufReadPre :BufNewFile]
 :config (λ []
           (let [m (require :Comment)]
             (setup m)))}
