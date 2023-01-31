Firefox tweaks:

1. Find the profile folder: `about:support`, find “Profile Directory”.
2. `about:config` -> `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`
3. Creates a folder `chrome` under profile folder.

Some tweaks:

* Enable Compact Mode: `about:config` -> `browser.compactmode.show` to `true`
* Remove Extensions Button: `about:config` -> `extensions.unifiedExtensions.enabled` to `false`
* Compact toobar: `Customize mode > Density > Compact`.
* Startup Image: `about:config` -> `browser.startup.preXulSkeletonUI` -> `false`

Css tweaks for [tabcenter-reborn](https://addons.mozilla.org/en-US/firefox/addon/tabcenter-reborn/):

* https://framagit.org/ariasuni/tabcenter-reborn/-/wikis/home
* https://github.com/ranmaru22/firefox-vertical-tabs
