file="/usr/lib/firefox/browser/defaults/preferences/vendor.js"

cat > ${file} << EOF
pref("browser.tabs.drawInTitlebar", true);
pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"home-button\",\"urlbar-container\",\"downloads-button\",\"library-button\",\"sidebar-button\",\"fxa-toolbar-menu-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\"],\"dirtyAreaCache\":[],\"currentVersion\":16,\"newElementCount\":2}");
pref("app.normandy.first_run", false);
pref("browser.aboutwelcome.enabled", false);
pref("browser.startup.firstrunSkipsHomepage", false);
pref("browser.toolbars.bookmarks.visibility", "newtab"); //always reverts anyways
pref("startup.homepage_welcome_url","");
pref("startup.homepage_override_url","");
pref("datareporting.policy.firstRunURL",""); //stop firefox privacy page from showing up
EOF