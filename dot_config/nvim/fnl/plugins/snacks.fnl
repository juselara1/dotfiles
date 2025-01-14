(import-macros {: map!} :hibiscus.vim)

(fn bigfile-cfg []
  "Configuration for bigfile"
  {:enabled true})

(fn dashboard-cfg []
  "Configuration for dashboard"
  {:enabled true
   :preset {:pick nil
            :header "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⣿⣿⣿⣿⣄⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣴⣿⣿⣶⣄⠹⣿⣿⣿⡟⠁⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⡆⢹⣿⣿⣿⣷⡀⠀
⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⠀⢿⣿⣿⣿⡇⠀
⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⢸⣿⣿⠟⠁⠀
⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠹⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀
⠀⠀⠀⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⢿⣿⣿⣿⣿⡄⠀⠀⠀⠀
⠀⠀⢀⣿⣿⣿⣿⣿⡟⢀⣿⣿⣿⣿⣿⣿⡿⠟⢁⡄⠸⣿⣿⣿⣿⣷⠀⠀⠀⠀
⠀⠀⣼⣿⣿⣿⣿⠏⠀⣈⡙⠛⢛⠋⠉⠁⠀⣸⣿⣿⠀⢻⣿⣿⣿⣿⡆⠀⠀⠀
⠀⢠⣿⣿⣿⣿⣟⠀⠀⢿⣿⣿⣿⡄⠀⠀⢀⣿⣿⡟⠃⣸⣿⣿⣿⣿⡇⠀⠀⠀
⠀⠘⠛⠛⠛⠛⠛⠛⠀⠘⠛⠛⠛⠛⠓⠀⠛⠛⠛⠃⠘⠛⠛⠛⠛⠛⠃⠀⠀⠀"
            :keys [{:icon " "
                    :key :f
                    :desc "Find file"
                    :action ":Fnl (Snacks.dashboard.pick :files)"}
                   {:icon " " :key :n :desc "Blank file" :action ":ene"}
                   {:icon "󰒲 " :key :l :desc "Lazy" :action ":Lazy"}
                   {:icon " " :key :q :desc "Quit" :action ":qa"}]}})

(fn statuscolumn-cfg []
  "Configuration for statuscolumn"
  {:enabled true})

(fn explorer-cfg []
  "Configuration for snacks explorer"
  {:enabled true :replace_netrw true})

(fn indent-cfg []
  "Configuration for indent"
  {:enabled true :only_scope false})

(fn notifier-cfg []
  "Configuration for notifier"
  {:enabled true})

(fn picker-cfg []
  "Configuration for picker"
  {:enabled true})

(fn setup [m]
  "Setups the snacks plugin"
  (m.setup {:bigfile (bigfile-cfg)
            :dashboard (dashboard-cfg)
            :explorer (explorer-cfg)
            :indent (indent-cfg)
            :notifier (notifier-cfg)
            :picker (picker-cfg)
            :statuscolumn (statuscolumn-cfg)})
  (map! [n] "<leader>d" #(m.dashboard) "[D]ashboard")
  (map! [n] "<leader>e" #(m.explorer) "[E]xplorer")
  (map! [n] "<leader>bdt" #(m.bufdelete) "[B]uffer [D]elete [T]his")
  (map! [n] "<leader>bda" #(m.bufdelete.all) "[B]uffer [D]elete [A]ll")
  (map! [n] "<leader>bdo" #(m.bufdelete.other) "[B]uffer [D]elete [O]ther")
  (map! [n] "<leader>nh" #(m.notifier.show_history) "[N]otifier [H]istory")
  (map! [n] "<leader>fb" #(m.picker.buffers) "[F]ind [B]uffers")
  (map! [n] "<leader>fg" #(m.picker.grep) "[F]ind [G]rep")
  (map! [n] "<leader>fh" #(m.picker.help) "[F]ind [H]elp")
  (map! [n] "<leader>ff" #(m.picker.files) "[F]ind [F]iles")
  (map! [n] "<leader>fr" #(m.picker.registers) "[F]ind [R]egisters")
  (map! [n] "<leader>fc" #(m.picker.commands) "[F]ind [C]commands")
  (map! [n] "<leader>fm" #(m.picker.marks) "[F]ind [M]arks")
  (map! [n] "<leader>fi" #(m.picker.icons) "[F]ind [I]cons")
  (map! [n] "<leader>ft" #(m.picker.treesitter) "[F]ind [T]reesitter")
  (map! [n] "<leader>fgb" #(m.picker.git_branches) "[F]ind [G]it [B]ranch")
  (map! [n] "<leader>fgl" #(m.picker.git_log) "[F]ind [G]it [L]og")
  (map! [n] "<leader>fgs" #(m.picker.git_status) "[F]ind [G]it [S]tatus")
  (map! [n] "<leader>tt" #(m.terminal) "[T]erminal [T]oggle")
  (map! [n] "<leader>to" #(m.terminal.open) "[T]erminal [O]pen"))

{1 "folke/snacks.nvim"
 :lazy false
 :priority 1000
 :config (λ []
           (let [m (require :snacks)]
             (setup m)))}
