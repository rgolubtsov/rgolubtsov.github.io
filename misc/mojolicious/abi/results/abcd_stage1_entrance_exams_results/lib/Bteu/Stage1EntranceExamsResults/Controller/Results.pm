#
# lib/Bteu/Stage1EntranceExamsResults/Controller/Results.pm
# =============================================================================
# Stage 1 Entrance Exams Results.
# Результаты вступительных испытаний.
# =============================================================================
# Written by Radislav (Radicchio) Golubtsov, 2021-2023
#

package Bteu::Stage1EntranceExamsResults::Controller::Results;

use Mojo::Base "Mojolicious::Controller", -signatures;

# Helper constants.
use constant _EMPTY_STRING => "";

use constant {
    STUDYING_FORM_1 => "очная",
    STUDYING_FORM_2 => "заочн",
};

use constant {
    SUBJECT_1 => "экономикаорганизации",
    SUBJECT_2 => "основыменеджмента",
    SUBJECT_3 => "охранатрудаохранаокружающейсредыиэнергосбережение",
    SUBJECT_4 => "общаятеорияправа",
    SUBJECT_5 => "основыинформационныхтехнологий",
    SUBJECT_6 => "бухгалтерскийучёт",
    SUBJECT_7 => "гражданскоеправо",
    SUBJECT_8 => "основыменеджментаиинформационныхтехнологий",
};

use constant {
    RESULTS_11 => "rezultaty-ochnaya-forma-eko-org.pdf",
    RESULTS_12 => "rezultaty-ochnaya-forma-osn-men.pdf",
    RESULTS_13 => "rezultaty-ochnaya-forma-ohr-tru.pdf",
    RESULTS_14 => "rezultaty-ochnaya-forma-obs-teo-pra.pdf",
    RESULTS_15 => "rezultaty-ochnaya-forma-osn-inf.pdf",
    RESULTS_16 => "rezultaty-ochnaya-forma-buh-uch.pdf",
    RESULTS_17 => "rezultaty-ochnaya-forma-gra-pra.pdf",
    RESULTS_18 => "rezultaty-ochnaya-forma-osn-men-inf.pdf",
# -----------------------------------------------------------------------------
    RESULTS_21 => "rezultaty-zaochnaya-forma-eko-org.pdf",
    RESULTS_22 => "rezultaty-zaochnaya-forma-osn-men.pdf",
    RESULTS_23 => "rezultaty-zaochnaya-forma-ohr-tru.pdf",
    RESULTS_24 => "rezultaty-zaochnaya-forma-obs-teo-pra.pdf",
    RESULTS_25 => "rezultaty-zaochnaya-forma-osn-inf.pdf",
    RESULTS_26 => "rezultaty-zaochnaya-forma-buh-uch.pdf",
    RESULTS_27 => "rezultaty-zaochnaya-forma-gra-pra.pdf",
    RESULTS_28 => "rezultaty-zaochnaya-forma-osn-men-inf.pdf",
};

##
# Renders the results page.
#
# @param {Object} self - The object instance of the class.
#
sub go_results($self) {
    if (!$self->is_user_authenticated()) {
        return $self->redirect_to("/login");
    }

    $self->render(
        template => "results",
        title1   => "Результаты вступительных испытаний",
        msg      => $self->session()->{msg},
    );
}

##
# Pushes the results document out to the client to download.
#
# @param {Object} self - The object instance of the class.
#
sub get_results($self) {
    if (!$self->is_user_authenticated()) {
        return $self->redirect_to("/login");
    }

    my $id = $self->param("id") || _EMPTY_STRING;

    my $studying_form = substr($id, 12, 5);
    my $subject       = substr($id, 36   );

    my $session_key = $self->app()->defaults("session_key");

    my $sess_key_2  = substr($session_key,  4, 12);
    my $sess_key_3  = substr($session_key, 17, 19);

    $/ = "$sess_key_2$sess_key_3"; chomp($subject);

    my $results = _EMPTY_STRING;

         if ($studying_form eq STUDYING_FORM_1) {
             if ($subject eq SUBJECT_1) {
            $results      = RESULTS_11;
        } elsif ($subject eq SUBJECT_2) {
            $results      = RESULTS_12;
        } elsif ($subject eq SUBJECT_3) {
            $results      = RESULTS_13;
        } elsif ($subject eq SUBJECT_4) {
            $results      = RESULTS_14;
        } elsif ($subject eq SUBJECT_5) {
            $results      = RESULTS_15;
        } elsif ($subject eq SUBJECT_6) {
            $results      = RESULTS_16;
        } elsif ($subject eq SUBJECT_7) {
            $results      = RESULTS_17;
        } elsif ($subject eq SUBJECT_8) {
            $results      = RESULTS_18;
        } else {
            return $self->reply()->not_found();
        }
    } elsif ($studying_form eq STUDYING_FORM_2) {
             if ($subject eq SUBJECT_1) {
            $results      = RESULTS_21;
        } elsif ($subject eq SUBJECT_2) {
            $results      = RESULTS_22;
        } elsif ($subject eq SUBJECT_3) {
            $results      = RESULTS_23;
        } elsif ($subject eq SUBJECT_4) {
            $results      = RESULTS_24;
        } elsif ($subject eq SUBJECT_5) {
            $results      = RESULTS_25;
        } elsif ($subject eq SUBJECT_6) {
            $results      = RESULTS_26;
        } elsif ($subject eq SUBJECT_7) {
            $results      = RESULTS_27;
        } elsif ($subject eq SUBJECT_8) {
            $results      = RESULTS_28;
        } else {
            return $self->reply()->not_found();
        }
    } else {
        return $self->reply()->not_found();
    }

#   $self->res()->headers()->content_disposition("attachment; filename=\"$results\"");
    $self->res()->headers()->content_disposition("inline");

    $self->reply()->file($self->app()->home()->child("results", $results));
}

1;

# vim:set nu et ts=4 sw=4:
