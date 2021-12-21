--
-- populate-table-1-abcd_stage1_admission_decree_extra.sql
-- ============================================================================
-- Stage 1 Admission Decree.
-- Приказ о зачислении на I ступень.
-- ============================================================================
-- Written by Radislav (Radicchio) Golubtsov, 2021
--

insert into abcd_stage1_admission_decree_contract_types (contract_type_name) values ('за счет средств организаций потребительской кооперации');
insert into abcd_stage1_admission_decree_contract_types (contract_type_name) values ('индивидуальный договор');

-- vim:set nu et ts=4 sw=4:
