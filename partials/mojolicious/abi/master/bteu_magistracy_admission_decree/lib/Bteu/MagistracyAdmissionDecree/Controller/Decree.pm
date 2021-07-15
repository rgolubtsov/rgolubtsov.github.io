#
# lib/Bteu/MagistracyAdmissionDecree/Controller/Decree.pm
# =============================================================================
# Magistracy Admission Decree.
# Приказ о зачислении в магистратуру.
# =============================================================================
# Written by Radislav (Radicchio) Golubtsov, 2021
#

package Bteu::MagistracyAdmissionDecree::Controller::Decree;

use Mojo::Base "Mojolicious::Controller", -signatures;

# Helper constants.
use constant _EMPTY_STRING => "";

use constant {
    DECREE_1 => "prikaz-ochnaya-forma-obucheniya.pdf",
    DECREE_2 => "prikaz-zaochnaya-forma-obucheniya.pdf",
    DECREE_3 => "prikaz-zaochnaya-forma-obucheniya-potrebkoop.pdf",
};

##
# Renders the decree page.
#
# @param {Object} self - The object instance of the class.
#
sub go_decree($self) {
    if (!$self->is_user_authenticated()) {
        return $self->redirect_to("/login");
    }

    $self->render(
        template => "decree",
        title1   => "Приказ о зачислении в магистратуру",
        msg      => $self->session()->{msg},
    );
}

sub get_decree($self) {
    if (!$self->is_user_authenticated()) {
        return $self->redirect_to("/login");
    }

    my $studying_form = $self->param("sf") || _EMPTY_STRING;

#   my $session_id  = $self->req()->cookies()->[0]->value;
#   my $session_id  = $self->cookie("mojolicious");

#   my $sess_id_1   = substr($session_id,  4, 12);
#   my $sess_id_2   = substr($session_id,  8, 12);

    my $session_key = $self->app()->defaults("session_key");

    my $sess_key_1  = substr($session_key,  8, 12);
    my $sess_key_2  = substr($session_key,  4, 12);
    my $sess_key_3  = substr($session_key, 17, 19);

    my $decree = _EMPTY_STRING;

         if ($studying_form eq ($sess_key_1 . "1$sess_key_3" . "1$sess_key_2$sess_key_3")) {
        $decree             =           DECREE_1;
    } elsif ($studying_form eq ($sess_key_1 . "2$sess_key_3" . "2$sess_key_2$sess_key_3")) {
        $decree             =           DECREE_2;
    } elsif ($studying_form eq ($sess_key_1 . "3$sess_key_3" . "3$sess_key_2$sess_key_3")) {
        $decree             =           DECREE_3;
    } else {
        return $self->reply()->not_found();
    }

#   $self->res()->headers()->content_disposition("attachment; filename=\"$decree\"");
    $self->res()->headers()->content_disposition("inline");

    $self->reply()->file($self->app()->home()->child("decree", $decree));
}

1;

# vim:set nu et ts=4 sw=4:
