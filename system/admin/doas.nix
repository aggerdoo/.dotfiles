{ userSettings, pkgs, ... }:

{
  security.sudo.enable = false;

  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "${userSettings.username}" ];
      noPass = true;
      keepEnv = true;
    }];
  };
}
