{
  inputs,
  vars,
  ...
}: {
  # Personal: NixOS NUC
  pn50 = import ./pn50 {
    inherit inputs vars;
  };

  # Personal: OSX laptop
  m1pro = import ./m1pro {
    inherit inputs vars;
  };

  # Work: OSX laptop
  flawpro = import ./flawpro {
    inherit inputs vars;
  };
}
