{
  config,
  lib,
  pkgs,
  ...
}: let
  tabnine-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "tabnine";
    version = "master";
    src = fetchGit {
      url = "https://github.com/codota/tabnine-nvim.git";
      name = "tabnine-nvim";
      rev = "3ae92fc4fa8b82bfc70fba9d0741fdb5842e74c1";
      submodules = true;
    };
    buildInputs = [pkgs.unzip pkgs.curl];
    buildPhase = ''
      mkdir -p "binaries/${pkgs.tabnine.version}"
      ln -s "${pkgs.tabnine}/bin" "binaries/${pkgs.tabnine.version}/x86_64-unknown-linux-musl"
    '';
  };
in {
  config = lib.mkIf config.my-dev.ai {
    home.packages = [pkgs.tabnine];
    programs.neovim.plugins = [tabnine-nvim];
    xdg.configFile."nvim/after/plugin/tabnine.lua".source = ./tabnine.lua;
  };
}
