set @@autocommit = 0;
set sql_safe_updates = 0;
select @@autocommit;

start transaction;
insert into especialidad values 
(16, 'CIRUGIA FACIAL'),
(17, 'ODONTOLOGIA'),
(18, 'TRAUMATOLOGIA RODILLA'),
(19, 'RINOPLASTIA');
savepoint sp1;
insert into especialidad values 
(20, 'CIRUGIA CEREBRAL'),
(21, 'NEUROLOGIA INFANTIL'),
(22, 'TRAUMATOLOGIA MANO'),
(23, 'CARDIOLOGIA INFANTIL');
savepoint sp2;
-- rollback to sp1;
-- rollback;
-- commit;
-- release savepoint sp1;