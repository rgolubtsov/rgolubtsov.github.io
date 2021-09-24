--
-- populate-table-abcd_magistracy_admission_decree_users.sql
-- ============================================================================
-- Magistracy Admission Decree - Users Realm.
-- Приказ о зачислении в магистратуру.
-- ============================================================================
-- Written by Radislav (Radicchio) Golubtsov, 2021
--

insert into abcd_magistracy_admission_decree_users (username, given_name, password, studying_form) values ('FamilyName1', 'GivenName1', '1234567', 1);
insert into abcd_magistracy_admission_decree_users (username, given_name, password, studying_form) values ('FamilyName2', 'GivenName2', '2345678', 2);
insert into abcd_magistracy_admission_decree_users (username, given_name, password, studying_form) values ('FamilyName3', 'GivenName3', '3456789', 3);
-- .....
-- 81...

-- vim:set nu et ts=4 sw=4:
