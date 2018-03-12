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
#     $ curl localhost:8765; lynx localhost:8765
# =============================================================================
# See for ref.: https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html
#

import json

ENV_N = "envvars"
APP_N = "appname"
APP_V = "WSGI application template"

RSC_HTTP_200_OK    = "200"
HDR_CONTENT_TYPE_N = "Content-Type"
HDR_CONTENT_TYPE_V = "application/json"

# The application entry point.
def app(env, resp):
    # JSONifying the response.
    resp_buffer = json.dumps({
        ENV_N : str(env),
        APP_N : APP_V
    })

    # Adding headers to the response.
    resp(RSC_HTTP_200_OK,
       [(HDR_CONTENT_TYPE_N,
         HDR_CONTENT_TYPE_V)])

    return resp_buffer.encode()

# vim:set nu et ts=4 sw=4:
