(fn in [tbl val]
  "Validates if value is in table"
  (var in-table? false)
  (each [_ elem (ipairs tbl)]
    (if (= val elem)
        (set in-table? true)))
  in-table?)

(fn safe-require [module]
  "Safely require a module"
  (let [(ok? value) (pcall require module)]
    (if ok?
        value
        (vim.notify (string.format "Unable to load module '%s'" module)
                    vim.log.levels.WARN))))

(fn min [a b]
  "Computes the minimum between two numbers"
  (if (<= a b) a b))

(fn zip [a b ?key1 ?key2]
  "Combines two tables element-to-element and optionally adds a key"
  (local result {})
  (let [len (min (length a) (length b))
        key1 (if (= ?key1 nil) 1 ?key1)
        key2 (if (= ?key2 nil) 2 ?key2)]
    (for [i 1 len]
      (table.insert result {key1 (. a i) key2 (. b i)})))
  result)

(fn strjoin [strings ?sep]
  "Joins multiple strings using a separator, defaults to space"
  (var result {})
  (let [sep (if (= ?sep nil) " " ?sep)
        len (length strings)]
    (for [i 1 (- len 1)]
      (table.insert result (. strings i))
      (table.insert result sep))
    (table.insert result (. strings len)))
  (accumulate [join "" _ val (ipairs result)]
    (.. join val)))

{:in in :safe-require safe-require :zip zip :strjoin strjoin}
