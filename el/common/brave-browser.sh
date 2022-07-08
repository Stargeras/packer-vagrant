#!/bin/bash

dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install brave-browser -y

cat > /opt/brave.com/brave/master_preferences << EOF
{
  "browser": {
    "has_seen_welcome_page": true,
    "window_placement": {
      "bottom": 1022,
      "left": 9,
      "maximized": false,
      "right": 1694,
      "top": 6,
      "work_area_bottom": 1080,
      "work_area_left": 0,
      "work_area_right": 1920,
      "work_area_top": 30
    }
  },
  "session": {
    "restore_on_startup": 5
  },
  "extensions": {
    "theme": {
      "use_system": false
    }
  },
  "default_search_provider": {
    "synced_guid": "485bf7d3-0215-45af-87dc-538868000001"
  },
  "default_search_provider_data": {
    "template_url_data": {
      "alternate_urls": [
        "{google:baseURL}#q={searchTerms}",
        "{google:baseURL}search#q={searchTerms}",
        "{google:baseURL}webhp#q={searchTerms}",
        "{google:baseURL}s#q={searchTerms}",
        "{google:baseURL}s?q={searchTerms}"
      ],
      "contextual_search_url": "{google:baseURL}_/contextualsearch?{google:contextualSearchVersion}{google:contextualSearchContextData}",
      "created_by_policy": false,
      "created_from_play_api": false,
      "date_created": "0",
      "doodle_url": "",
      "favicon_url": "https://www.google.com/images/branding/product/ico/googleg_lodp.ico",
      "id": "3",
      "image_url": "{google:baseSearchByImageURL}upload",
      "image_url_post_params": "encoded_image={google:imageThumbnail},image_url={google:imageURL},sbisrc={google:imageSearchSource},original_width={google:imageOriginalWidth},original_height={google:imageOriginalHeight}",
      "input_encodings": [
        "UTF-8"
      ],
      "is_active": 0,
      "keyword": ":g",
      "last_modified": "0",
      "last_visited": "0",
      "logo_url": "",
      "new_tab_url": "",
      "originating_url": "",
      "preconnect_to_search_url": true,
      "prefetch_likely_navigations": true,
      "prepopulate_id": 1,
      "safe_for_autoreplace": true,
      "search_url_post_params": "",
      "short_name": "Google",
      "side_search_param": "sidesearch",
      "suggestions_url": "{google:baseSuggestURL}search?{google:searchFieldtrialParameter}client={google:suggestClient}&gs_ri={google:suggestRid}&xssi=t&q={searchTerms}&{google:inputType}{google:omniboxFocusType}{google:cursorPosition}{google:currentPageUrl}{google:pageClassification}{google:clientCacheTimeToLive}{google:searchVersion}{google:sessionToken}{google:prefetchQuery}sugkey={google:suggestAPIKeyParameter}",
      "suggestions_url_post_params": "",
      "synced_guid": "485bf7d3-0215-45af-87dc-538868000001",
      "url": "{google:baseURL}search?q={searchTerms}&{google:RLZ}{google:originalQueryForSuggestion}{google:assistedQueryStats}{google:searchboxStats}{google:searchFieldtrialParameter}{google:iOSSearchLanguage}{google:prefetchSource}{google:searchClient}{google:sourceId}{google:contextualSearchVersion}ie={inputEncoding}",
      "usage_count": 0
    }
  }
}
EOF