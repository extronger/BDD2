--Packages ejercicio
--a
SELECT rectangleTools.Area(rid) as Area, rectangleTools.Perimetro(rid) as Perimetro from rectangulo;
--b
SELECT rid, rectangleTools.Area(rid) as area FROM RECTANGULO WHERE rectangleTools.Area(rid) > 4;
--c
SELECT rid from rectangulo where rectangletools.puntoenREctangulo(6,7,rid) = 1;
--d
set serverout on;
DECLARE
CURSOR misPuntos IS SELECT * FROM puntos;
CURSOR misRectangulos IS SELECT * FROM rectangulo;
miRectangulo rectangulo%ROWTYPE;
miPunto puntos%ROWTYPE;
BEGIN
	FOR miRectangulo IN misRectangulos LOOP
	 FOR miPunto IN misPuntos LOOP
	  IF rectangleTools.puntoenRectangulo(miPunto.X, miPunto.Y, miRectangulo.RID) = 1 THEN
	   DBMS_OUTPUT.PUT_LINE(miPunto.X || ' y ' || miPunto.y || ' si pertenecen al rectangulo ' || miRectangulo.RID);
	  END IF;
	 END LOOP;
	END LOOP;
END;
--e
set serverout on;
DECLARE
CURSOR misPuntos IS SELECT * FROM puntos;
CURSOR misRectangulos IS SELECT * FROM rectangulo;
miRectangulo rectangulo%ROWTYPE;
miPunto puntos%ROWTYPE;
cont INTEGER;
BEGIN
	FOR miRectangulo IN misRectangulos LOOP
	 cont := 0;
	 FOR miPunto IN misPuntos LOOP
	  IF rectangleTools.puntoenRectangulo(miPunto.X, miPunto.Y, miRectangulo.RID) = 1 THEN
	   cont := cont + 1;
	  END IF;
	 END LOOP;
	 DBMS_OUTPUT.PUT_LINE('El rectangulo: ' || miRectangulo.RID || ' contiene ' || cont || ' puntos');
	END LOOP;
END;
--d
SELECT rid, pid FROM rectangulo, puntos where rectangletools.puntoenRectangulo(puntos.X,puntos.Y, rid) = 1;
--e
SELECT rid as Rectangulo, count(*) as cantidadPuntos FROM rectangulo, puntos where rectangletools.puntoenRectangulo(puntos.X,puntos.Y, rid) = 1 GROUP BY rid;

--6.a
select MIN(rectangletools.distancia(10,10,puntos.PID)) from puntos;
	
--6.b
select pid FROM puntos WHERE rectangleTools.enCirculo(3,5, 2, puntos.PID) = 1