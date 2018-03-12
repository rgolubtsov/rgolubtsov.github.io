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
#     $ curl localhost:8765; lynx localhost:8765
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
    HDR_CONTENT_TYPE => "application/json",
    RSC_HTTP_200_OK  => 200,
};

# The application entry point.
my $app = sub {
    my $env = shift();

    # JSONifying the response.
    my $resp_buffer = encode_json({
        envvars => Dumper($env),
        appname => APP_V,
    });

    # Adding headers to the response.
    my $resp = ["Content-Type" => HDR_CONTENT_TYPE];

    return [RSC_HTTP_200_OK, $resp, [$resp_buffer]];
};

# vim:set nu et ts=4 sw=4:
