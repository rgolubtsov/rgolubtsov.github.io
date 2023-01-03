#
# lib/Bteu/MagistracyAdmissionDecree.pm
# =============================================================================
# Magistracy Admission Decree.
# Приказ о зачислении в магистратуру.
# =============================================================================
# Written by Radislav (Radicchio) Golubtsov, 2021-2023
#

package Bteu::MagistracyAdmissionDecree;

use Mojo::Base "Mojolicious", -signatures;
use Mojo::Util "dumper";

use Try::Tiny;
use DBI;

# Helper constants.
use constant _COLON_SPACE_SEP => ": ";

# Common error messages.
use constant {
    _ERROR_PREFIX        => "Error",
    _ERROR_NO_DB_CONNECT => "Could not connect to the database.",
};

use constant {
    DATABASE => "<db_name>",
    HOSTNAME => "localhost",
};

use constant {
    DSN      => "dbi:Pg:database=" . DATABASE . ";host=" . HOSTNAME,
    USERNAME => "<dbusername>",
    PASSWORD => "<dbpassword>",
};

use constant {
    RAISE_ERROR_DBI_ATTR => 1,
    AUTO_COMMIT_DBI_ATTR => 0,
};

##
# Starts up the app.
#
# @param {Object} self - The object instance of the class.
#
sub startup($self) {
    # Loading the configuration.
    my $config = $self->plugin("NotYAMLConfig");

    # Configuring the application.
    $self->secrets($config->{secrets});

    my $_secrets = $self->secrets();

#   say(dumper($_secrets));

    $self->defaults(session_key => $_secrets->[0]);

    my $dbh;

    my %attr = (
        RaiseError => RAISE_ERROR_DBI_ATTR,
        AutoCommit => AUTO_COMMIT_DBI_ATTR,
    );

    # Trying to connect to the database.
    try {
        $dbh = DBI->connect(DSN, USERNAME, PASSWORD, \%attr);
    } catch {
        say(__PACKAGE__ . _COLON_SPACE_SEP . _ERROR_PREFIX
                        . _COLON_SPACE_SEP . $_);
    };

    if ($dbh) {
        # Storing the database handle object in the application object.
        $self->defaults(dbh => $dbh);
    } else {
        say(__PACKAGE__ . _COLON_SPACE_SEP . _ERROR_PREFIX
                        . _COLON_SPACE_SEP . _ERROR_NO_DB_CONNECT);
    }

    # Getting the router object.
    my $router = $self->routes();

    $router->any ("/"             )->to("Login#show_login" );
    $router->get ("/login"        )->to("Login#show_login" );
    $router->post("/login"        )->to("Login#do_login"   );
#   $router->get ("/decree"       )->requires(authenticated => 1)->to("Decree#go_decree");
    $router->get ("/decree"       )->to("Decree#go_decree" );
    $router->get ("/decree/prikaz")->to("Decree#get_decree");
    $router->post("/logout"       )->to("Login#do_logout"  );
}

1;

# vim:set nu et ts=4 sw=4:
