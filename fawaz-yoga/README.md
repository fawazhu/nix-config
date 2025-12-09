# Install

Set up 16GB tmpfs mounted to /nix

Disable selinux

Install nix

```sh
sudo -i
mkdir /nix
mount -t tmpfs tmpfs /nix
# Do nix multi-user install instructions
exit
sudo -i
nix-channel --add https://nixos.org/channels/nixos-unstable nixpkgs
nix-env -f '<nixpkgs>' -iA nixos-install-tools
cryptsetup open /dev/nvme0n1p2 crypt-root
# Mount subvols and esp
nixos-install --root /mnt --flake 'github:fawazhu/nix-config#fawaz-yoga'
```
