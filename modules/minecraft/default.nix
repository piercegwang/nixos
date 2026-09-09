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
      OmarWrongChat = "245f22a6-41ee-4c61-a318-0e5b42c038d2";
    };
    serverProperties = {
      server-port = 25565;
      difficulty = 3;
      gamemode = 1;
      max-players = 2;
      motd = "DMA Memory Palace!";
      white-list = true;
      allow-cheats = true;
    };
    jvmOpts = "-Xms2048M -Xmx2048M"; 
    package = pkgs.minecraftServers.vanilla-26-2;
  };
}
