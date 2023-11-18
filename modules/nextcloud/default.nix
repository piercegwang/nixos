{ config, lib, pkgs, ... }:

{
  # environment.etc."nextcloud-admin-pass".text = "initialpassword"; # use to make initial account
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    hostName = "10.147.18.1";
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      # extraTrustedDomains = [ "10.147.18.1" ];
      # adminuser = "root";
      # adminpassFile = "/etc/nextcloud-admin-pass";
    };
    phpOptions = {
      upload_max_filesize = lib.mkForce "1G";
      post_max_size = lib.mkForce "1G";
    };
    # configureRedis = true;
    https = true;
  };

  security.acme.acceptTerms = true;
  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    # used `openssl req -new -x509 -days 3650 -nodes -out /etc/nc-selfsigned.pem -keyout /etc/nc-selfsigned.key`
    sslCertificate = "/etc/nc-selfsigned.pem";
    sslCertificateKey = "/etc/nc-selfsigned.key";
    forceSSL = true;
    # enableACME = true;
  };
}

