{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, vars, ... }:

{
  pn50 = import ./pn50 {
    inherit lib inputs nixpkgs nixpkgs-unstable home-manager vars;
  };
}
