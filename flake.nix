{
  description = "ACC Stats Service";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs";
    npmlock2nix-src = {
      flake = false;
      url = "github:nix-community/npmlock2nix";
    };
    pre-commit-hooks.url = "github:tfc/pre-commit-hooks.nix?ref=purs-tidy";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    purs-nix.url = "github:ursi/purs-nix";
  };

  outputs =
    { self
    , flake-parts
    , nixpkgs
    , npmlock2nix-src
    , pre-commit-hooks
    , purs-nix
    }:
    flake-parts.lib.mkFlake { inherit self; } {
      systems = [ "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs', system, ... }:
        let
          pkgs = import nixpkgs { inherit system; };
          purs-nix = self.inputs.purs-nix { inherit system; };
          npmlock2nix = import npmlock2nix-src { inherit pkgs; };

          nodeModules =
            let
              nm = npmlock2nix.node_modules { src = ./.; };
            in
            "${nm}/node_modules";

          ps = purs-nix.purs {
            inherit (pkgs) nodejs purescript;
            dependencies = with purs-nix.ps-pkgs; [
              affjax
              affjax-web
              affjax-node
              console
              effect
              prelude
              simple-json
              react
              react-basic-hooks
              react-basic-dom
            ];

            dir = pkgs.lib.sourceByRegex ./. [
              "^src.*"
              "^package.json$"
              "^package-lock.json$"
            ];

            foreign."React.Basic".node_modules = nodeModules;
            foreign."React.Basic.DOM".node_modules = nodeModules;
            foreign."React.Basic.DOM.Client".node_modules = nodeModules;
            foreign."React.Basic.DOM.Internal".node_modules = nodeModules;
            foreign."Foreign.Recharts".node_modules = nodeModules;
          };
        in
        {
          apps = {
            default = config.apps.serve-ui;
            serve-ui = {
              type = "app";
              program =
                let
                  drv = pkgs.writeShellApplication {
                    name = "serve-purescript-recharts";
                    runtimeInputs = [ pkgs.simple-http-server ];
                    text = "simple-http-server --nocache -i -- ${config.packages.dist}";
                  };
                in
                "${drv}/bin/serve-purescript-recharts";
            };
          };

          packages = {
            default = config.packages.dist;
            bundle = ps.modules.Main.bundle { };
            dist = pkgs.runCommand "purescript-recharts-dist" { } ''
              mkdir -p $out
              cp -r ${./web}/* $out/
              cat ${config.packages.bundle} > $out/main.js
            '';
          };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs
              (ps.command { })
              purs-nix.esbuild
              purs-nix.purescript
              simple-http-server
            ];

            shellHook = ''
              ${config.checks.pre-commit-check.shellHook}
            '';
          };

          checks = {
            pre-commit-check = pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                nixpkgs-fmt.enable = true;
                purs-tidy.enable = true;
                statix.enable = true;
              };
            };
          };
        };
    };
}
