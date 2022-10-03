{
  description = "ACC Stats Service";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs";
    pre-commit-hooks.url = "github:tfc/pre-commit-hooks.nix?ref=purs-tidy";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    purs-nix.url = "github:ursi/purs-nix";
  };

  outputs =
    { self
    , flake-parts
    , nixpkgs
    , pre-commit-hooks
    , purs-nix
    }:
    flake-parts.lib.mkFlake { inherit self; } {
      systems = [ "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs', system, ... }:
        let
          pkgs = import nixpkgs { inherit system; };
          purs-nix = self.inputs.purs-nix { inherit system; };

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

            dir = ./.;

          };
        in
        {
          apps.default = {
            type = "app";
            program = "${config.packages.default}/bin/ps-recharts";
          };

          packages = with ps.modules.Main; {
            default = app { name = "ps-recharts"; };
            bundle = bundle { };
            output = output { };
          };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs
              (ps.command { })
              purs-nix.esbuild
              purs-nix.purescript
              simple-http-server
              nodePackages.purs-tidy
            ];

            shellHook = ''
              ${config.checks.pre-commit-check.shellHook}

              trap "pkill -f simple-http-server" EXIT
              # runs this in a subshell for the trap to kill
              (purs-nix compile
              ln -sf $PWD/bundle.js $PWD/web/bundle.js
              simple-http-server -p 8000 -s --nocache -i -- $PWD/web 0<&- &
              )
              alias watch="find $PWD/src | entr -s 'echo bundling; purs-nix bundle'"
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
