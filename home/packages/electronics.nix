{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    pulseview
  ];
}
