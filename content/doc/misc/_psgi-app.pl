#
# content/doc/misc/_psgi-app.pl
# =============================================================================
# PSGI application template.
# Usage:
#     $ uwsgi --http :8765 --master                      \
#                          --processes      `nproc`      \
#                          --http-modifier1  5           \
#                          --psgi           _psgi-app.pl
#
#     $ curl localhost:8765; curl -XPOST localhost:8765; lynx localhost:8765
# =============================================================================
# See for ref.: https://uwsgi-docs.readthedocs.io/en/latest/PSGIquickstart.html
#

use strict;
use warnings;
use utf8;
use v5.10;

use JSON;
use Data::Dumper;

use constant APP_V => "PSGI application template";

use constant {
    HDR_CONTENT_TYPE  => "application/json",
    HDR_CACHE_CONTROL => "no-cache, no-store, must-revalidate",
    HDR_EXPIRES       => "Thu, 01 Dec 1994 16:00:00 GMT",
    HDR_PRAGMA        => "no-cache",
    RSC_HTTP_200_OK   => 200,
};

# The application entry point.
my $app = sub {
    my $env = shift();

    # Creating and JSONifying the response.
    my $resp_buffer =  encode_json({
        envvars     => Dumper($env),
        appname     => APP_V,
    });

    # Adding headers to the response.
    my $resp_headrs      =[
        "Content-Type"   => HDR_CONTENT_TYPE,
        "Content-Length" => length($resp_buffer),
        "Cache-Control"  => HDR_CACHE_CONTROL,
        "Expires"        => HDR_EXPIRES,
        "Pragma"         => HDR_PRAGMA,
    ];

    return [
         RSC_HTTP_200_OK,
         $resp_headrs,
        [$resp_buffer]
    ];
};

# vim:set nu et ts=4 sw=4:
