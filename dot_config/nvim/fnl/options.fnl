(import-macros {: set! : augroup! : map!} :hibiscus.vim)

;; Line numbers
(set! number)
(set! relativenumber)
(set! numberwidth 1)

;; visual
(set! termguicolors)
(set! showmatch)
(set! mouse "")
(set! laststatus 1)
(set! background :dark)

;; text
(set! encoding :utf-8)
(set! spelllang :en-es)
(vim.cmd.syntax :enable)

;; behavior
(set! updatetime 100)
(set! clipboard :unnamedplus)
(set! showmode false)
(set! showcmd false)
(set! ruler false)
(set! cmdheight 0)

;; keybindings
(set vim.g.mapleader " ")
(map! [n] "<leader>cs" ":noh<CR>" "[C]lear [S]earch.")
(map! [n] "<leader>sl" ":set list!"
      "[S]et [L]ist (toggle non-visible elements).")
(map! [n] "<leader>ss" ":set spell!" "[S]et [S]pell (toggle spellchecking).")
(map! [n] "<C-d>" "<C-d>zz" "Scrolldown.")
(map! [n] "<C-u>" "<C-u>zz" "Scrollup.")
(map! [n] "<leader>P" "\"+p" "[P]aste from system clipboard.")
(map! [n] "<leader>p" "\"0p" "[P]aste last yanked text.")
(map! [t] "<C-q>" "<Esc><C-\\><C-n>" "Normal mode from terminal mode")

;; autocommands
(augroup! :highlight-yank
          [[TextYankPost :desc "Highlights yanked region."]
           *
           #(vim.highlight.on_yank {:higroup :Visual :timeout 400})])

(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                             {:pattern ["*.fnl"]
                              :callback (λ [ev]
                                          (tset vim.bo ev.buf :syntax :fennel)
                                          (tset vim.bo ev.buf :filetype :fennel))})

(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                             {:pattern ["*.tf" "*.tfvars"]
                              :callback (λ [ev]
                                          (tset vim.bo ev.buf :syntax :terraform)
                                          (tset vim.bo ev.buf :filetype :terraform))})
