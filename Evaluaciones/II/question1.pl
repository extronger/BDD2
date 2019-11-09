--DIEGO INOSTROZA
CREATE OR REPLACE FUNCTION fechaCercana
RETURN NUMBER IS
CURSOR misAmigos IS SELECT * FROM AMIGOS WHERE fnac BETWEEN '31-12-1999' AND '31-12-1999'
elAmigo amigos%ROWTYPE;
edadAmigo NUMBER;
idAmigoMinimo NUMBER;
fechaCercana DATE;
fechaCercana2 DATE;

BEGIN
	fechaCercana := '31-12-1999';
	fechaCercana := '01-12-1999';
	FOR elAmigo IN misAmigos LOOP
	  IF elAmigo.fnac < fechaCercana and elAmigo.fnac > fechaCercana2 THEN
	  	idAmigoMinimo := elAmigo.id;
	  	fechaCercana2 := elAmigo.fnac;
	  END IF;
	 END LOOP;
	 RETURN idAmigoMinimo;
END fechaCercana;
