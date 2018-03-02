# -*- coding: utf-8 -*-
# content/doc/misc/_wsgi-app.py
# =============================================================================
# WSGI application template.
# Usage:
#     $ uwsgi --http :8765 --wsgi-file _wsgi-app.py
#     $ curl localhost:8765
# =============================================================================
# See for ref.: https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html
#

TXT = "\nWSGI application template.\n"

RSC_HTTP_200_OK    = "200"
HDR_CONTENT_TYPE_N = "Content-Type"
HDR_CONTENT_TYPE_V = "text/plain"

# The application entry point.
def application(env, resp):
    _env = str(env).encode()
    _txt = str(TXT).encode()

    resp(RSC_HTTP_200_OK,
       [(HDR_CONTENT_TYPE_N,
         HDR_CONTENT_TYPE_V)])

    return [_env, _txt]

# vim:set nu et ts=4 sw=4:
