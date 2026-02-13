{ config, pkgs, ... }:

let
  # --- CONFIGURATION VARIABLES ---
  # CHANGE THESE
  domain = "tiqur.dev"; # Your main domain
  matrixSubdomain = "matrix"; # The subdomain for the server (e.g. matrix.yourdomain.com)
  tunnelId = "5f910e60-cc8e-4b86-995b-f807ce6f6466"; # Your Cloudflare Tunnel UUID
  tunnelCreds = "/var/lib/cloudflared/${tunnelId}.json"; # Path to your credentials file

  # Secrets (You must create these files manually with proper permissions!)
  # livekitKeyFile = "/var/lib/secrets/livekit_key";
  # turnSecretFile = "/var/lib/secrets/turn_secret";
  # borgPassFile = "/var/lib/secrets/borg_pass";

in
{

  # ==========================================
  # 1. CORE: Matrix Server (Tuwunel)
  # ==========================================
  services.matrix-tuwunel = {
    enable = true;
    settings = {
      global = {
        server_name = domain; # This makes your ID @user:yourdomain.com

        # Listen only locally. The Tunnel handles the world.
        address = [ "127.0.0.1" ];
        port = [ 8008 ];

        # Database: RocksDB is faster/lighter than SQLite/Postgres for this.
        database_backend = "rocksdb";

        allow_federation = true;

        # SETUP MODE: Set to 'true' to register your admin account.
        # IMMEDIATE ACTION: Set to 'false' after you create your account.
        allow_registration = false;
        #yes_i_am_very_very_sure_i_want_an_open_registration_server_prone_to_abuse = false;

        # File size limit (100MB). Discord free tier is 25MB.
        max_request_size = 100000000;

        # Helper for handling the proxy headers correctly
        trusted_proxies = [ "127.0.0.1" ];
      };

      features = {
        # Critical for modern mobile apps (Element X)
        sliding_sync = true;
      };
    };
  };

  # ==========================================
  # 2. CORE: The Shield (Cloudflare Tunnel)
  # ==========================================
  services.cloudflared = {
    enable = true;
    tunnels = {
      # The name of the attribute IS the Tunnel ID.
      "5f910e60-cc8e-4b86-995b-f807ce6f6466" = {
        credentialsFile = tunnelCreds; # This should point to your .json file
        ingress = {
          "${matrixSubdomain}.${domain}" = "http://localhost:8008";
        };
        default = "http_status:404";
      };
    };
  };

  # ==========================================
  # 3. EXTRAS (Commented Out for Testing)
  # ==========================================

  # --- BACKUPS (BORG) ---
  # services.borgbackup.jobs."matrix-backup" = {
  #   paths = [ "/var/lib/matrix-tuwunel" ];
  #   encryption = {
  #     mode = "repokey-blake2";
  #     passCommand = "cat ${borgPassFile}";
  #   };
  #   repo = "ssh://user@your-backup-server/./matrix-repo";
  #   compression = "auto,zstd";
  #   startAt = "daily";
  #   prune.keep = {
  #     daily = 7;
  #     weekly = 4;
  #     monthly = 6;
  #   };
  # };

  # --- VOICE: LiveKit (The "Discord" Voice Channels) ---
  # services.livekit = {
  #   enable = true;
  #   keys = {
  #     # You get these from the LiveKit dashboard or generate them locally
  #     api_key = "devkey";
  #     api_secret = "devsecret"; # Replace with file reference for security
  #   };
  #   settings.port = 7880;
  # };

  # --- VOICE: Coturn (The Firewall Puncher for 1:1 Calls) ---
  # services.coturn = {
  #   enable = true;
  #   use-auth-secret = true;
  #   static-auth-secret-file = turnSecretFile;
  #   realm = "turn.${domain}";
  #   # You need to open UDP ports for this to work, which defeats the
  #   # "Tunnel Only" setup unless you route this specifically.
  #   # listening-port = 3478;
  # };

  # --- FIREWALL ---
  # Since you are using Cloudflared, you technically don't need to open
  # incoming ports (80/443), but if you use Coturn later, you will need to.
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ 80 443 ];
  # networking.firewall.allowedUDPPorts = [ 3478 ]; # For Coturn later
}
