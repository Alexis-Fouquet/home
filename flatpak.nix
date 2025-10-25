{ ... }:
{
  services.flatpak.packages = [
    "app.zen_browser.zen"
  ];
  services.flatpak.update.auto = {
    enable = true;
  };
}
