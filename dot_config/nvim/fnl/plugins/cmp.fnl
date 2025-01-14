(local CompletionItemKind [:text
                           :method
                           :function
                           :constructor
                           :field
                           :variable
                           :class
                           :interface
                           :module
                           :property
                           :unit
                           :value
                           :enum
                           :keyword
                           :snippet
                           :color
                           :file
                           :reference
                           :folder
                           :enum_member
                           :constant
                           :struct
                           :event
                           :operator
                           :type_parameter])

(local Priority [:snippet
                 :property
                 :enum_member
                 :field
                 :value
                 :constructor
                 :method
                 :constant
                 :variable
                 :function
                 :class
                 :interface
                 :enum
                 :struct
                 :module
                 :unit
                 :keyword
                 :file
                 :folder
                 :text
                 :color
                 :reference
                 :event
                 :operator
                 :type_parameter])

(var priority-mapping {})
(each [i val (ipairs Priority)]
  (tset priority-mapping val i))

(fn get-priority [kind-idx]
  (. priority-mapping (. CompletionItemKind kind-idx)))

(fn setup [m]
  "Setups the cmp plugin for completion"
  (m.setup {:completion {:autocomplete false}
            :snippet {:expand (λ [args]
                                (let [snip (require "luasnip")]
                                  (snip.lsp_expand args.body)))}
            :window {:completion (m.config.window.bordered)
                     :documentation (m.config.window.bordered)}
            :mapping (m.mapping.preset.insert {"<C-q>" (m.mapping.abort)
                                               "<C-Space>" (m.mapping.complete)
                                               "<CR>" (m.mapping.confirm {:select true})
                                               "<C-j>" (m.mapping (λ [fallback]
                                                                    (if (m.visible)
                                                                        (m.select_next_item)
                                                                        (fallback))))
                                               "<C-k>" (m.mapping (λ [fallback]
                                                                    (if (m.visible)
                                                                        (m.select_prev_item)
                                                                        (fallback))))})
            :sources (m.config.sources [{:name "nvim_lsp"}
                                        {:name "luasnip"}
                                        {:name "buffer"}
                                        {:name "path"}
                                        {:name "dotenv"}])
            :sorting {:comparators [m.config.compare.exact
                                    (λ [e1 e2]
                                      (< (get-priority (e1.get_kind e1))
                                         (get-priority (e2.get_kind e2))))]
                      :priority_weight 1.0}}))

{1 "hrsh7th/nvim-cmp"
 :dependencies ["L3MON4D3/LuaSnip"
                "hrsh7th/cmp-nvim-lsp"
                "hrsh7th/cmp-buffer"
                "hrsh7th/cmp-path"
                "saadparwaiz1/cmp_luasnip"
                "SergioRibera/cmp-dotenv"]
 :keys [{1 "<C-Space>" :desc "Complete" :mode [:i :s]}]
 :config (λ []
           (let [m (require :cmp)]
             (setup m)))}
