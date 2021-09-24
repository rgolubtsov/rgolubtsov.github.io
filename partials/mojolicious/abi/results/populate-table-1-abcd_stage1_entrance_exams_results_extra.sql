--
-- populate-table-1-abcd_stage1_entrance_exams_results_extra.sql
-- ============================================================================
-- Stage 1 Entrance Exams Results.
-- Результаты вступительных испытаний.
-- ============================================================================
-- Written by Radislav (Radicchio) Golubtsov, 2021
--

insert into abcd_stage1_entrance_exams_results_subjects (subject_name) values ('Экономика организации');
insert into abcd_stage1_entrance_exams_results_subjects (subject_name) values ('Основы менеджмента');
insert into abcd_stage1_entrance_exams_results_subjects (subject_name) values ('Охрана труда. Охрана окружающей среды и энергосбережение');
insert into abcd_stage1_entrance_exams_results_subjects (subject_name) values ('Общая теория права');
insert into abcd_stage1_entrance_exams_results_subjects (subject_name) values ('Основы информационных технологий');
insert into abcd_stage1_entrance_exams_results_subjects (subject_name) values ('Бухгалтерский учёт');
insert into abcd_stage1_entrance_exams_results_subjects (subject_name) values ('Гражданское право');
insert into abcd_stage1_entrance_exams_results_subjects (subject_name) values ('Основы менеджмента и информационных технологий');

-- ----------------------------------------------------------------------------

insert into abcd_stage1_entrance_exams_results_studying_forms (studying_form_name) values ('очная (дневная) форма получения образования');
insert into abcd_stage1_entrance_exams_results_studying_forms (studying_form_name) values ('заочная форма получения образования');
insert into abcd_stage1_entrance_exams_results_studying_forms (studying_form_name) values ('второе высшее образование');

-- ----------------------------------------------------------------------------

insert into abcd_stage1_entrance_exams_results_exams_dates (exam_date) values ('2021-07-28');
insert into abcd_stage1_entrance_exams_results_exams_dates (exam_date) values ('2021-07-30');

-- vim:set nu et ts=4 sw=4:
