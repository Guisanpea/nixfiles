{
  description = "System config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix doom emacs
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.inputs.emacs-overlay.follows = "emacs-overlay";
  };

  outputs = inputs@{ nixpkgs, home-manager, nix-doom-emacs, ... }:
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
            nix-doom-emacs.hmModule
            ./nixie/home.nix
          ];
        };
      };
    };
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
          { nixpkgs.overlays = [ inputs.emacs-overlay.overlay ]; }
        ];
      };
    };
  };
}
