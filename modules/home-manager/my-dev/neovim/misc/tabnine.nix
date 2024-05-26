{
  config,
  lib,
  pkgs,
  ...
}: let
  enable = config.my-dev.tools.tabnine.enable;
  # Right now this requires you to define manual version.
  tabnine-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "tabnine";
    version = "master";
    src = fetchGit {
      url = "https://github.com/codota/tabnine-nvim.git";
      name = "tabnine-nvim";
      rev = "ccca333171125f9ebef619d6530815931988b2df";
      submodules = true;
    };
    buildInputs = [pkgs.unzip pkgs.curl];
    buildPhase = ''
      mkdir -p "binaries/${pkgs.tabnine.version}"
      ln -s "${pkgs.tabnine}/bin" "binaries/${pkgs.tabnine.version}/x86_64-unknown-linux-musl"
    '';
  };
in {
  config = lib.mkIf enable {
    home.packages = [pkgs.tabnine];
    programs.neovim.plugins = [tabnine-nvim];

    xdg.configFile."nvim/after/plugin/tabnine.lua".text = ''
      require('tabnine').setup({
        disable_auto_comment=true,
        accept_keymap="<c-q>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 500,
        suggestion_color = {gui = "#808080", cterm = 244},
        exclude_filetypes = {"TelescopePrompt", "NvimTree"},
        log_file_path = nil, -- absolute path to Tabnine log file
      })
    '';
  };
}
