# -*- coding: utf-8 -*-
# content/doc/misc/_wsgi-app.py
# =============================================================================
# WSGI application template.
# Usage:
#     $ uwsgi --http :8765 --master                 \
#                          --processes `nproc`      \
#                          --callable   app         \
#                          --wsgi-file _wsgi-app.py
#
#     $ curl localhost:8765; curl -XPOST localhost:8765; lynx localhost:8765
# =============================================================================
# See for ref.: https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html
#

import json

ENV_N = "envvars"
APP_N = "appname"
APP_V = "WSGI application template"

RSC_HTTP_200_OK      = "200"
HDR_CONTENT_TYPE_N   = "Content-Type"
HDR_CONTENT_TYPE_V   = "application/json"
HDR_CONTENT_LENGTH_N = "Content-Length"
HDR_CACHE_CONTROL_N  = "Cache-Control"
HDR_CACHE_CONTROL_V  = "no-cache, no-store, must-revalidate"
HDR_EXPIRES_N        = "Expires"
HDR_EXPIRES_V        = "Thu, 01 Dec 1994 16:00:00 GMT"
HDR_PRAGMA_N         = "Pragma"
HDR_PRAGMA_V         = "no-cache"

# The application entry point.
def app(env, resp):
    # Creating and JSONifying the response.
    resp_buffer = json.dumps({
        ENV_N : str(env),
        APP_N : APP_V
    }).encode()

    resp_headrs = [
        (HDR_CONTENT_TYPE_N,   HDR_CONTENT_TYPE_V   ),
        (HDR_CONTENT_LENGTH_N, str(len(resp_buffer))),
        (HDR_CACHE_CONTROL_N,  HDR_CACHE_CONTROL_V  ),
        (HDR_EXPIRES_N,        HDR_EXPIRES_V        ),
        (HDR_PRAGMA_N,         HDR_PRAGMA_V         ),
    ]

    # Adding headers to the response.
    resp(RSC_HTTP_200_OK, resp_headrs)

    return [resp_buffer]

# vim:set nu et ts=4 sw=4:
