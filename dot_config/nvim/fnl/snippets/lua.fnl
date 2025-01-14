(local F (require :functions))

(fn var-snippet [s c i fmta]
  "Defines the snippets to create variables"
  (s "@var"
     (c 1 [(fmta "<name> = <value>" {:name (i 1 "name") :value (i 2 "value")})
            (fmta "local <name> = <value>"
                  {:name (i 1 "name") :value (i 2 "value")})])))

(fn import-snippet [s i fmta]
  "Defines the snippet to import packages"
  (s "@import"
     (fmta "local <name> = require(\"<module>\")"
           {:name (i 1 "name") :module (i 2 "module")})))

(fn fn-snippet [s c i fmta]
  "Defines the snippet for functions"
  (s "@fn" (c 1
              [(fmta "function <name>(<params>)
  <body>
end" {:name (i 1 "name")
                           :params (i 2 "")
                           :body (i 3 "body")})
               (fmta "local function <name>(<params>)
  <body>
end" {:name (i 1 "name")
                           :params (i 2 "")
                           :body (i 3 "body")})
               (fmta "function (<params>) <body> end"
                     {:params (i 1 "") :body (i 2 "body")})])))

(fn for-snippet [s c i fmta]
  "Defines the snippet for a for loop"
  (s "@for" (c 1 [(fmta "for <key>, <value> in pairs(<iterable>) do
  <body>
end
" {:key (i 1 "key")
                           :value (i 2 "value")
                           :iterable (i 3 "iterable")
                           :body (i 4 "iterable")})
                  (fmta "for <index>, <value> in ipairs(<iterable>) do
  <body>
end
" {:index (i 1 "index")
                           :value (i 2 "value")
                           :iterable (i 3 "iterable")
                           :body (i 4 "body")})])))

(fn class-snippet [s c i fmta]
  "Defines the snippet for classes"
  (s "@class" (c 1 [(fmta "local <name> = {}
<name>.__index = <name>
function <name>:new(<params>)
  return setmetatable({<params>}, self)
end

setmetatable(<name>, { __call = <name>.new})
" {:name (i 1 "Class") :params (i 2 "params")}
                          {:repeat_duplicates true})
                    (fmta "local <name> = {}
<name>.__index = <name>
setmetatable(<name>, {__index = <super>})
function <name>:new(<params>)
  local obj = <super>:new(<params>)
  setmetatable(obj, <name>)
  return obj
end
"
                          {:name (i 1 "Class")
                           :super (i 2 "Super")
                           :params (i 3 "params")}
                          {:repeat_duplicates true})])))

(fn setup [ls fm]
  "Setup lua snippets"
  (let [fmta (. fm :fmta)
        s (. ls :snippet)
        sn (. ls :snippet_node)
        i (. ls :insert_node)
        t (. ls :text_node)
        c (. ls :choice_node)
        f (. ls :function_node)
        d (. ls :dynamic_node)
        nl (λ [] (t ["" ""]))]
    (ls.add_snippets "lua"
                     [(var-snippet s c i fmta)
                      (import-snippet s i fmta)
                      (fn-snippet s c i fmta)
                      (for-snippet s c i fmta)
                      (class-snippet s c i fmta)])))

(let [ls (F.safe-require "luasnip")
      fm (F.safe-require "luasnip.extras.fmt")]
  (if (and (not= ls nil) (not= fm nil))
      (setup ls fm)))
