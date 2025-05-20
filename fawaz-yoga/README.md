# Install

Set up 16GB ram disk mounted to /nix

Disable selinux

Install nix

```sh
sudo -i nix --extra-experimental-features 'nix-command' --extra-experimental-features 'flakes' run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake 'github:fawazhu/nix-config#fawaz-yoga' --disk main /dev/nvme0n1
```
