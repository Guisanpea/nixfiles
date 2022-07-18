{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/22.05";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix emacs
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ inputs.emacs-overlay.overlay ];
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      nixie = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "nixie";
        homeDirectory = "/home/nixie";
        configuration = {
          imports = [
            ./nixie/home.nix
          ];
        };
      };
    };
    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system;
      modules = [
        ./system/configuration.nix
        { nixpkgs.overlays = [ inputs.emacs-overlay.overlay ]; }
      ];
    };
  };
}
