(require :options)

(var plugins-cfg {})
(let [plugins (vim.fn.readdir (.. (vim.fn.stdpath :data) "/tangerine/plugins"))]
  (each [_ value (ipairs plugins)]
    (table.insert plugins-cfg
                  (require (string.format "plugins.%s" (value:gsub "%..*" ""))))))

(let [m (require :lazy)]
  (m.setup [plugins-cfg]))
