{ pkgs, ... }: {
  programs.firefox = {
    package = pkgs.firefox.override {
      nativeMessagingHosts = [
        pkgs.gnome-browser-connector
      ];
    };

    enable = true;
    policies =
      let
        lock-false = {
          Value = false;
          Status = "locked";
        };
        lock-true = {
          Value = true;
          Status = "locked";
        };
      in
      {
        BlockAboutConfig = true;
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "always";
        searchBar = "unified";

        Preferences = { 
          "extensions.pocket.enabled" = lock-false;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        };
      };

    profiles.default = {
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
        ];
      };
    };
  };
}
