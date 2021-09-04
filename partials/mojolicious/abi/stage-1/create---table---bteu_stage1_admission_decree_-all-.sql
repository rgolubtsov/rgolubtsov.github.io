--
-- create---table---bteu_stage1_admission_decree_-all-.sql
-- ============================================================================
-- Stage 1 Admission Decree.
-- Приказ о зачислении на I ступень.
-- ============================================================================
-- Written by Radislav (Radicchio) Golubtsov, 2021
--

create table bteu_stage1_admission_decree_contract_types (
    id                 smallserial primary key,
    contract_type_name character   varying(60) not null
);

create table bteu_stage1_admission_decree_users          (
    id               smallserial primary key,
    username         character   varying(30) not null,
    given_name       character   varying(30) not null,
    password         character   varying(7)  not null,
    studying_form_id smallint                not null references bteu_stage1_entrance_exams_results_studying_forms(id) on delete restrict,

    contract_type_id smallint                not null references bteu_stage1_admission_decree_contract_types(id)       on delete restrict
);

-- vim:set nu et ts=4 sw=4:
