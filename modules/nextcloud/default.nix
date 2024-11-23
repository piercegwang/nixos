{ config, lib, pkgs, ... }:

{
  # environment.etc."nextcloud-admin-pass".text = "initialpassword"; # use to make initial account
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "10.147.18.1";
    database.createLocally = true;
    settings = {
      trusted_domains = [ "10.147.18.1" ];
      log_type = "file";
      loglevel = 1;
    };
    config = {
      dbtype = "pgsql";
      adminuser = "root";
      adminpassFile = "/etc/nextcloud-root-pass";
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

