{ config, lib, pkgs, ... }:

{
  systemd.user.services.bluetooth-prevent-wake = {
    enable = true;
    unitConfig = {
      Description = "disable bluetooth for systemd sleep/suspend targets";
      StopWhenUnneeded = "yes";
    };
    before = [ "sleep.target" "suspend.target" "hybrid-sleep.target" "suspend-then-hibernate.target" ];
    upheldBy = [ "sleep.target" "suspend.target" "hybrid-sleep.target" "suspend-then-hibernate.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.util-linux}/bin/rfkill block bluetooth";
      ExecStop = "${pkgs.util-linux}/bin/rfkill unblock bluetooth";
    };
    wantedBy = [ "sleep.target" "suspend.target" "hybrid-sleep.target" "suspend-then-hibernate.target" ];
  };
}
