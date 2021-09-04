--
-- populate-table-2-bteu_stage1_admission_decree_users.sql
-- ============================================================================
-- Stage 1 Admission Decree.
-- Приказ о зачислении на I ступень.
-- ============================================================================
-- Written by Radislav (Radicchio) Golubtsov, 2021
--

insert into bteu_stage1_admission_decree_users (username, given_name, password, studying_form_id, contract_type_id) values ('FamilyName1', 'GivenName1', '1234567', 1, 2);
insert into bteu_stage1_admission_decree_users (username, given_name, password, studying_form_id, contract_type_id) values ('FamilyName2', 'GivenName2', '2345678', 1, 1);
insert into bteu_stage1_admission_decree_users (username, given_name, password, studying_form_id, contract_type_id) values ('FamilyName3', 'GivenName3', '3456789', 2, 2);
insert into bteu_stage1_admission_decree_users (username, given_name, password, studying_form_id, contract_type_id) values ('FamilyName4', 'GivenName4', '4567890', 2, 1);
insert into bteu_stage1_admission_decree_users (username, given_name, password, studying_form_id, contract_type_id) values ('FamilyName5', 'GivenName5', '5678901', 3, 2);
-- .....
-- 467..

-- vim:set nu et ts=4 sw=4:
