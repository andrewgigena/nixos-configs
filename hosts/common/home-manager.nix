{ inputs, outputs, ... }:

{
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
        extraSpecialArgs = { inherit inputs outputs; };
        users = {
            shadows = import ../../home-manager/shadows;
        };
    };

}
