--
-- create---table-abcd_magistracy_admission_decree_users.sql
-- ============================================================================
-- Magistracy Admission Decree - Users Realm.
-- Приказ о зачислении в магистратуру.
-- ============================================================================
-- Written by Radislav (Radicchio) Golubtsov, 2021-2024
--

create table abcd_magistracy_admission_decree_users (id            smallserial primary key,
                                                     username      character   varying(30) not null,
                                                     given_name    character   varying(30) not null,
                                                     password      character   varying(7)  not null,
                                                     studying_form smallint);

-- vim:set nu et ts=4 sw=4:
