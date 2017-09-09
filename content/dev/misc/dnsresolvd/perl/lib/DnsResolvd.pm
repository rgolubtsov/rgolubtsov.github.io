#
# content/dev/misc/dnsresolvd/perl/dns_resolvd/lib/DnsResolvd.pm
# =============================================================================
# DNS Resolver Daemon (dnsresolvd). Version 0.1
# =============================================================================
# A Mojolicious-boosted daemon for performing DNS lookups.
# =============================================================================
# Copyright (C) 2017 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

package DnsResolvd;

use strict;
use warnings;
use utf8;
use v5.10;

use Mojo::Base "Mojolicious";

# This method will run once at server start.
sub startup {
    my $self = shift();

    # Load configuration from hash returned by "dns_resolvd.conf".
    my $config = $self->plugin("Config");

    # Documentation browser under "/perldoc".
    $self->plugin("PODRenderer") if $config->{perldoc};

    # Router.
    my $r = $self->routes;

    # Normal route to controller.
    $r->get("/")->to("example#welcome");
}

1;

# vim:set nu:et:ts=4:sw=4:
