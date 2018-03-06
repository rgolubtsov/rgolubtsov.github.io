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

use Data::Dumper;

use constant TXT => "PSGI application template.\n";

use constant {
    HDR_CONTENT_TYPE => "text/plain",
    RSC_HTTP_200_OK  => 200,
};

# The application entry point.
my $app = sub {
    my $env = shift();

    my $resp = ["Content-Type" => HDR_CONTENT_TYPE];
    my $_txt = [Dumper($env), TXT];

    return [RSC_HTTP_200_OK, $resp, $_txt];
};

# vim:set nu et ts=4 sw=4:
