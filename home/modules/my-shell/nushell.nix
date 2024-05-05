{
  config,
  lib,
  ...
}: let
  flavour = config.my-shell.catppuccin-flavour;
in {
  config = lib.mkIf config.my-shell.enable {
    programs.nushell = {
      enable = true;
      configFile.text = ''
        $env.config = {
          show_banner: false,
          table: {
            mode: rounded
          }
          keybindings: [
            {
              name: history_search
              modifier: control
              keycode: char_r
              mode: [emacs vi_insert vi_normal]
              event: [
                { edit: Clear }
                { edit: InsertString value: "nu -c $\"(history | where command =~ '^nu -c \\$\\\"\\(history \\|' == false | move command --after index | reverse | to tsv -n | fzf --preview=\"\" | split row \"\\t\" | to text | tail -n 1)\"" }
                { send: Enter }
              ]
            }
          ]
        }
        def --env proj [] {
          fd -u -t d --base-directory ~/git .git |
          split row "\n" |
          split column "/" |
          drop column 2 |
          each { values | str join '/' } |
          to text |
          fzf-tmux |
          cd $'($env.HOME)/git/($in)'
        }
        alias vimdiff = ${config.my-shell.editor} -d
        alias fzf = fzf-tmux
        alias eza = eza --color=always --icons
        alias tree = eza --tree
        use ~/.cache/starship/init.nu
      '';
      envFile.text = ''
        mkdir ~/.cache/starship
        starship init nu | save -f ~/.cache/starship/init.nu
      '';
      environmentVariables = {
        EDITOR = config.my-shell.editor;
        TERM = config.my-shell.terminal;
        BAT_THEME = "\"Catppuccin ${(lib.toUpper (builtins.substring 0 1 flavour)) + (builtins.substring 1 (-1) flavour)}\"";
        LESS = "\"-R --use-color -Dd+r$Du+b$\"";
        MANPAGER = "\"less -R --use-color -Dd+r -Du+b\"";
        MANROFFOPT = "\"-P -c\"";
        FZF_DEFAULT_OPTS = "\"--layout=reverse --preview=\\\"bat -n --color=always {} | complete | if ($in.exit_code == 0) { echo $in.stdout } else { eza -T --color=always --icons {} }\\\" --preview-window='right:60%'\"";
      };
    };
  };
}
