--1
CREATE TABLE notificaiones(idH INTEGER,
						   idM INTEGER,
						   obs VARCHAR(30));
--a)
CREATE OR REPLACE TRIGGER noviosMenores
BEFORE INSERT ON casados
FOR EACH ROW
DECLARE
obs VARCHAR(30);
fechaHombre amigos.fnac%TYPE;
fechaMujer amigos.fnac%TYPE;
fechaActual DATE;
edadHombre INTEGER;
edadMujer INTEGER;
BEGIN
    SELECT fnac INTO fechaHombre FROM AMIGOS WHERE id = :NEW.idH;
    SELECT fnac INTO fechaMujer FROM AMIGOS WHERE id = :NEW.idM;
    SELECT SYSDATE INTO fechaActual FROM DUAL;
    edadHombre := (fechaActual - fechaHombre) / 365;
    edadMujer := (fechaActual - fechaMujer) / 365;
    IF INSERTING THEN
        IF edadHombre < 18 THEN
            obs := 'El novio es menor de edad';
        ELSIF edadMujer < 16 THEN
            obs := 'La novia es menor de edad';
        END IF;
    END IF;
    INSERT INTO NOTIFICACIONES VALUES (:NEW.idH, :NEW.idM, obs);
END;
--2
CREATE OR REPLACE TRIGGER noviosMenores2
BEFORE INSERT ON casados
FOR EACH ROW
DECLARE
fechaHombre amigos.fnac%TYPE;
fechaMujer amigos.fnac%TYPE;
fechaActual DATE;
edadHombre INTEGER;
edadMujer INTEGER;
BEGIN
    SELECT fnac INTO fechaHombre FROM AMIGOS WHERE id = :NEW.idH;
    SELECT fnac INTO fechaMujer FROM AMIGOS WHERE id = :NEW.idM;
    SELECT SYSDATE INTO fechaActual FROM DUAL;
    edadHombre := (fechaActual - fechaHombre) / 365; --ARREGLAR ESTO, ES LA EDAD QUE TENGA EN EL CASAMIENTO
    edadMujer := (fechaActual - fechaMujer) / 365;
    IF INSERTING THEN
        IF edadHombre < 18 THEN
            raise_application_error(-20000,  'El novio es menor de edad');
        ELSIF edadMujer < 16 THEN   
            raise_application_error(-20001,  'La novia es menor de edad');
        END IF;
    END IF;
END;

insert into casados values (1059, 1063, date '2019-01-01', null);
commit;
--pdf 2 triigers lab3
--a
--tabla
CREATE OR REPLACE TRIGGER duracion
BEFORE UPDATE ON casados
FOR EACH ROW 
WHEN (OLD.fechaSep IS NULL)
DECLARE
duracion INTEGER;
BEGIN
    duracion := (:NEW.fechaSep - :OLD.fechaCas)/365;
    INSERT INTO SEPARACION VALUES (:OLD.idH, :OLD.idM, duracion);
END;
--
UPDATE casados set fechasep = date '2000-01-01' WHERE idH = 1051 and idM = 1056;
commit;
--
ALTER TABLE AMIGOS
ADD (idMadre INTEGER,
     idPadre INTEGER,
FOREIGN KEY (idMadre) REFERENCES AMIGOS(ID),
FOREIGN KEY (idPadre) REFERENCES AMIGOS(ID));
commit;
--
DECLARE
padreHombre amigos%ROWTYPE;
madreHombre amigos%ROWTYPE;
padreMujer amigos%ROWTYPE;
madreMujer amigos%ROWTYPE;
idH INTEGER :=1051;
idM INTEGER :=1063;
hombre amigos%ROWTYPE;
mujer amigos%ROWTYPE;
BEGIN
SELECT * INTO hombre FROM AMIGOS WHERE ID = idH;
SELECT * INTO mujer FROM AMIGOS WHERE ID = idM;
SELECT * INTO padreHombre FROM AMIGOS WHERE ID = hombre.idPadre;
SELECT * INTO padreMujer FROM AMIGOS WHERE ID = mujer.idPadre;
DBMS_OUTPUT.PUT_LINE(padreHombre.idPadre);
DBMS_OUTPUT.PUT_LINE(padreMujer.idPadre);
END;
--
CREATE OR REPLACE TRIGGER primos
BEFORE INSERT ON CASADOS
FOR EACH ROW 
DECLARE
padreHombre amigos%ROWTYPE;
madreHombre amigos%ROWTYPE;
padreMujer amigos%ROWTYPE;
madreMujer amigos%ROWTYPE;
hombre amigos%ROWTYPE;
mujer amigos%ROWTYPE;
--idH INTEGER :=1051;
--idM INTEGER :=1063;
BEGIN
SELECT * INTO hombre FROM AMIGOS WHERE ID = :NEW.idH;
SELECT * INTO mujer FROM AMIGOS WHERE ID = :NEW.idM;
SELECT * INTO padreHombre FROM AMIGOS WHERE ID = hombre.idPadre;
SELECT * INTO padreMujer FROM AMIGOS WHERE ID = mujer.idPadre;
    IF (padreHombre.idPadre = padreMujer.idPadre or padreHombre.idMadre = padreMujer.idMadre) 
    OR (padreHombre.idPadre = madreMujer.idPadre or padreHombre.idMadre = madreMujer.idMadre) 
    OR (madreHombre.idPadre = padreMujer.idPadre or madreHombre.idMadre = padreMujer.idMadre) 
    OR (madreHombre.idPadre = madreMujer.idPadre or madreHombre.idMadre = madreMujer.idMadre) THEN
        raise_application_error(-20000,  'Sus padres son hermanos');
    ELSE
        raise_application_error(-20001,  'Se pueden casar');
    END IF;
