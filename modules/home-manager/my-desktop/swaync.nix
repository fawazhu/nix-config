{
  config,
  pkgs,
  ...
}: let
  flavour = config.my-desktop.catppuccinFlavour;
  base =
    if flavour == "latte"
    then "#eff1f5"
    else if flavour == "frappe"
    then "#303446"
    else if flavour == "macchiato"
    then "#24273a"
    else if flavour == "mocha"
    then "#1e1e2e"
    else "00000000";
  crust =
    if flavour == "latte"
    then "#dce0e8"
    else if flavour == "frappe"
    then "#232634"
    else if flavour == "macchiato"
    then "#11111b"
    else if flavour == "mocha"
    then "#181926"
    else "00000000";
  surface0 =
    if flavour == "latte"
    then "#ccd0da"
    else if flavour == "frappe"
    then "#414559"
    else if flavour == "macchiato"
    then "#363a4f"
    else if flavour == "mocha"
    then "#313244"
    else "00000000";
  surface1 =
    if flavour == "latte"
    then "#bcc0cc"
    else if flavour == "frappe"
    then "#51576d"
    else if flavour == "macchiato"
    then "#494d64"
    else if flavour == "mocha"
    then "#45475a"
    else "00000000";
  surface2 =
    if flavour == "latte"
    then "#acb0be"
    else if flavour == "frappe"
    then "#626880"
    else if flavour == "macchiato"
    then "#5b6078"
    else if flavour == "mocha"
    then "#585b70"
    else "00000000";
  overlay0 =
    if flavour == "latte"
    then "#9ca0b0"
    else if flavour == "frappe"
    then "#737994"
    else if flavour == "macchiato"
    then "#6e738d"
    else if flavour == "mocha"
    then "#6c7086"
    else "00000000";
  overlay1 =
    if flavour == "latte"
    then "#8c8fa1"
    else if flavour == "frappe"
    then "#838ba7"
    else if flavour == "macchiato"
    then "#8087a2"
    else if flavour == "mocha"
    then "#7f849c"
    else "00000000";
  text =
    if flavour == "latte"
    then "#4c4f69"
    else if flavour == "frappe"
    then "#c6d0f5"
    else if flavour == "macchiato"
    then "#cad3f5"
    else if flavour == "mocha"
    then "#cdd6f4"
    else "00000000";
  subtext0 =
    if flavour == "latte"
    then "#6c6f85"
    else if flavour == "frappe"
    then "#a5adce"
    else if flavour == "macchiato"
    then "#a5adcb"
    else if flavour == "mocha"
    then "#a6adc8"
    else "00000000";
  blue =
    if flavour == "latte"
    then "#1e66f5"
    else if flavour == "frappe"
    then "#8caaee"
    else if flavour == "macchiato"
    then "#8aadf4"
    else if flavour == "mocha"
    then "#89b4fa"
    else "00000000";
  maroon =
    if flavour == "latte"
    then "#e64553"
    else if flavour == "frappe"
    then "#ea999c"
    else if flavour == "macchiato"
    then "#ee99a0"
    else if flavour == "mocha"
    then "#eba0ac"
    else "00000000";
  red =
    if flavour == "latte"
    then "#d20f39"
    else if flavour == "frappe"
    then "#e78284"
    else if flavour == "macchiato"
    then "#ed8796"
    else if flavour == "mocha"
    then "#f38ba8"
    else "00000000";
  sapphire =
    if flavour == "latte"
    then "#209fb5"
    else if flavour == "frappe"
    then "#85c1dc"
    else if flavour == "macchiato"
    then "#7dc4e4"
    else if flavour == "mocha"
    then "#74c7ec"
    else "00000000";
  yellow =
    if flavour == "latte"
    then "#df8e1d"
    else if flavour == "frappe"
    then "#e5c890"
    else if flavour == "macchiato"
    then "#eed49f"
    else if flavour == "mocha"
    then "#f9e2af"
    else "00000000";
