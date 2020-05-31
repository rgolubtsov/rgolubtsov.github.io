/*
 * radicchio.js
 * =============================================================================
 * A Cup of Radicchio. Version 0.1
 * =============================================================================
 * A Cup of Radicchio: A personal website of a power looper,
 *                                           a skateboarder,
 *                                       and a coder.
 * =============================================================================
 * Copyright (C) 2020 Radislav (Radicchio) Golubtsov
 */

"use strict";

// Highlights the current navbar item.
(function() {
    var URL_ITEM_PREFIX  = /\/data/;
    var NAV_ITEM_PREFIX  = "nav-";
    var BACKGROUND_COLOR = "#5db52a";
    var COLOR            = "#7aef17";

    var page_url = document.URL;

    console.log(page_url);

    var x = page_url.search(URL_ITEM_PREFIX);

    console.log(x);

    if (x > -1) {
        var url_item = page_url.substring(x + 6, x + 10);

        console.log(url_item);

        var nav_item = document.getElementById(NAV_ITEM_PREFIX + url_item);

        console.log(nav_item);

        if (nav_item != null) {
            nav_item.style.backgroundColor = BACKGROUND_COLOR;
            nav_item.style.color           = COLOR;
        }
    }
})();

// vim:set nu et ts=4 sw=4:
