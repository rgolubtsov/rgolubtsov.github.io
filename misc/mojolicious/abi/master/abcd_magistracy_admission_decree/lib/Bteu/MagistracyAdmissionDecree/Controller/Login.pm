#
# lib/Bteu/MagistracyAdmissionDecree/Controller/Login.pm
# =============================================================================
# Magistracy Admission Decree.
# Приказ о зачислении в магистратуру.
# =============================================================================
# Written by Radislav (Radicchio) Golubtsov, 2021-2024
#

package Bteu::MagistracyAdmissionDecree::Controller::Login;

use Mojo::Base "Mojolicious::Controller", -signatures;
use Mojo::Util "dumper";

use Mojolicious::Plugin::Authentication;

# Helper constants.
use constant {
    _COLON_SPACE_SEP => ": ",
    _EMPTY_STRING    =>   "",
};

# Common error messages.
use constant {
    _ERROR_PREFIX       => "Error",
    _ERROR_NO_SUCH_USER => "No such user exists.",
};

use constant {
    STUDYING_FORM_1 => "очная (дневная) форма получения образования, индивидуальный договор",
    STUDYING_FORM_2 => "заочная форма получения образования, индивидуальный договор",
    STUDYING_FORM_3 => "заочная форма получения образования, за счет средств организаций потребительской кооперации",
};

##
# Renders the login page.
#
# @param {Object} self - The object instance of the class.
#
sub show_login($self) {
#   $self->session(expires => 1);

    $self->render(
        template => "login",
        title1   => "Приказ о зачислении в магистратуру",
        title2   => "Войти",
        error    => $self->flash("error"),
    );
}

##
# Performs the user logging in, including credentials validation
# and authentication.
#
# @param {Object} self - The object instance of the class.
#
sub do_login($self) {
    my $_username = ucfirst(lc($self->param("username")));
    my $_password =            $self->param("password");

    my $dbh = $self->app()->defaults("dbh");

    # Retrieving a user record from the database.
    my $row_set = get_user_from_db($_username, $_password, $dbh);

#   say(dumper($row_set));

    # In case of getting an empty result set,
    # don't trying to authenticate at all.
    if (!(@{$row_set})) {
#       say(__PACKAGE__ . _COLON_SPACE_SEP . _ERROR_PREFIX
#                       . _COLON_SPACE_SEP . _ERROR_NO_SUCH_USER);

        return _auth_failed($self);
#   } else {
#       for (my $i = 0; $i < 4; $i++) {
#           say($row_set->[0][$i]);
#       }
    }

    my $session_key = $self->app()->defaults("session_key");

    $self->app()->plugin("Authentication" => {
        session_key   => $session_key,
        load_user     => sub ($app, $uid) {
            if ($uid eq $row_set->[0][1]) {
                return $row_set;
            }

            return undef;
        },
        validate_user => sub ($self, $username, $password, $extradata) {
            if (($username eq $row_set->[0][1])
            &&  ($password eq $row_set->[0][2])) {
                return $username;
            }

            return undef;
        },
    });

    my $authenticated = $self->authenticate($_username, $_password);

    if ($authenticated) {
        my $given_name  = $row_set->[0][0];
        my $family_name = $row_set->[0][1];

        my $studying_form = _EMPTY_STRING;

        my $d = "/decree/prikaz?sf=";

             if ($row_set->[0][3] == 1) {
            $studying_form = STUDYING_FORM_1;
        } elsif ($row_set->[0][3] == 2) {
            $studying_form = STUDYING_FORM_2;
        } elsif ($row_set->[0][3] == 3) {
            $studying_form = STUDYING_FORM_3;
        }

#       my $session_id = $self->req()->cookies()->[0]->value;
#       my $session_id = $self->cookie("mojolicious");

#       my $sess_id_1  = substr($session_id,  4, 12);
#       my $sess_id_2  = substr($session_id,  8, 12);

        my $sess_key_1 = substr($session_key,  8, 12);
        my $sess_key_2 = substr($session_key,  4, 12);
        my $sess_key_3 = substr($session_key, 17, 19);

        $d .= "$sess_key_1$row_set->[0][3]$sess_key_3"
           .  "$row_set->[0][3]$sess_key_2$sess_key_3";

        _auth_succeeded($self, $given_name, $family_name, $studying_form, $d);
    } else {
        _auth_failed($self);
    }
}

sub _auth_succeeded($self, $given_name, $family_name, $studying_form, $d) {
    $self->session()->{msg} = "<strong>Абитуриент:</strong> $given_name $family_name<br />"
        . "<strong>Форма обучения:</strong> $studying_form<br />"
        . "<strong>Приказ о зачислении:</strong> <a style=\"border:1px solid #d0cdd9;"
        . "border-radius:3px;padding:2px 8px;text-decoration:none;background-color:#f0effb;"
        . "color:#000000\" href=\"$d\" target=\"_blank\" rel=\"noopener noreferrer\">скачать</a>"
        . "&nbsp;&nbsp;<span style=\"font-size:smaller\">(откроется в новой вкладке)</span>";

    $self->session(expiration => 900); # <== 15 minutes.

    $self->redirect_to("/decree");
}

sub _auth_failed($self) {
    $self->flash(error => "Абитуриента с такими фамилией и номером паспорта не существует.<br />"
        . "<span style=\"color:#002060\">Пожалуйста, введите корректные данные.</span>");

    $self->redirect_to("/login");
}

##
# Performs the user logging out.
#
# @param {Object} self - The object instance of the class.
#
sub do_logout($self) {
    $self->logout();

    $self->flash(error => "<span style=\"color:#002060\">Вы вышли из системы.</span>");

    $self->redirect_to("/login");
}

##
# Retrieves a user record identified by its username and password.
#
# @param {String} username - The username to identify a user.
# @param {String} password - The password to identify a user.
# @param {Object} dbh      - The database handle object.
#
# @returns {Object} References to the array containing a user record.
#
sub get_user_from_db($username, $password, $dbh) {
    my $get_user_sql_select = "select"
            . " given_name,"
            . " username,"
            . " password,"
            . " studying_form"
        . " from"
            . " <table_name>"
        . " where"
            . " (username = ?) and"
            . " (password = ?)";

    # Preparing the SQL statement.
    my $sth = $dbh->prepare($get_user_sql_select);

    $sth->execute($username, $password);

    # The result set. Finally it will be a quasi-two-dimensional array.
    my @row_set; # <== Declare it as an initially empty.

    my $i = 0;

    # Retrieving and processing the result set.
    while (my @row_ary = $sth->fetchrow_array()) {
        $row_set[$i] = [@row_ary];

        $i++;
    }

    return \@row_set;
}

1;

# vim:set nu et ts=4 sw=4:
