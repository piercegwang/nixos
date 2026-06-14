{ config, lib, pkgs, ... }:

{
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true; # Opens the port the server is running on (by default 25565 but in this case 43000)
    declarative = true;
    whitelist = {
      # This is a mapping of Minecraft usernames to to the players' UUIDs
      tesrodome = "3a490a87-265b-4f97-897f-619462554aa6";
      flolokkai26 = "7be27151-7879-4442-a987-f82713d4ee5e";
    };
    serverProperties = {
      server-port = 25565;
      difficulty = 3;
      gamemode = 1;
      max-players = 3;
      motd = "I'm singggging in the rain~";
      white-list = true;
      allow-cheats = true;
    };
    jvmOpts = "-Xms2048M -Xmx2048M"; 
    package = pkgs.minecraftServers.vanilla-26-1;
  };
}
