#
# content/dev/misc/dnsresolvd/perl/dns_resolvd/t/basic.t
# =============================================================================
# DNS Resolver Daemon (dnsresolvd). Version 0.1
# =============================================================================
# A Mojolicious-boosted daemon for performing DNS lookups.
# =============================================================================
# Copyright (C) 2017 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

use strict;
use warnings;
use utf8;
use v5.10;

use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new("DnsResolvd");

$t->get_ok("/")->status_is(200)->content_like(qr/Mojolicious/i);

done_testing();

# vim:set nu:et:ts=4:sw=4:
