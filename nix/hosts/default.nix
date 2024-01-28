{ lib, inputs, vars, ... }:

{
  pn50 = import ./pn50 {
    inherit lib inputs vars;
  };
}
