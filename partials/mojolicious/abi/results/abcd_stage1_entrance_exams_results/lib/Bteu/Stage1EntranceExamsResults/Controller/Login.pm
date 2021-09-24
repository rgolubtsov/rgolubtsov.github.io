#
# lib/Bteu/Stage1EntranceExamsResults/Controller/Login.pm
# =============================================================================
# Stage 1 Entrance Exams Results.
# Результаты вступительных испытаний.
# =============================================================================
# Written by Radislav (Radicchio) Golubtsov, 2021
#

package Bteu::Stage1EntranceExamsResults::Controller::Login;

use Mojo::Base "Mojolicious::Controller", -signatures;

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
    DAY_2     => "30.07.2021",
    HIDE_HREF => "display:none",
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
        title1   => "Результаты вступительных испытаний",
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

    # In case of getting an empty result set,
    # don't trying to authenticate at all.
    if (!(@{$row_set})) {
#       say(__PACKAGE__ . _COLON_SPACE_SEP . _ERROR_PREFIX
#                       . _COLON_SPACE_SEP . _ERROR_NO_SUCH_USER);

        return _auth_failed($self);
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
        my $given_name    = $row_set->[0][0];
        my $family_name   = $row_set->[0][1];
        my $studying_form = $row_set->[0][3];
        my $subject1      = $row_set->[0][4];
        my $date1         = $row_set->[0][5];
        my $subject2      = $row_set->[0][6];
        my $date2         = $row_set->[0][7];

        my $d1 = "/results/rezultaty?id="; my $d2 = $d1;

        my $sess_key_1 = substr($session_key,  8, 12);
        my $sess_key_2 = substr($session_key,  4, 12);
        my $sess_key_3 = substr($session_key, 17, 19);

        $d1 .= "$sess_key_1" . substr($studying_form, 0, 5) . "$sess_key_3"
            .  lc($subject1) . "$sess_key_2$sess_key_3";

        $d2 .= "$sess_key_1" . substr($studying_form, 0, 5) . "$sess_key_3"
            .  lc($subject2) . "$sess_key_2$sess_key_3";

        $d1 =~ s/\ //g; $d1 =~ s/\.//g;
        $d2 =~ s/\ //g; $d2 =~ s/\.//g;

        $self->session(d1 => $d1);
        $self->session(d2 => $d2);

        _auth_succeeded($self,
            $given_name,
            $family_name,
            $studying_form,
            $subject1, $date1,
            $subject2, $date2,
            $d1, $d2,
        );
    } else {
        _auth_failed($self);
    }
}

sub _auth_succeeded($self,
    $given_name,
    $family_name,
    $studying_form,
    $subject1, $date1,
    $subject2, $date2,
    $d1, $d2,
) {
    my $show_hide1 = _EMPTY_STRING;
    my $show_hide2 = _EMPTY_STRING;

#   if ($date1 eq DAY_2) { $show_hide1 = HIDE_HREF; }
#   if ($date2 eq DAY_2) { $show_hide2 = HIDE_HREF; }

    $self->session()->{msg} = "<div><strong>Абитуриент:</strong> $given_name $family_name<br />"
        . "<strong>Форма обучения:</strong> $studying_form<br />"
        . "<strong>Результаты вступительных испытаний:</strong>&nbsp;&nbsp;"
        . "<span style=\"font-size:smaller\">(при скачивании откроются в новых вкладках)</span></div>"
        . "<div><table id=\"table\"><tbody><tr class=\"subject1\"><td>$date1</td><td>$subject1</td>"
        . "<td style=\"text-align:right\"><a href=\"$d1\" target=\"_blank\" "
        . "rel=\"noopener noreferrer\" style=\"$show_hide1\">скачать</a></td></tr><tr class=\"subject2\"><td>$date2</td>"
        . "<td>$subject2</td><td style=\"text-align:right\"><a href=\"$d2\" target=\"_blank\" "
        . "rel=\"noopener noreferrer\" style=\"$show_hide2\">скачать</a></td></tr></tbody></table></div>";

    $self->session(expiration => 900); # <== 15 minutes.

    $self->redirect_to("/results");
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
            . "    given_name,"
            . "    username,"
            . "    password,"
            . " sf.studying_form_name                 as studying_form,"
            . " (select"
                    . " subject_name"
                . " from"
                    . " abcd_stage1_entrance_exams_results_subjects"
                . " where"
                    . " subject1_id = id)             as subject1,"
            . " to_char((select"
                    . " exam_date"
                . " from"
                    . " abcd_stage1_entrance_exams_results_exams_dates"
                . " where"
                    . " date1_id = id), 'DD.MM.YYYY') as date1,"
            . " (select"
                    . " subject_name"
                . " from"
                    . " abcd_stage1_entrance_exams_results_subjects"
                . " where"
                    . " subject2_id = id)             as subject2,"
            . " to_char((select"
                    . " exam_date"
                . " from"
                    . " abcd_stage1_entrance_exams_results_exams_dates"
                . " where"
                    . " date2_id = id), 'DD.MM.YYYY') as date2"
        . " from"
            . " abcd_stage1_entrance_exams_results_users,"
            . " abcd_stage1_entrance_exams_results_studying_forms sf,"
            . " abcd_stage1_entrance_exams_results_subjects       subj,"
            . " abcd_stage1_entrance_exams_results_exams_dates    date"
        . " where"
            . " (username         =       ?) and"
            . " (password         =       ?) and"
            . " (studying_form_id =   sf.id) and"
            . " (subject1_id      = subj.id) and"
            . " (date1_id         = date.id)";

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
