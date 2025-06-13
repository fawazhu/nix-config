{pkgs, ...}: {
  home.packages = with pkgs; [wayland-utils wl-clipboard];

  programs.plasma = {
    enable = true;
    configFile = {
      kdeglobals = {
        General = {
          TerminalApplication = "alacritty";
          TerminalService = "Alacritty.desktop";
          XftAntialias = false;
          XftHintStyle = "hintslight";
          XftSubPixel = "none";
        };
        KDE.ShowDeleteCommand = false;
      };
      kwallet = {
        Wallet = {
          "Close When Idle" = false;
          "Close on Screensaver" = false;
          "Default Wallet" = "kdewallet";
          Enabled = true;
          "First Use" = false;
          "Idle Timeout" = 10;
          "Launch Manager" = true;
          "Leave Manager Open" = false;
          "Leave Open" = true;
          "Prompt on Open" = false;
          "Use One Wallet" = true;
        };
        "org.freedesktop.secrets".apiEnabled = true;
      };
      kwinrc = {
        Effect-diminactive = {
          DimFullScreen = false;
          Strength = 50;
        };
        Plugins = {
          dynamic_workspacesEnabled = true;
          krohnkiteEnabled = true;
        };
        Script-krohnkite = {
          binaryTreeLayoutOrder = 0;
          floatedWindowsLayer = 2;
          layoutPerActivity = false;
          preventMinimize = true;
          soleWindowNoGaps = true;
          spiralLayoutOrder = 1;
          tileLayoutOrder = 2;
        };
        Windows = {
          DelayFocusInterval = 0;
          FocusPolicy = "FocusFollowsMouse";
          NextFocusPrefersMouse = true;
        };
      };
    };
    fonts = {
      fixedWidth = {
        family = "JetBrainsMonoNL Nerd Font";
        pointSize = 10;
        weight = 400;
      };
    };
    krunner = {
      position = "center";
      shortcuts = {
        launch = "Meta+R";
        runCommandOnClipboard = "Meta+Shift+R";
      };
    };
    kwin.effects.dimInactive.enable = true;
    panels = [
      {
        floating = true;
        widgets = [
          "com.himdek.kde.plasma.overview"
          "org.kde.plasma.pager"
          {
            name = "org.kde.plasma.icontasks";
            config.General = {
              launchers = "preferred://browser,applications:Alacritty.desktop,applications:org.gnome.Nautilus.desktop";
              middleClickAction = "None";
              minimizeActiveTaskOnClick = false;
              unhideOnAttention = false;
              wheelEnabled = false;
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          {
            name = "org.kde.plasma.digitalclock";
            config.Appearance = {
              autoFontAndSize = false;
              customDateFormat = "dd-MM-yy";
              dateFormat = "custom";
              fontFamily = "JetBrainsMono Nerd Font";
              fontStyleName = "Regular";
              fontWeight = 400;
            };
          }
          {
            name = "org.kde.plasma.lock_logout";
            config.General.show_lockScreen = false;
          }
        ];
      }
    ];
    powerdevil = {
      AC.powerButtonAction = "nothing";
      battery.powerButtonAction = "nothing";
      lowBattery.powerButtonAction = "nothing";
    };
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    shortcuts = {
      ksmserver = {
        "Lock Session" = "Meta+P";
        "Shut Down" = [];
      };
      kwin = {
        "Activate Window Demanding Attention" = [];
        "Edit Tiles" = [];
        Expose = [];
        ExposeAll = [];
        ExposeClass = [];
        ExposeClassCurrentDesktop = [];
        "Grid View" = [];
        "Kill Window" = "Meta+Alt+X";
        KrohnkiteFocusDown = "Meta+J";
        KrohnkiteFocusLeft = "Meta+H";
        KrohnkiteFocusRight = "Meta+L";
        KrohnkiteFocusUp = "Meta+K";
        KrohnkiteGrowHeight = "Meta+Ctrl+J";
        KrohnkiteGrowWidth = "Meta+Ctrl+L";
        KrohnkiteNextLayout = "Meta+]";
        KrohnkitePreviousLayout = "Meta+[";
        KrohnkiteSetMaster = "Meta+Enter";
        KrohnkiteShiftDown = "Meta+Shift+J";
        KrohnkiteShiftLeft = "Meta+Shift+H";
        KrohnkiteShiftRight = "Meta+Shift+L";
        KrohnkiteShiftUp = "Meta+Shift+K";
        KrohnkiteShrinkHeight = "Meta+Ctrl+K";
        KrohnkiteShrinkWidth = "Meta+Ctrl+H";
        KrohnkiteToggleFloat = "Meta+F";
        Overview = "Meta,Meta+W";
        "Show Desktop" = [];
        "Switch One Desktop Down" = [];
        "Switch One Desktop Up" = [];
        "Switch One Desktop to the Left" = [];
        "Switch One Desktop to the Right" = [];
        "Switch Window Down" = [];
        "Switch Window Left" = [];
        "Switch Window Right" = [];
        "Switch Window Up" = [];
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Walk Through Windows" = [];
        "Walk Through Windows (Reverse)" = [];
        "Walk Through Windows of Current Application" = [];
        "Walk Through Windows of Current Application (Reverse)" = [];
        "Window Above Other Windows" = [];
        "Window Below Other Windows" = [];
        "Window Close" = "Meta+X";
        "Window Fullscreen" = "Meta+G";
        "Window Maximize" = [];
        "Window Minimize" = [];
        "Window One Desktop Down" = [];
        "Window One Desktop Up" = [];
        "Window One Desktop to the Left" = [];
        "Window One Desktop to the Right" = [];
        "Window Operations Menu" = [];
        "Window Quick Tile Bottom" = [];
        "Window Quick Tile Left" = [];
        "Window Quick Tile Right" = [];
        "Window Quick Tile Top" = [];
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+\"";
        "Window to Desktop 3" = "Meta+£";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window to Desktop 6" = "Meta+^";
        "Window to Desktop 7" = "Meta+&";
        "Window to Desktop 8" = "Meta+*";
        "Window to Desktop 9" = "Meta+(";
        "Window to Next Desktop" = [];
        "Window to Previous Desktop" = [];
        disableInputCapture = [];
      };
      org_kde_powerdevil.PowerOff = [];
      plasmashell = {
        "activate application launcher" = [];
        "activate task manager entry 1" = [];
        "activate task manager entry 2" = [];
        "activate task manager entry 3" = [];
        "activate task manager entry 4" = [];
        "activate task manager entry 5" = [];
        "activate task manager entry 6" = [];
        "activate task manager entry 7" = [];
        "activate task manager entry 8" = [];
        "activate task manager entry 9" = [];
        cycle-panels = [];
        "manage activities" = [];
        "show dashboard" = [];
        "stop current activity" = [];
        "toggle do not disturb" = "Meta+N";
      };
      "services/org.gnome.Calculator.desktop"._launch = "Calculator";
      "services/org.kde.konsole.desktop"._launch = [];
      "services/org.kde.krunner.desktop" = {
        RunClipboard = "Meta+Shift+R";
        _launch = "Meta+R";
      };
      "services/org.kde.spectacle.desktop".RecordRegion = [];
    };
    window-rules = [
      {
        description = "Hide title bars";
        match.window-types = ["normal" "dialog"];
        apply.noborder = {
          value = true;
          apply = "force";
        };
      }
    ];
  };
}
