(import-macros {: set!} :hibiscus.vim)
(set! shiftwidth 2)
(set! tabstop 2)

(vim.lsp.enable [:luals])
(require "snippets.lua")