END;
--primos martita
--==================================================================
CREATE OR REPLACE FUNCTION tios(id1 INTEGER, id2 INTEGER) RETURN INT AS
  padre_1 INTEGER;
  madre_1 INTEGER;
  flag INTEGER := 0;
  BEGIN
  IF(id1 IS NULL OR id2 = NULL) THEN
     flag := 0;
  END IF;
  SELECT idMadre, idPadre INTO madre_1, padre_1 FROM amigos WHERE id = id1;
  IF hermanos(padre_1,id2) = 1 OR hermanos(madre_1, id2) = 1 THEN
  flag := 1;
  END IF;
  RETURN flag;
END tios;
--==================================================================
CREATE OR REPLACE FUNCTION abuelos(id1 INTEGER, id2 INTEGER) RETURN INT AS
  padre_1 INTEGER;
  madre_1 INTEGER;
  flag INTEGER := 0;
BEGIN
  IF(id1 IS NULL OR id2 = NULL) THEN
     flag := 0;
  END IF;
-- Se obtienen los padres de la pareja
  SELECT idMadre, idPadre INTO madre_1, padre_1 FROM amigos WHERE id = id1;
  IF padres(padre_1, id2) = 1 OR padres(madre_1, id2) = 1 THEN
   flag := 1;
  END IF;
  RETURN flag;
END abuelos;
--==================================================================
CREATE OR REPLACE FUNCTION padres(id1 INTEGER, id2 INTEGER) RETURN INT AS
  persona1 amigos%ROWTYPE;
  flag INTEGER := 0;
BEGIN
  IF(id1 IS NULL OR id2 = NULL) THEN
     flag := 0;
  END IF;
-- Se obtienen los padres de la pareja
  SELECT * INTO persona1 FROM amigos WHERE id = id1;
  IF persona1.idPadre = id2 OR persona1.idMadre = id2 THEN
   flag := 1;
  END IF;
  RETURN flag;
END padres;
--==================================================================
--==================================================================
-- Funcion que se encarga de definir si una pareja son hermanos
CREATE OR REPLACE FUNCTION hermanos(id1 INTEGER, id2 INTEGER) RETURN INT AS
  persona1 amigos%ROWTYPE;
  persona2 amigos%ROWTYPE;
  flag INTEGER:=0;
BEGIN
  -- Verifica si se los valores son nulos
  IF(id1 IS NULL OR id2 = NULL) THEN
     flag := 0;
  END IF;
  -- Se obtienen los padres de la pareja
  SELECT * INTO persona1 FROM amigos WHERE id = id1;
  SELECT * INTO persona2 FROM amigos WHERE id = id2;
  -- Se verifica si los padres son los mismos
  IF persona1.idMadre = persona2.idMadre OR persona1.idPadre = persona2.idPadre OR 
     persona1.idMadre = persona2.idPadre OR persona1.idPadre = persona2.idMadre THEN
     flag := 1;
  END IF;
  RETURN flag;
END;
--==================================================================
--==================================================================
-- Funcion que se encarga de definir si una pareja son primos
create or replace FUNCTION primos(id1 INTEGER, id2 INTEGER) RETURN INT AS
  padre_1 INTEGER;
  padre_2 INTEGER;
  madre_1 INTEGER;
  madre_2 INTEGER;
  flag INTEGER:=0;
BEGIN
  -- Se verifica si los valores son nulos
  IF(id1 = NULL OR id2 = NULL) THEN
    flag := 0;
  END IF;
  -- Se obtienen los padres de la pareja
  SELECT idMadre, idPadre INTO madre_1, padre_1 FROM amigos WHERE id = id1;
  SELECT idMadre, idPadre INTO madre_2, padre_2 FROM amigos WHERE id = id2;
  -- Se verifica si los padres son hermanos
    IF  (hermanos(madre_1,madre_2) = 1) OR (hermanos(madre_1,padre_2) = 1) OR
        (hermanos(padre_1,madre_2) = 1) OR (hermanos(padre_1,padre_2) = 1) THEN
         flag := 1;
    END IF;
  RETURN flag;
END primos;
--==================================================================



CREATE OR REPLACE TRIGGER sonPrimos BEFORE INSERT ON matrimonios
  FOR EACH ROW
  BEGIN
    IF(primos(:NEW.idh,:NEW.idm)) THEN
      raise_application_error(-20000, 'La pareja son primos');
    END IF;
END sonPrimos;

CREATE TABLE MATRIMONIOS(
  idh integer,
  idm integer,
  fechaCas date,
  fechaSep date,
  foreign key (idh) references amigos(id),
  foreign key (idm) references amigos(id)
);