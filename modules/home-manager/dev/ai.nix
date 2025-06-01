{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.dev.ai {
    services.podman = {
      containers = {
        ollama = {
          image = "ollama/ollama:rocm";
          environment.HCC_AMDGPU_TARGET = "gfx1100";
          environment.HSA_OVERRIDE_GFX_VERSION = "11.0.0";
          ports = ["11434:11434"];
          network = "ollama";
          volumes = ["ollama:/root/.ollama"];
          devices = ["/dev/kfd" "/dev/dri"];
        };
        open-webui = {
          image = "ghcr.io/open-webui/open-webui:main";
          ports = ["127.0.0.1:11435:8080"];
          network = "ollama";
          volumes = ["open-webui:/app/backend/data"];
        };
      };
      networks.ollama = {};
    };
  };
}
