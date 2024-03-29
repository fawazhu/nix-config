{ pkgs, ... }: {
  home.packages = with pkgs; [
    python3
    go
    cargo
    lua
    lua54Packages.luarocks
    nodejs_21
  ];
}
