{ pkgs, ... }: {
  home.packages = with pkgs; [
    python3
    go
    lua
    lua54Packages.luarocks
    nodejs_21
    cargo
    rustc
  ];
}
