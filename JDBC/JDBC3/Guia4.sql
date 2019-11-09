--funciones para el ejercicio 1
--==========================================================================
--Padres:
--id1 = idAmigo, id2 = idSecuencial
create or replace FUNCTION padres(id1 INTEGER, id2 INTEGER) RETURN INT AS
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
--==========================================================================
--Abuelos:
--id2 es que se corrobora si es mi abuelo no
--==========================================================================
create or replace FUNCTION abuelos(id1 INTEGER, id2 INTEGER) RETURN INT AS
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
--==========================================================================
--Hijos:
--Se usa la funcion de padres con la modificacion de que el id1: idHijoPosible
--y en id2: va mi idAmigo
--==========================================================================
--Hermanos
create or replace FUNCTION hermanos(id1 INTEGER, id2 INTEGER) RETURN INT AS
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
--==========================================================================
--Tios
create or replace FUNCTION tios(id1 INTEGER, id2 INTEGER) RETURN INT AS
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
--==========================================================================
--Primos
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
    IF (hermanos(madre_1,madre_2) = 1) THEN flag := 1; END IF;
    IF  (hermanos(madre_1,padre_2) = 1) THEN flag := 1; END IF;
    IF (hermanos(padre_1,madre_2)) = 1 THEN flag := 1; END IF;
    IF (hermanos(padre_1,padre_2)) = 1 THEN flag := 1; END IF;
  RETURN flag;
END primos;
--==========================================================================