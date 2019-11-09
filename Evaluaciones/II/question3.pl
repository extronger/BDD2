---DIEGOINOSTROZA
CREATE OR REPLACE TRIGGER matrimoniosNulo BEFORE INSERT OR UPDATE ON CASADOS 
FOR EACH ROW
DECLARE
CURSOR casados IS SELECT * FROM CASADOS;
matrimonio casados%ROWTYPE;
contador NUMBER := 0;
BEGIN
 FOR matrimonio IN casados LOOP
  IF matrimonio.fechaSep is null THEN
   contador := contador + 1;
  END IF;
 END LOOP;
 
 IF contador <= 10 THEN
  IF INSERTING THEN
   INSERT INTO casados VALUES (:NEW.idh, :NEW.idM, :NEW.fechaCas, :NEW.fechaSep);
   ELSIF UPDATING THEN
   UPDATE CASADOS SET idh = :NEW.idh, idm = :NEW.idM, fechaCas = :NEW.fechaCas , fechaSep = :NEW.fechaSep;
  END IF;
 ELSE
 raise_application_error(-20000,  'Ya existen mas de 10 matrimonios vigentes');
 END IF;

END matrimoniosNulo;
/

create or replace TRIGGER matrimoniosVigentes
BEFORE INSERT OR UPDATE ON MATRIMONIOS
FOR EACH ROW
DECLARE
contador NUMBER:=0;
BEGIN 
 SELECT COUNT(*) INTO contador FROM MATRIMONIOS WHERE fechaSep is null;

 IF contador >= 3 THEN
  raise_application_error(-20000, 'Ya existen mas de 2 matrimonio vigente');
 END IF;
 
END matrimoniosVigentes;

insert into matrimonios values(5,7, date '2018-01-01', null);