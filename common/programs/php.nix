{ pkgs, ... }:

{
  programs.php = {
    enable = true;
    package = let 
      basePHP = pkgs.php81.buildEnv {
        extensions = ({ enabled, all }: enabled ++ [ 
          all.ssh2 
          all.tidy 
          all.dom 
          all.rdkafka 
          all.xdebug 
        ]);
      };
    in basePHP.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        substituteInPlace $out/etc/php.ini \
          --replace ";memory_limit = 128M" "memory_limit = 8G" \
          --replace ";max_execution_time = 30" "max_execution_time = 600"
      '';
    });

    iniOptions = {
      xdebug = {
        mode = "debug";
        profiler_output_name = "cachegrind.out.%p";
        output_dir = "/Users/ssanchez/work/ouiteamserver_interne";
        start_with_request = "trigger";
        discover_client_host = 1;
        client_host = "127.0.0.1";
        log = "/tmp/xdebug.log";
        log_level = 3;
      };
    };
  };
}
