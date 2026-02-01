/*
 * radicchio.js
 * ============================================================================
 * A Cup of Radicchio. Version 1.2.3
 * ----------------------------------------------------------------------------
 * A Cup of Radicchio: A personal website of a power looper,
 *                                           a skateboarder,
 *                                       and a coder.
 * ============================================================================
 * Copyright (C) 2020-2026 Radislav (Radicchio) Golubtsov
 */

"use strict";

// Highlights the current navbar item.
(function() {
    var URL_ITEM_PREFIX  = /\/data/;
    var NAV_ITEM_PREFIX  = "nav-";
    var BACKGROUND_COLOR = "#5db52a";
    var COLOR            = "#7aef17";

    var page_url = document.URL;
    var x = page_url.search(URL_ITEM_PREFIX);

    if (x > -1) {
        var url_item = page_url.substring(x + 6, x + 10);
        var nav_item = document.getElementById(NAV_ITEM_PREFIX + url_item);

        if (nav_item != null) {
            nav_item.style.backgroundColor = BACKGROUND_COLOR;
            nav_item.style.color           = COLOR;
        }
    }
})();

// vim:set nu et ts=4 sw=4:
