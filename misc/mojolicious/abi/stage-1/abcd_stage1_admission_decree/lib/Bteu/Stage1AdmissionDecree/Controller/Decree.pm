#
# lib/Bteu/Stage1AdmissionDecree/Controller/Decree.pm
# =============================================================================
# Stage 1 Admission Decree.
# Приказ о зачислении на I ступень.
# =============================================================================
# Written by Radislav (Radicchio) Golubtsov, 2021-2023
#

package Bteu::Stage1AdmissionDecree::Controller::Decree;

use Mojo::Base "Mojolicious::Controller", -signatures;

# Helper constants.
use constant _EMPTY_STRING => "";

use constant {
    STUDYING_FORM_1 => "очная",
    STUDYING_FORM_2 => "заочн",
    STUDYING_FORM_3 => "второ",
};

use constant {
    CONTRACT_TYPE_1 => "засчетсредстворганизацийпотребительскойкооперации",
    CONTRACT_TYPE_2 => "индивидуальныйдоговор",
};

use constant {
    DECREE_11 => "prikaz-ochnaya-forma-obucheniya-potrebkoop.pdf",
    DECREE_12 => "prikaz-ochnaya-forma-obucheniya.pdf",
    DECREE_21 => "prikaz-zaochnaya-forma-obucheniya-potrebkoop.pdf",
    DECREE_22 => "prikaz-zaochnaya-forma-obucheniya.pdf",
    DECREE_32 => "prikaz-vtoroe-vysshee-obrazovanie.pdf",
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
        title1   => "Приказ о зачислении на I ступень",
        msg      => $self->session()->{msg},
    );
}

##
# Pushes the decree document out to the client to download.
#
# @param {Object} self - The object instance of the class.
#
sub get_decree($self) {
    if (!$self->is_user_authenticated()) {
        return $self->redirect_to("/login");
    }

    my $id = $self->param("id") || _EMPTY_STRING;

    my $studying_form = substr($id, 12, 5);
    my $contract_type = substr($id, 36   );

    my $session_key = $self->app()->defaults("session_key");

    my $sess_key_2  = substr($session_key,  4, 12);
    my $sess_key_3  = substr($session_key, 17, 19);

    $/ = "$sess_key_2$sess_key_3"; chomp($contract_type);

    my $decree = _EMPTY_STRING;

         if ($studying_form eq STUDYING_FORM_1) {
             if ($contract_type eq CONTRACT_TYPE_1) {
            $decree             =        DECREE_11;
        } elsif ($contract_type eq CONTRACT_TYPE_2) {
            $decree             =        DECREE_12;
        } else {
            return $self->reply()->not_found();
        }
    } elsif ($studying_form eq STUDYING_FORM_2) {
             if ($contract_type eq CONTRACT_TYPE_1) {
            $decree             =        DECREE_21;
        } elsif ($contract_type eq CONTRACT_TYPE_2) {
            $decree             =        DECREE_22;
        } else {
            return $self->reply()->not_found();
        }
    } elsif ($studying_form eq STUDYING_FORM_3) {
             if ($contract_type eq CONTRACT_TYPE_2) {
            $decree             =        DECREE_32;
        } else {
            return $self->reply()->not_found();
        }
    } else {
        return $self->reply()->not_found();
    }

#   $self->res()->headers()->content_disposition("attachment; filename=\"$decree\"");
    $self->res()->headers()->content_disposition("inline");

    $self->reply()->file($self->app()->home()->child("decree", $decree));
}

1;

# vim:set nu et ts=4 sw=4:
