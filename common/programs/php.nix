{ pkgs, phpVersion ? pkgs.php81, ... }:

with pkgs;
let 
  myphp = phpVersion.buildEnv {
    extensions = ({ enabled, all }: enabled ++ [ all.ssh2 all.tidy all.dom all.rdkafka all.xdebug ]);
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
in {
  home.packages = [];
}
