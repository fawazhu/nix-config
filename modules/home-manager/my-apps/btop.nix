{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my-apps.enable {
    xdg.configFile."btop/themes".source = "${pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "btop";
      rev = "1.0.0";
      sha256 = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
    }}/themes";
    xdg.configFile."btop/btop.conf".text = ''
      color_theme = "/home/fawaz/.config/btop/themes/catppuccin_${config.my-apps.catppuccinFlavour}.theme"
      theme_background = True
      truecolor = True
      force_tty = False
      presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty"
      vim_keys = True
      rounded_corners = True
      graph_symbol = "braille"
      graph_symbol_cpu = "default"
      graph_symbol_gpu = "default"
      graph_symbol_mem = "default"
      graph_symbol_net = "default"
      graph_symbol_proc = "default"
      shown_boxes = "net proc cpu mem"
      update_ms = 2000
      proc_sorting = "memory"
      proc_reversed = False
      proc_tree = True
      proc_colors = True
      proc_gradient = True
      proc_per_core = True
      proc_mem_bytes = True
      proc_cpu_graphs = True
      proc_info_smaps = False
      proc_left = False
      proc_filter_kernel = False
      proc_aggregate = True
      cpu_graph_upper = "Auto"
      cpu_graph_lower = "Auto"
      show_gpu_info = "Auto"
      cpu_invert_lower = True
      cpu_single_graph = False
      cpu_bottom = False
      show_uptime = True
      check_temp = True
      cpu_sensor = "Auto"
      show_coretemp = True
      cpu_core_map = ""
      temp_scale = "celsius"
      base_10_sizes = False
      show_cpu_freq = True
      clock_format = ""
      background_update = True
      custom_cpu_name = ""
      disks_filter = ""
      mem_graphs = True
      mem_below_net = False
      zfs_arc_cached = True
      show_swap = True
      swap_disk = True
      show_disks = True
      only_physical = True
      use_fstab = True
      zfs_hide_datasets = False
      disk_free_priv = False
      show_io_stat = True
      io_mode = False
      io_graph_combined = False
      io_graph_speeds = ""
      net_download = 100
      net_upload = 100
      net_auto = True
      net_sync = True
      net_iface = ""
      show_battery = True
      selected_battery = "Auto"
      show_battery_watts = True
      log_level = "WARNING"
      nvml_measure_pcie_speeds = True
      gpu_mirror_graph = True
      custom_gpu_name0 = ""
      custom_gpu_name1 = ""
      custom_gpu_name2 = ""
      custom_gpu_name3 = ""
      custom_gpu_name4 = ""
      custom_gpu_name5 = ""
    '';
    home.packages = [pkgs.btop];
  };
}
