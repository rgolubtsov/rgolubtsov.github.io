--
-- create---table---bteu_stage1_entrance_exams_results_-all-.sql
-- ============================================================================
-- Stage 1 Entrance Exams Results.
-- Результаты вступительных испытаний.
-- ============================================================================
-- Written by Radislav (Radicchio) Golubtsov, 2021
--

create table bteu_stage1_entrance_exams_results_subjects       (
    id           smallserial primary key,
    subject_name character   varying(60) not null
);

create table bteu_stage1_entrance_exams_results_studying_forms (
    id                 smallserial primary key,
    studying_form_name character   varying(60) not null
);

create table bteu_stage1_entrance_exams_results_exams_dates    (
    id        smallserial primary key,
    exam_date date        not null
);

create table bteu_stage1_entrance_exams_results_users          (
    id               smallserial primary key,
    username         character   varying(30) not null,
    given_name       character   varying(30) not null,
    password         character   varying(7)  not null,
    studying_form_id smallint                not null references bteu_stage1_entrance_exams_results_studying_forms(id) on delete restrict,
    subject1_id      smallint                not null references bteu_stage1_entrance_exams_results_subjects(id)       on delete restrict,
    date1_id         smallint                not null references bteu_stage1_entrance_exams_results_exams_dates(id)    on delete restrict,
    subject2_id      smallint                not null references bteu_stage1_entrance_exams_results_subjects(id)       on delete restrict,
    date2_id         smallint                not null references bteu_stage1_entrance_exams_results_exams_dates(id)    on delete restrict
);

-- vim:set nu et ts=4 sw=4:
