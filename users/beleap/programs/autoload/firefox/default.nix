{ pkgs, ... }:
{
  enable = true;

  package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    extraPolicies = {
      CaptivePortal = false;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFirefoxAccounts = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      FirefoxHome = {
        Search = true;
        Pocket = false;
        Snippets = false;
        TopSites = false;
        Highlights = false;
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
    };
    cfg = {
      enableGnomeExtensions = true;
      enableTridactylNative = true;
    };
  };


  profiles = 
  let
    common = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.aboutConfig.showWarning" = false;
        "browser.autofocus" = false;
        "browser.uiCustomization.state" = builtins.readFile(./. + "/uiCustomization.state.json");
      };
      userChrome = ''
        #main-window #titlebar {
          overflow: hidden;
          transition: height 0.3s 0.3s !important;
        }
        /* Default state: Set initial height to enable animation */
        #main-window #titlebar { height: 3em !important; }
        #main-window[uidensity="touch"] #titlebar { height: 3.35em !important; }
        #main-window[uidensity="compact"] #titlebar { height: 2.7em !important; }
        /* Hidden state: Hide native tabs strip */
        #main-window[titlepreface*="[Sidebery]"] #titlebar { height: 0 !important; }
        /* Hidden state: Fix z-index of active pinned tabs */
        #main-window[titlepreface*="[Sidebery]"] #tabbrowser-tabs { z-index: 0 !important; }
      '';
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        profile-switcher
        onepassword-password-manager
        tridactyl
        refined-github
        sidebery
        i-dont-care-about-cookies
        auto-tab-discard
      ];
      search = {
        force = true;
        default = "Phind";
        engines = {
          "Phind" = {
            urls = [{ template = "https://www.phind.com/search?q={searchTerms}"; }];
            iconUpdateURL = "https://www.phind.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
          };
          "Nix Packages" = {
            urls = [{ template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; }];
            iconUpdateURL = "https://nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@np"];
          };
          "Nix Home Manager" = {
            urls = [{ template = "https://github.com/nix-community/home-manager/search?q={searchTerms}"; }];
            iconUpdateURL = "https://nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@nhm"];
          };
          "GitHub" = {
            urls = [{ template = "https://github.com//search?q={searchTerms}"; }];
            iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@gh"];
          };
        };
      };
    };
  in
  {
    personal = {
      id = 0;
      name = "personal";

      settings = common.settings;
      userChrome = common.userChrome;
      extensions = common.extensions;
      search = common.search;
      isDefault = true;

      bookmarks = [];
    };
    work = {
      id = 1;
      name = "work";

      settings = common.settings;
      userChrome = common.userChrome;
      extensions = common.extensions;
      search = common.search;

      bookmarks = [
        {
          name = "Shortcut";
          toolbar = true;
          bookmarks = [
            {
              name = "Terraform | AWS";
              url = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs";
              keyword = "tfaws";
            }
          ];
        }
      ];
    };
  };
}
