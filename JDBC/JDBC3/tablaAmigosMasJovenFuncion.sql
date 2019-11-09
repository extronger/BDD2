CREATE TABLE AMIGOS(
	id INTEGER PRIMARY KEY,
	NOMBRE VARCHAR(30),
	CEL NUMBER,
	FNAC DATE,
	SEXO CHAR(1),
	idMadre INTEGER,
	idPadre INTEGER,
	FOREIGN KEY (idMadre) REFERENCES AMIGOS(ID),
	FOREIGN KEY (idPadre) REFERENCES AMIGOS(ID)
);

INSERT INTO AMIGOS VALUES (1, 'Enrique Ch', 8272727, date '1958-12-12', 'M', null, null);
INSERT INTO AMIGOS VALUES (2, 'Monica R', 7171717, date '1957-10-10', 'F', null, null);
INSERT INTO AMIGOS VALUES (3, 'Diego I', 8272722, date '1996-12-12', 'M', 1, 2);
INSERT INTO AMIGOS VALUES (4, 'Valentin C', 874587, date '1960-02-05', 'M', null, null);
INSERT INTO AMIGOS VALUES (5, 'Lorenzo C', 8272727, date '1995-12-01', 'M', 4,null);

create or replace FUNCTION masJoven 
 RETURN NUMBER IS
 dateNow DATE;
 CURSOR misAmigos IS SELECT * FROM amigos;
 elAmigo amigos%ROWTYPE;
 edadMin NUMBER:=100;
 edadAmigo NUMBER;
 elNombreAmigo VARCHAR2(100);
BEGIN
     	SELECT SYSDATE INTO dateNow FROM DUAL;
        FOR elAmigo IN misAmigos LOOP
        edadAmigo := (dateNow-elAmigo.fnac)/365 ;
         IF edadAmigo < edadMin  THEN
         edadMin := edadAmigo;
         elNombreAmigo := elAmigo.nombre;
         END IF;
        END LOOP;  
        RETURN edadAmigo;
END masJoven;