in {
  xdg.configFile."swaync/style.css".text = ''
    * {
      all: unset;
      font-size: 14px;
      font-family: "${config.my-desktop.fonts.mono.name}";
      transition: 200ms;
    }

    trough highlight {
      background: ${text};
    }

    scale trough {
      margin: 0rem 1rem;
      background-color: ${surface0};
      min-height: 8px;
      min-width: 70px;
    }

    slider {
      background-color: ${blue};
    }

    .floating-notifications.background .notification-row .notification-background {
      box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px ${surface0};
      border-radius: 12.6px;
      margin: 18px;
      background-color: ${surface0};
      color: ${text};
      padding: 0;
    }

    .floating-notifications.background .notification-row .notification-background .notification {
      padding: 7px;
      border-radius: 12.6px;
    }

    .floating-notifications.background .notification-row .notification-background .notification.critical {
      box-shadow: inset 0 0 7px 0 ${red};
    }

    .floating-notifications.background .notification-row .notification-background .notification .notification-content {
      margin: 7px;
    }

    .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
      color: ${text};
    }

    .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
      color: ${subtext0};
    }

    .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
      color: ${text};
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
      min-height: 3.4em;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
      border-radius: 7px;
      color: ${text};
      background-color: ${surface0};
      box-shadow: inset 0 0 0 1px ${surface1};
      margin: 7px;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
      box-shadow: inset 0 0 0 1px ${surface1};
      background-color: ${surface0};
      color: ${text};
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
      box-shadow: inset 0 0 0 1px ${surface1};
      background-color: ${sapphire};
      color: ${text};
    }

    .floating-notifications.background .notification-row .notification-background .close-button {
      margin: 7px;
      padding: 2px;
      border-radius: 6.3px;
      color: ${base};
      background-color: ${red};
    }

    .floating-notifications.background .notification-row .notification-background .close-button:hover {
      background-color: ${maroon};
      color: ${base};
    }

    .floating-notifications.background .notification-row .notification-background .close-button:active {
      background-color: ${red};
      color: ${base};
    }

    .control-center {
      box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px ${surface0};
      border-radius: 12.6px;
      margin: 18px;
      background-color: ${base};
      color: ${text};
      padding: 14px;
    }

    .control-center .widget-title > label {
      color: ${text};
      font-size: 1.3em;
    }

    .control-center .widget-title button {
      border-radius: 7px;
      color: ${text};
      background-color: ${surface0};
      box-shadow: inset 0 0 0 1px ${surface1};
      padding: 8px;
    }

    .control-center .widget-title button:hover {
      box-shadow: inset 0 0 0 1px ${surface1};
      background-color: ${surface2};
      color: ${text};
    }

    .control-center .widget-title button:active {
      box-shadow: inset 0 0 0 1px ${surface1};
      background-color: ${sapphire};
      color: ${base};
    }

    .control-center .notification-row .notification-background {
      border-radius: 7px;
      color: ${text};
      background-color: ${surface0};
      box-shadow: inset 0 0 0 1px ${surface1};
      margin-top: 14px;
    }

    .control-center .notification-row .notification-background .notification {
      padding: 7px;
      border-radius: 7px;
    }

    .control-center .notification-row .notification-background .notification.critical {
      box-shadow: inset 0 0 7px 0 ${red};
    }

    .control-center .notification-row .notification-background .notification .notification-content {
      margin: 7px;
    }

    .control-center .notification-row .notification-background .notification .notification-content .summary {
      color: ${text};
    }

    .control-center .notification-row .notification-background .notification .notification-content .time {
      color: ${subtext0};
    }

    .control-center .notification-row .notification-background .notification .notification-content .body {
      color: ${text};
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * {
      min-height: 3.4em;
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
      border-radius: 7px;
      color: ${text};
      background-color: ${crust};
      box-shadow: inset 0 0 0 1px ${surface1};
      margin: 7px;
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
      box-shadow: inset 0 0 0 1px ${surface1};
      background-color: ${surface0};
      color: ${text};
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
      box-shadow: inset 0 0 0 1px ${surface1};
      background-color: ${sapphire};
      color: ${text};
    }

    .control-center .notification-row .notification-background .close-button {
      margin: 7px;
      padding: 2px;
      border-radius: 6.3px;
      color: ${base};
      background-color: ${maroon};
    }

    .close-button {
      border-radius: 6.3px;
    }

    .control-center .notification-row .notification-background .close-button:hover {
      background-color: ${red};
      color: ${base};
    }

    .control-center .notification-row .notification-background .close-button:active {
      background-color: ${red};
      color: ${base};
    }

    .control-center .notification-row .notification-background:hover {
      box-shadow: inset 0 0 0 1px ${surface1};
      background-color: ${overlay1};
      color: ${text};
    }

    .control-center .notification-row .notification-background:active {
      box-shadow: inset 0 0 0 1px ${surface1};
      background-color: ${sapphire};
      color: ${text};
    }

    .notification.critical progress {
      background-color: ${red};
    }

    .notification.low progress,
    .notification.normal progress {
      background-color: ${blue};
    }

    .control-center-dnd {
      margin-top: 5px;
      border-radius: 8px;
      background: ${surface0};
      border: 1px solid ${surface1};
      box-shadow: none;
    }

    .control-center-dnd:checked {
      background: ${surface0};
    }

    .control-center-dnd slider {
      background: ${surface1};
      border-radius: 8px;
    }

    .widget-dnd {
      margin: 0px;
      font-size: 1.1rem;
    }

    .widget-dnd > switch {
      font-size: initial;
      border-radius: 8px;
      background: ${surface0};
      border: 1px solid ${surface1};
      box-shadow: none;
    }

    .widget-dnd > switch:checked {
      background: ${surface0};
    }

    .widget-dnd > switch slider {
      background: ${surface1};
      border-radius: 8px;
      border: 1px solid ${overlay0};
    }

    .widget-mpris .widget-mpris-player {
      background: ${surface0};
      padding: 7px;
    }

    .widget-mpris .widget-mpris-title {
      font-size: 1.2rem;
    }

    .widget-mpris .widget-mpris-subtitle {
      font-size: 0.8rem;
    }

    .widget-menubar > box > .menu-button-bar > button > label {
      font-size: 3rem;
      padding: 0.5rem 2rem;
    }

    .widget-menubar > box > .menu-button-bar > :last-child {
      color: ${red};
    }

    .power-buttons button:hover,
    .powermode-buttons button:hover,
    .screenshot-buttons button:hover {
      background: ${surface0};
    }

    .control-center .widget-label > label {
      color: ${text};
      font-size: 2rem;
    }

    .widget-buttons-grid {
      padding-top: 1rem;
    }

    .widget-buttons-grid > flowbox > flowboxchild > button label {
      font-size: 2.5rem;
    }

    .widget-volume {
      padding-top: 1rem;
    }

    .widget-volume label {
      font-size: 1.5rem;
      color: ${sapphire};
    }

    .widget-volume trough highlight {
      background: ${sapphire};
    }

    .widget-backlight trough highlight {
      background: ${yellow};
    }

    .widget-backlight scale {
      margin-right: 1rem;
    }

    .widget-backlight label {
      font-size: 1.5rem;
      color: ${yellow};
    }

    .widget-backlight .KB {
      padding-bottom: 1rem;
    }
  '';
  home.packages = [pkgs.swaynotificationcenter];
}
