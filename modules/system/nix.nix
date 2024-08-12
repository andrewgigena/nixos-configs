{ pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = ["root" "@wheel"];
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
    libraries = with pkgs; [
      stdenv.cc.cc
      fuse3
      openssl
      curl
      libxkbcommon
      libudev-zero
      libappindicator-gtk3
      libdrm
      libglvnd
      libusb1
      libuuid
      libxml2
      libinput
      mesa
      fontconfig
      freetype
      sqlite
    ];
  };
}
