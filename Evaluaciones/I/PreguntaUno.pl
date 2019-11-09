SET SERVEROUT ON;
DECLARE
        CURSOR casados IS SELECT * FROM	casados;
        matrimonio casados%ROWTYPE;
        matrimonioVigente NUMBER:=0;
        matrimonioNoVigente NUMBER:=0;
BEGIN
        FOR matrimonio in casados LOOP
        IF matrimonio.fechaSep is NULL THEN
        matrimonioVigente := matrimonioVigente + 1;
        ELSE
        matrimonioNoVigente := matrimonioNoVigente + 1;
        END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Matrimonios vigentes: ' || matrimonioVigente);
        DBMS_OUTPUT.PUT_LINE('Matrimonios no vigentes: ' || matrimonioNoVigente);
END;
--
set serverout on;
DECLARE
	CURSOR casados IS SELECT * FROM casados;
	matrimonio casados%ROWTYPE;
	nowDate DATE;
	aniosCasados NUMBER;
BEGIN
	SELECT SYSDATE INTO nowDate FROM DUAL;
	FOR matrimonio IN casados LOOP
	 IF matrimonio.fechaSep is NULL THEN
	  dbms_output.put_line('La duracion de este matrimonio hasta ahora es: ' || (nowDate-matrimonio.fechaCas)/365);
	 ELSE
	  dbms_output.put_line('Este matrimonio tuvo una duracion de: ' || (matrimonio.fechaSep-matrimonio.fechaCas)/365);
	 END IF;
	END LOOP;
END;
--
set serverout on;
DECLARE
	CURSOR amigos IS SELECT * FROM amigos;
	CURSOR casados IS SELECT * FROM casados;
	amigo amigos%ROWTYPE;
	casado casados%ROWTYPE;
	numeroUno NUMBER;
	numeroDos NUMBER;
BEGIN
	numeroUno:=0;
	numeroDos:=0;
	FOR amigo IN amigos LOOP
        numeroDos := 0;
		FOR casado in casados LOOP
		 IF (amigo.ID = casado.idH) or ((amigo.ID = casado.idM))THEN
		 numeroDos :=  numeroDos + 1;
		 END IF;
		END LOOP;
	 IF numeroDos > numeroUno THEN
	  numeroUno := numeroDos;
	 END IF;
	END LOOP;
	dbms_output.put_line(numeroUno);
END;


--test pregunta II

set serverout on;
DECLARE
	CURSOR casados IS SELECT * FROM casados;
	CURSOR buscarAmigo(idAmigo amigos.id%TYPE) IS SELECT nombre FROM amigos WHERE idAmigo = ID;
	matrimonio casados%ROWTYPE;
	nowDate DATE;
	aniosCasados NUMBER;
    maximo NUMBER:=0;
    idHombre NUMBER:=0;
	idHMujer NUMBER:=0;
BEGIN
	SELECT SYSDATE INTO nowDate FROM DUAL;
	FOR matrimonio IN casados LOOP
     aniosCasados := 0;
	 IF matrimonio.fechaSep is NULL THEN
	 aniosCasados := (nowDate-matrimonio.fechaCas)/365;
	 ELSE
	  aniosCasados := (matrimonio.fechaSep-matrimonio.fechaCas)/365;
	 END IF;
    IF aniosCasados > maximo THEN
    maximo := aniosCasados;
      idHombre := matrimonio.idH;
	  idMujer := matrimonio.idM;
    END IF;
	END LOOP;
    dbms_output.put_line(maximo);
END;