{pkgs, ...}: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
        ];
      };

      settings = {
        "extensions.autoDisableScopes" = 0;
        "browser.toolbars.bookmarks.visibility" = "always";
      };
    };
  };
}
