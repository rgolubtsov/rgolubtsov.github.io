#
# content/dev/misc/dnsresolvd/perl/dns_resolvd/lib/DnsResolvd/Co..../Example.pm
# =============================================================================
# DNS Resolver Daemon (dnsresolvd). Version 0.1
# =============================================================================
# A Mojolicious-boosted daemon for performing DNS lookups.
# =============================================================================
# Copyright (C) 2017 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

package DnsResolvd::Controller::Example;

use strict;
use warnings;
use utf8;
use v5.10;

use Mojo::Base "Mojolicious::Controller";

# This action will render a template.
sub welcome {
    my $self = shift();

    # Render template "example/welcome.html.ep" with message.
    $self->render(msg => "Welcome to the Mojolicious real-time web framework!");
}

1;

# vim:set nu:et:ts=4:sw=4:
