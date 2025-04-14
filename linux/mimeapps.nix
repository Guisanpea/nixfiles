# MIME application associations for Linux (split from home.nix)
{
  enable = true;
  defaultApplications = {
    # Web
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/about" = [ "firefox.desktop" ];
    "x-scheme-handler/unknown" = [ "firefox.desktop" ];
    "text/html" = [ "firefox.desktop" ];
    "application/xhtml+xml" = [ "firefox.desktop" ];
    "application/rss+xml" = [ "firefox.desktop" ];
    "application/rdf+xml" = [ "firefox.desktop" ];
    "application/vnd.mozilla.xul+xml" = [ "firefox.desktop" ];
    "application/x-xpinstall" = [ "firefox.desktop" ];

    # PDF and similar
    "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    "application/x-pdf" = [ "org.pwmt.zathura.desktop" ];

    # Markdown
    "text/markdown" = [ "nvim.desktop" ];

    # Text/code files (VSCode as default editor for desktop use)
    "text/plain" = [ "code.desktop" ];
    "text/x-python" = [ "code.desktop" ];
    "text/x-shellscript" = [ "code.desktop" ];
    "text/x-csrc" = [ "code.desktop" ];
    "text/x-c++src" = [ "code.desktop" ];
    "application/json" = [ "code.desktop" ];
    "application/x-yaml" = [ "code.desktop" ];
    "application/x-shellscript" = [ "code.desktop" ];
    "application/x-desktop" = [ "code.desktop" ];
    "text/csv" = [ "code.desktop" ];

    # Images (imv preferred over feh)
    "image/png" = [ "imv.desktop" ];
    "image/jpeg" = [ "imv.desktop" ];
    "image/gif" = [ "imv.desktop" ];
    "image/bmp" = [ "imv.desktop" ];
    "image/svg+xml" = [ "feh.desktop" ];

    # Video (sane default: mpv)
    "video/mp4" = [ "mpv.desktop" ];
    "video/x-matroska" = [ "mpv.desktop" ];

    # Audio (sane default: mpv)
    "audio/mpeg" = [ "mpv.desktop" ];
    "audio/x-wav" = [ "mpv.desktop" ];

    # Other handlers
    "x-scheme-handler/notion" = [ "notion-app.desktop" ];
    "x-scheme-handler/jetbrains" = [ "jetbrains-toolbox.desktop" ];
    "x-scheme-handler/eclipse+command" = [ "_usr_lib_dbeaver_.desktop" ];
    "x-scheme-handler/msteams" = [ "teams.desktop" ];
    "x-scheme-handler/slack" = [ "slack.desktop" ];
    "hoppscotch" = [ "hoppscotch-handler.desktop" ];
    "application/x-bittorrent" = [ "org.qbittorrent.qBittorrent.desktop" ];
  };

  # Added Associations (if needed, can be extended)
  addedAssociations = {
    "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    "application/x-bittorrent" = [ "org.qbittorrent.qBittorrent.desktop" ];
    "text/markdown" = [ "nvim.desktop" ];
  };
}