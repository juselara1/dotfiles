(import-macros {: set!} :hibiscus.vim)
(set! shiftwidth 4)
(set! tabstop 4)

(vim.lsp.enable [:jedi_language_server])
(require "snippets.python")
