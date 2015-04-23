{ config, pkgs, ... }:

{
  services.mpd = {
    enable = true;
    extraConfig = ''
    audio_output {
       type		"pulse"
       name		"Local Music Player Daemon"
       server	"127.0.0.1"
    }
    audio_output {
       type             "httpd"
       name             "MPD HTTP Stream"
       encoder          "vorbis"
       port             "8000"
      #quality          "0.5"
       bitrate          "128"
       format           "44100:16:1"
    }
    '';
  };
}
