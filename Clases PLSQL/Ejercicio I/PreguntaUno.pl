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
	CURSOR amigosCursor IS SELECT * FROM amigos;
	CURSOR casadosCursor IS SELECT * FROM casados;
    CURSOR buscarAmigo(idAmigo amigos.id%TYPE) IS SELECT nombre FROM amigos WHERE idAmigo = ID;
    miAmigo amigos.id%TYPE;
    elNombreAmigo VARCHAR2(20);
	amigo amigos%ROWTYPE;
	casado casados%ROWTYPE;
	numeroUno NUMBER;
	numeroDos NUMBER;
BEGIN
	numeroUno:=0;
	numeroDos:=0;
	FOR amigo IN amigosCursor LOOP
        numeroDos := 0;
		FOR casado in casadosCursor LOOP
		 IF (amigo.ID = casado.idH) or ((amigo.ID = casado.idM))THEN
		 numeroDos :=  numeroDos + 1;
		 END IF;
		END LOOP;
	 IF numeroDos > numeroUno THEN
	  numeroUno := numeroDos;
      miAmigo := amigo.ID;
	 END IF;
	END LOOP;
    OPEN buscarAmigo(miAmigo);
    FETCH buscarAmigo into elNombreAmigo;
    CLOSE buscarAmigo;
    dbms_output.put_line('Mi amigo: ' || elNombreAmigo || ' se caso ' || numeroUno || ' veces');
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
	idMujer NUMBER:=0;
    elNombreM VARCHAR2(30);
    elNombreH VARCHAR2(30);
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
    OPEN buscarAmigo(idHombre);
    FETCH buscarAmigo into elNombreM;
    dbms_output.put_line('Nombre del amigo: ' || elNombreM);
    CLOSE buscarAmigo;
    OPEN buscarAmigo(idMujer);
    FETCH buscarAmigo into elNombreH;
    dbms_output.put_line('Nombre de la mujer: ' || elNombreH);
    CLOSE buscarAmigo;    
END;

SET SERVEROUT ON;
DECLARE
	CURSOR amigos IS SELECT * FROM amigos WHERE sexo='M';
	CURSOR casados IS SELECT * FROM casados;
	elAmigo amigos%ROWTYPE;
	matrimonio casados%ROWTYPE;
	flag boolean;
BEGIN
	FOR elAmigo IN amigos LOOP
		flag := true;
		FOR matrimonio IN casados LOOP
		 IF elAmigo.id = matrimonio.idH THEN
		  flag := false;
		 END IF;
		 END LOOP;
		IF flag THEN
		 dbms_output.put_line('Amigo que nunca se ha casado: ' || elAmigo.nombre);
		END IF;
	END LOOP;
END;


set serverout on;
DECLARE
	CURSOR casados IS SELECT * FROM casados;
    CURSOR buscarAmigo(idAmigo amigos.id%TYPE) IS SELECT nombre FROM amigos WHERE idAmigo = ID;
	matrimonio casados%ROWTYPE;
	nowDate DATE;
	aniosCasados NUMBER;
    elNombreM VARCHAR2(30);
    elNombreH VARCHAR2(30);
BEGIN
	SELECT SYSDATE INTO nowDate FROM DUAL;
	FOR matrimonio IN casados LOOP
	 IF matrimonio.fechaSep is NULL THEN
      dbms_output.put_line('Matrimonio Vigente: ');
       OPEN buscarAmigo(matrimonio.idH);
       FETCH buscarAmigo into elNombreM;
       dbms_output.put_line('Nombre del amigo: ' || elNombreM);
       CLOSE buscarAmigo;
        OPEN buscarAmigo(matrimonio.idM);
        FETCH buscarAmigo into elNombreH;
        dbms_output.put_line('Nombre de la amiga: ' || elNombreH);
        CLOSE buscarAmigo;
	  dbms_output.put_line('Duracion: ' || (nowDate-matrimonio.fechaCas)/365);
	 ELSE
      dbms_output.put_line('Matrimonio No Vigente: ');
      OPEN buscarAmigo(matrimonio.idH);
       FETCH buscarAmigo into elNombreM;
       dbms_output.put_line('Nombre del amigo: ' || elNombreM);
       CLOSE buscarAmigo;
        OPEN buscarAmigo(matrimonio.idM);
        FETCH buscarAmigo into elNombreH;
        dbms_output.put_line('Nombre de la amiga: ' || elNombreH);
        CLOSE buscarAmigo;
	  dbms_output.put_line((matrimonio.fechaSep-matrimonio.fechaCas)/365);
	 END IF;
	END LOOP;
END;