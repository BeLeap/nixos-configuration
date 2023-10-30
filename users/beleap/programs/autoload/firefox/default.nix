{ pkgs, ... }:
{
  enable = true;

  package = pkgs.wrapFirefox pkgs.firefox-bin-unwrapped {
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
        "font.name.sans-serif.x-western" = "Pretendard";
        "font.name.serif.x-western" = "Noto Serif CJK KR";
        "font.name.monospace.x-western" = "CaskaydiaCove Nerd Font";
        "font.name.sans-serif.ko" = "Pretendard";
        "font.name.serif.ko" = "Noto Serif CJK KR";
        "font.name.monospace.ko" = "NanumGothicCoding";
        "identity.fxaccounts.enabled" = false;
        "privacy.webrtc.legacyGlobalIndicator" = false;
        "app.update.auto" = false;
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
        onepassword-password-manager
        tridactyl
        refined-github
        sidebery
        i-dont-care-about-cookies
        auto-tab-discard
        omnivore
      ];
      search = {
        force = true;
        default = "DuckDuckGo";
        engines = {
          "DuckDuckGo" = {
            urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
            iconUpdateURL = "https://duckduckgo.com/favicon.ico";
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
          "My NixOS" = {
            urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
            iconUpdateURL = "https://mynixos.com/icon.svg";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@nm"];
          };
          "GitHub" = {
            urls = [{ template = "https://github.com/search?q={searchTerms}"; }];
            iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@gh"];
          };
          "Naver Dictionary" = {
            urls = [{ template = "https://dict.naver.com/search?query={searchTerms}"; }];
            iconUpdateURL = "https://ssl.pstatic.net/dicimg/favicons/dict/v7/home/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@nd"];
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
