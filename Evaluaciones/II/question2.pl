--DIEGOINOSTROZA
CREATE OR REPLACE PROCEDURE question2 IS
padreAmigo amigos%ROWTYPE;
madreAmigo amigos%ROWTYPE;
elAmigo amigos%ROWTYPE;
elCasamiento amigos%ROWTYPE;
CURSOR misAmigos IS SELECT * FROM AMIGOS;
CURSOR misCasados IS SELECT * FROM CASADOS;
flag NUMBER := 0;
BEGIN
	FOR elAmigo IN misAmigos LOOP
	 flag := 0;
	
	 FOR elCasamiento IN misCasados LOOP

	  IF (elAmigo.idPadre IS NOT NULL) and (elAmigo.idPadre = elCasamiento.idh) THEN
		  flag := 1;
		  SELECT * INTO padreAmigo FROM AMIGOS  WHERE ID = elAmigo.idPadre;
		  dbms_output.put_line('Nombre: ' || elAmigo.Nombre || ' telefono' || elAmigo.cel || ' fecha de nacimiento ' || elAmigo.fnac || ' sexo ' || elAmigo.sexo);
		  dbms_output.put_line('Nombre padre: ' || padreAmigo.nombre);
		  IF elAmigo.idMadre is not null THEN
		  	  SELECT * INTO madreAmigo FROM AMIGOS WHERE ID = elAmigo.idMadre;
		  	  dbms_output.put_line('Nombre madre: ' || madreAmigo.nombre);
		  ELSE
		   dbms_output.put_line('Nombre madre: ' || 'no existe informacion de la madre');
		  END IF;
	  END IF;


	  IF flag = 0 THEN
	   IF (elAmigo.idMadre IS NOT NULL) and (elAmigo.idMadre = elCasamiento.idh) THEN
	   flag := 1;
	   dbms_output.put_line('Nombre: ' || elAmigo.Nombre || ' telefono' || elAmigo.ceL || ' fecha de nacimiento ' || elAmigo.fnac || ' sexo ' || elAmigo.sexo);
	   dbms_output.put_line('Nombre madre: ' || madreAmigo.nombre);
	   SELECT * INTO madreAmigo  FROM AMIGOS WHERE ID = elAmigo.idMadre;
	    IF elAmigo.idPadre is not null THEN
	  	  SELECT * INTO padreAmigo  FROM AMIGOS  WHERE ID = elAmigo.idPadre;
	  	  dbms_output.put_line('Nombre padre: ' || padreAmigo.nombre);
	  	ELSE
	  	 dbms_output.put_line('Nombre padre: ' || 'no existe informacion del padre');
	 	 END IF;
	  END IF;
	  END IF;
	 END LOOP;
	END LOOP;
END;