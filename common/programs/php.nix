{ pkgs, ... }:

let
  myphp = pkgs.php74pkgs.php74.buildEnv {
    extensions = ({ enabled, all }:
      enabled
      ++ [
        all.imagick
        all.ssh2
        all.tidy
      ]
    );
    extraConfig = ''
      memory_limit = 8G
      max_execution_time = 600
      [xdebug]
      xdebug.mode = debug
      xdebug.profiler_output_name = cachegrind.out.%p
      xdebug.output_dir=/Users/ssanchez/work/ouiteamserver_interne
      xdebug.start_with_request = trigger
      xdebug.discover_client_host = 1
      xdebug.client_host=127.0.0.1
      xdebug.log=/tmp/xdebug.log
      xdebug.log_level=3
    '';
  };
in
{
  home.packages = [ pkgs.php84Packages.composer ];
}