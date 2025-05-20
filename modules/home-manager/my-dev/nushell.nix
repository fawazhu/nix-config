{
  config,
  lib,
  ...
}: let
  flavour = config.my-dev.catppuccinFlavour;
  captializedFlavour = (lib.toUpper (builtins.substring 0 1 flavour)) + (builtins.substring 1 (-1) flavour);
in {
  programs.nushell = {
    enable = true;
    configFile.text = ''
      $env.config = {
        show_banner: false,
        table: {
          mode: rounded
        }
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
      alias vimdiff = nvim -d
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
      EDITOR = "nvim";
      LESS = "\"-R --use-color -Dd+r$Du+b$\"";
      MANPAGER = "\"less -R --use-color -Dd+r -Du+b\"";
      MANROFFOPT = "\"-P -c\"";
      FZF_DEFAULT_OPTS = "\"--layout=reverse --preview=\\\"bat -n --color=always {} | complete | if ($in.exit_code == 0) { echo $in.stdout } else { eza -T --color=always --icons {} }\\\" --preview-window='right:60%'\"";
    };
  };
}
