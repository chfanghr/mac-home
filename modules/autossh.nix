{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.autossh;
in {
  options.services.autossh = {
    enable = mkEnableOption "autonssh daemons";

    sessions = mkOption {
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "socks-peer";
            description = mdDoc "Name of the local AutoSSH session";
          };
          monitoringPort = mkOption {
            type = types.int;
            default = 0;
            example = 20000;
            description = mdDoc ''
              Port to be used by AutoSSH for peer monitoring. Note, that
              AutoSSH also uses mport+1. Value of 0 disables the keep-alive
              style monitoring
            '';
          };
          extraArguments = mkOption {
            type = types.listOf types.str;
            example = ["-N" "-D4343" "bill@socks.example.net"];
            description = mdDoc ''
              Arguments to be passed to AutoSSH and retransmitted to SSH
              process. Some meaningful options include -N (don't run remote
              command), -D (open SOCKS proxy on local port), -R (forward
              remote port), -L (forward local port), -v (Enable debug). Check
              ssh manual for the complete list.
            '';
          };
        };
      });

      default = [];

      description = mdDoc ''
        List of AutoSSH sessions to start as systemd services. Each service is
        named 'autossh-{session.name}'.
      '';

      example = [
        {
          name = "socks-peer";
          user = "bill";
          monitoringPort = 20000;
          extraArguments = ["-N" "-D4343" "bill@socks.example.net"];
        }
      ];
    };
  };

  config = mkIf (cfg.enable && cfg.sessions != []) {
    launchd.agents = let
      mkAgent = session: let
        monitoringPort =
          if session ? monitoringPort
          then session.monitoringPort
          else 0;

        agentName = "autossh-${session.name}";
        agent = {
          enable = true;
          config = {
            EnvironmentVariables = {
              AUTOSSH_GATETIME = "0";
              AUTOSSH_POLL = "30";
            };

            KeepAlive = true;

            ProgramArguments =
              [
                "${pkgs.autossh}/bin/autossh"
                "-M"
                (toString monitoringPort)
              ]
              ++ session.extraArguments;

            RunAtLoad = true;
          };
        };
      in
        attrsets.nameValuePair agentName agent;
    in
      attrsets.listToAttrs (map mkAgent cfg.sessions);

    home.packages = [pkgs.autossh];
  };
}
