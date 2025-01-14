(local F (require :functions))

(fn var-snippet [s i fmta]
  "Defines the snippet declare variables"
  (s "@var" (fmta "(local <name> <value>)"
                  {:name (i 1 "name") :value (i 2 "value")})))

(fn import-snippet [s i fmta]
  "Defines the snippet to import packages"
  (s "@import"
     (fmta "(local <name> (require :<module>))"
           {:name (i 1 "name") :module (i 2 "module")})))

(fn fn-snippet [s c i fmta]
  "Defines the snippet for functions"
  (s "@fn" (c 1
              [(fmta "(fn <name> [<params>]
  <body>)"
                     {:name (i 1 "name")
                      :params (i 2 "")
                      :body (i 3 "body")})
               (fmta "(λ [<params>] <body>)"
                     {:params (i 1 "") :body (i 2 "body")})])))

(fn for-snippet [s i fmta]
  "Defines the snippet for a for loop"
  (s "@for" (fmta "(each [<key> <value> (pairs <iterable>)] <body>)"
                  {:key (i 1 "key")
                   :value (i 2 "value")
                   :iterable (i 3 "iterable")
                   :body (i 4 "body")})))

(fn let-snippet [s i fmta]
  "Defines the snippet for the let statement"
  (s "@let"
     (fmta "(let [<variables>] <body>)"
           {:variables (i 1 "variables") :body (i 2 "body")})))

(fn setup [ls fm]
  "Setup fnl snippets"
  (let [s (. ls :snippet)
        c (. ls :choice_node)
        i (. ls :insert_node)
        fmta (. fm :fmta)]
    (ls.add_snippets "fennel"
                     [(var-snippet s i fmta)
                      (import-snippet s i fmta)
                      (fn-snippet s c i fmta)
                      (for-snippet s i fmta)
                      (let-snippet s i fmta)])))

(let [ls (F.safe-require "luasnip")
      fm (F.safe-require "luasnip.extras.fmt")]
  (if (and (not= ls nil) (not= fm nil))
      (setup ls fm)))
