(local F (require :functions))

(local colors {:bg :#1F1F28
               :fg :#DCD7BA
               :yellow :#C0A36E
               :cyan :#6A9589
               :green :#76946A
               :orange :#FF8800
               :violet :#A9A1E1
               :magenta :#957FB8
               :blue :#7E9CD8
               :red :#C34043
               :white :#C8C093})

(local mode-color-mapping {:n colors.red
                           :no colors.red
                           :i colors.green
                           :v colors.blue
                           :V colors.blue
                           "\x16" colors.blue
                           :c colors.magenta
                           :cv colors.magenta
                           :ce colors.magenta
                           :s colors.orange
                           :S colors.orange
                           "\x13" colors.orange
                           :R colors.violet
                           :Rv colors.violet
                           :r colors.cyan
                           :rm colors.cyan
                           "r?" colors.cyan
                           :t colors.white})

(fn human-mode [mode]
  "Human readable vim mode"
  (if (F.in [:n :no] mode) "λ Normal "
      (F.in [:R :Rv] mode) "ω Replace"
      (F.in [:s :S "\x13"]) "Γ Select "
      (F.in [:c :cv :ce] mode) "π Command"
      (F.in [:r :rm "r?"]) "σ Prompt "
      (= :v mode) "β Visual "
      (= :V mode) "β VisualL"
      (= "\x16" mode) "β VisualB"
      (= :i mode) "α Insert "
      (= :t mode) "Φ Term   "
      mode))

(fn vline []
  "Adds a vline ascii char"
  {1 (λ [] "▊") :color {:fg colors.blue} :padding {:left 0 :right 0}})

(fn mode []
  "Displays the current vim mode"
  {1 (λ [] (human-mode (vim.fn.mode)))
   :color (λ []
            {:fg colors.bg :bg (. mode-color-mapping (vim.fn.mode)) :gui :bold})
   :padding {:right 1 :left 1}})

(fn filetype [icons]
  "Displays the filetype as an icon"
  {1 (λ []
       (let [icon (icons.get_icon (vim.fn.expand "%:t"))]
         (case icon
           nil ""
           value value)))
   :color {:fg colors.fg}})

(fn filename []
  "Displays the file name"
  {1 (λ []
       (vim.fn.fnamemodify (vim.api.nvim_buf_get_name 0) ":t"))
   :cond (λ []
           (not= (vim.fn.empty (vim.fn.expand "%:t")) 1))
   :color {:fg colors.fg}})

(fn modified-buffer []
  "Displays if the buffer has been edited"
  {1 (λ [] "●")
   :cond (λ []
           (not= (vim.fn.empty (vim.fn.expand "%:t")) 1))
   :color (λ []
            {:fg (if vim.bo.modified colors.red colors.green)})})

(fn progress []
  "Displays the lines as a progress percentage"
  {1 "progress" :color {:fg colors.fg} :padding {:left 1 :right 1}})

(fn location []
  "Displays the cursor location"
  {1 "location" :color {:fg colors.fg}})

(fn branch []
  "Displays the git branch"
  {1 "branch" :color {:fg colors.magenta}})

(fn search []
  "Displays the search count"
  {1 "searchcount" :padding {:left 1 :right 1} :color {:fg colors.yellow}})

(fn progress-bar []
  "Displays a progress bar"
  {1 (λ []
       (let [bar ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"]
             prop (/ (. (vim.api.nvim_win_get_cursor 0) 1)
                     (vim.api.nvim_buf_line_count 0))]
         (. bar (math.ceil (* prop (length bar))))))
   :color {:fg colors.fg}
   :padding {:left 1 :right 1}})

(fn recording-macro [m]
  "Displays when macros are being recorded"
  {1 (λ []
       (let [reg (vim.fn.reg_recording)]
         (string.format "Recording %s" reg)))
   :color {:fg colors.bg :bg colors.red :gui :bold}
   :cond (λ [] (not= (vim.fn.reg_recording) ""))})

(fn setup [m icons]
  "Setups the lualine statusline"
  (m.setup {:options {:component_separators ""
                      :section_separators ""
                      :theme {:normal {:c {:fg colors.fg :bg colors.bg}}
                              :inactive {:c {:fg colors.fg :bg colors.bg}}}}
            :sections {:lualine_a [(vline)]
                       :lualine_b []
                       :lualine_y {}
                       :lualine_z {}
                       :lualine_c [(mode)
                                   (branch)
                                   (filetype icons)
                                   (filename)
                                   (modified-buffer)
																	 (recording-macro)
																	 ]
                       :lualine_x [(search) (progress-bar) (progress) (vline)]}}))

{1 "nvim-lualine/lualine.nvim"
 :dependencies ["nvim-tree/nvim-web-devicons"]
 :config (λ []
           (let [m (require :lualine)
                 icons (require :nvim-web-devicons)]
             (setup m icons)))}
