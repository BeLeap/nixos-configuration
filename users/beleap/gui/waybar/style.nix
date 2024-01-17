let
  nord = import ../../../../const/nord.nix;
in
''
  * {
    border: none;
    border-radius: 0;
    font-family: Caskaydia Cove Nerd Font, NanumGothicCoding;
    font-size: 14px;
    margin: 0.5px;
    padding: 0.5px;
    background-color: transparent;
    transition: none;
  }

  .modules-left {
    padding: 0 8px;
    border-radius: 0 0 10px 0;
    background-color: ${nord.nord3};
    color: ${nord.nord4};
  }

  .modules-right {
    padding: 0 8px;
    border-radius: 0 0 0 10px;
    background-color: ${nord.nord3};
    color: ${nord.nord4};
  }

  .modules-center {
    padding: 0 8px;
    border-radius: 0 0 10px 10px;
    background-color: ${nord.nord4};
    color: ${nord.nord0};
  }

  #window {
    margin: 8px 0;
    font-weight: bold;
  }

  #workspaces {
    margin: 4px 0;
    border-radius: 26px;
  }

  #workspaces button {
    padding: 0 8px;
    color: ${nord.nord4};
  }

  #workspaces button.focused {
    color: ${nord.nord6};
  }

  #workspaces button:hover {
    box-shadow: none;
    text-shadow: none;
    background: none;
    color: ${nord.nord5};
  }

  #workspaces button.urgent {
    color: ${nord.nord11};
  }

  tooltip {
    color: ${nord.nord4};
    background-color: ${nord.nord0};
    border-color: ${nord.nord1};
    border-radius: 0 0 10px 10px;
  }

  #mpris,
  #backlight,
  #battery,
  #clock,
  #cpu,
  #custom-github,
  #custom-uair,
  #disk,
  #idle_inhibitor,
  #memory,
  #mode,
  #mpd,
  #network,
  #pulseaudio,
  #scratchpad,
  #temperature,
  #bluetooth,
  #tray,
  #wireplumber {
    margin: 4px;
    padding: 0 8px;
  }
''
