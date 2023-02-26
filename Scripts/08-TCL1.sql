set @@autocommit = 0;
set sql_safe_updates = 0;
select @@autocommit;

select * from cobertura;

start transaction;
delete
from cobertura
where id_cobertura = 4;
-- rollback;
-- commit;

-- insert into Cobertura values
-- (1, 'OSDE', 1),
-- (2, 'OMINT', 1),
-- (3, 'GALENO', 2),
-- (4, 'SWISS MEDICAL', 1),
-- (5, 'OSPOCE', 2),
-- (6, 'MEDICUS', 2)
-- ;

