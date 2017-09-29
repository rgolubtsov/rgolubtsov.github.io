#
# content/dev/misc/dnsresolvd/perl/lib/DnsResolvd/DnsLookupController.pm
# =============================================================================
# DNS Resolver Daemon (dnsresolvd). Version 0.1
# =============================================================================
# A Mojolicious-boosted daemon for performing DNS lookups.
# =============================================================================
# Copyright (C) 2017 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

package DnsResolvd::DnsLookupController;

use strict;
use warnings;
use utf8;
use v5.10;

use Mojo::Base "Mojolicious::Controller";

use DnsResolvd::ControllerHelper
    "_EXIT_SUCCESS";

## Constant: The HTTP response buffer template.
use constant RESP_BUFFER => "dnsresolvd";

##
# Performs DNS lookup action for the given hostname,
# i.e. (in this case) IP address retrieval by hostname.
#
# @return The HTTP response status code indicating the result
#         of rendering the response buffer template.
#
sub dns_lookup {
    my $self = shift();

    my $ret = _EXIT_SUCCESS;

    # Rendering the response buffer template.
    $ret = $self->render(resp_buffer => RESP_BUFFER);

    return $ret;
}

1;

# vim:set nu:et:ts=4:sw=4:
