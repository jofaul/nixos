{

  description = "My first flake!";

  inputs = {
  
    ### Essentials

    # Give me the unstable packages!!
    # https://github.com/NixOS/nixpkgs
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?ref=nixos-unstable&shallow=1";


    # A collection of NixOS modules covering hardware quirks.
    # https://github.com/NixOS/nixos-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Manage a user environment using Nix
    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pure Nix flake utility functions
    # https://github.com/numtide/flake-utils
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    ### Tools for managing NixOS

    # lollypops deployment tool
    # https://github.com/pinpox/lollypops
    lollypops = {
      url = "github:pinpox/lollypops";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    ### Packages outside of nixpkgs

    # MayNiklas - used for build_outputs
    mayniklas = {
      url = "github:MayNiklas/nixos";
      inputs = {
        # disko.follows = "disko";
        home-manager.follows = "home-manager";
        nixos-hardware.follows = "nixos-hardware";
        nixpkgs.follows = "nixpkgs";
      };
    };

    authentik-nix = {
      url = "github:nix-community/authentik-nix";

      ## optional overrides. Note that using a different version of nixpkgs can cause issues, especially with python dependencies
      # inputs.nixpkgs.follows = "nixpkgs"
      # inputs.flake-parts.follows = "flake-parts"
    };

  };

  outputs =
    { self, ... }@inputs:
    with inputs;
    let
      supportedSystems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = [ ];
        }
      );
    in
    {

      formatter = forAllSystems (system: nixpkgsFor.${system}.nixfmt-rfc-style); # TODO: change to "nixfmt" once it is replaced

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {

          build_outputs = pkgs.callPackage mayniklas.packages.${system}.build_outputs.override {
            inherit self;
            output_path = "~/.keep-nix-outputs-jofaul";
          };

        }
      );

      # Output all modules in ./modules to flake. Modules should be in
      # individual subdirectories and contain a default.nix file
      nixosModules = builtins.listToAttrs (
        map (name: {
          inherit name;
          value = import (./modules + "/${name}");
        }) (builtins.attrNames (builtins.readDir ./modules))
      );

      # Each subdirectory in ./machines is a host. Add them all to
      # nixosConfiguratons. Host configurations need a file called
      # configuration.nix that will be read first
      nixosConfigurations = builtins.listToAttrs (
        map (x: {
          name = x;
          value = nixpkgs.lib.nixosSystem {

            # Make inputs and the flake itself accessible as module parameters.
            # Technically, adding the inputs is redundant as they can be also
            # accessed with flake-self.inputs.X, but adding them individually
            # allows to only pass what is needed to each module.
            specialArgs = {
              flake-self = self;
            } // inputs;

            modules = [
              (import "${./.}/machines/${x}/configuration.nix" { inherit self; })
              { imports = builtins.attrValues self.nixosModules; }
            ];

          };
        }) (builtins.attrNames (builtins.readDir ./machines))
      );

      homeConfigurations = {
        desktop =
          {
            pkgs,
            lib,
            username,
            ...
          }:
          {
            imports = [
              ./home-manager/profiles/common.nix
              ./home-manager/profiles/desktop.nix
            ] ++ (builtins.attrValues self.homeManagerModules);
          };
        server =
          {
            pkgs,
            lib,
            username,
            ...
          }:
          {
            imports = [
              ./home-manager/profiles/common.nix
              ./home-manager/profiles/server.nix
            ] ++ (builtins.attrValues self.homeManagerModules);
          };
      };

      homeManagerModules = builtins.listToAttrs (
        map (name: {
          inherit name;
          value = import (./home-manager/modules + "/${name}");
        }) (builtins.attrNames (builtins.readDir ./home-manager/modules))
      );

    };
}
