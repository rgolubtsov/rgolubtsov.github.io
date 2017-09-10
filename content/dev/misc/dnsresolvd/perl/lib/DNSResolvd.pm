#
# content/dev/misc/dnsresolvd/perl/lib/DNSResolvd.pm
# =============================================================================
# DNS Resolver Daemon (dnsresolvd). Version 0.1
# =============================================================================
# A Mojolicious-boosted daemon for performing DNS lookups.
# =============================================================================
# Copyright (C) 2017 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

package DNSResolvd;

use strict;
use warnings;
use utf8;
use v5.10;

use Mojo::Base "Mojolicious";

use DNSResolvd::ControllerHelper
    "_EXIT_SUCCESS";

##
# Starts up the app.
#
# @param {String[]} args - The array of command-line arguments.
#
# @returns {Number} The exit code indicating the app overall execution status.
#
sub startup {
    my  $self  = shift();
    my ($args) = @_;

    my $ret = _EXIT_SUCCESS;

    # Load configuration from hash returned by "d_n_s_resolvd.conf".
    my $config = $self->plugin("Config");

    # Router.
    my $router = $self->routes;

    # Normal route to controller.
    $router->get("/")->to("example#welcome");
}

1;

# vim:set nu:et:ts=4:sw=4:
