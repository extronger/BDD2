----Definicion del paquete-----------------
-------------------------------------------
CREATE OR REPLACE PACKAGE RectangleTools IS
dx NUMBER;
dy NUMBER;
CURSOR elRec(elId rectangulo.rid%type) IS SELECT * FROM RECTANGULO WHERE rID = elId;
CURSOR elPunto(elPID punto.PID%type) IS SELECT * FROM PUNTOS WHERE elPID = PID;
--function calculate area
FUNCTION area(elrid INTEGER)
RETURN NUMBER;
--functino perimetro
FUNCTION perimetro(elrid INTEGER)
RETURN NUMBER;
--function si un punto esta dentro de un rectangulo
FUNCTION puntoEnRectangulo(x NUMBER, y NUMBER, elRid INTEGER)
RETURN INTEGER;
--iguales
FUNCTION iguales(x NUMBER, y NUMBER, IDP INTEGER)
RETURN INTEGER;
--distancia
FUNCTION distancia(x NUMBER, y NUMBER, IDP INTEGER)
RETURN NUMBER;
--enCirculo
FUNCTION enCirculo(x NUMBER, y NUMBER, r NUMBER, IDP INTEGER)
RETURN INTEGER;
END RectangleTools;
/
------ Cuerpo de las funciones-------------------
------------------------------------------------
CREATE OR REPLACE PACKAGE BODY RectangleTools IS
--el area
FUNCTION area(elRid INTEGER)
RETURN NUMBER IS
rectangulo rectangulo%ROWTYPE;
BEGIN
OPEN elRec(elRid);
FETCH elRec INTO rectangulo;
dx := rectangulo.XH - rectangulo.XL;
dy := rectangulo.YH - rectangulo.YL;
CLOSE elRec;
RETURN (dx*dy);
END area;
--el perimetro
FUNCTION perimetro(elRid INTEGER)
RETURN NUMBER
rectangulo rectangulo%ROWTYPE;
BEGIN
OPEN elRec(elRid);
FETCH elRec INTO rectangulo;
dx := rectangulo.XH - rectangulo.YL;
dy := rectangulo.YH - rectangulo.YL;
CLOSE elRec;
RETURN (2*(dx + dy));
END perimetro
--punto dentro de un rectangulo
FUNCTION puntoEnRectangulo(x NUMBER, y NUMBER, elRid INTEGER)
RETURN INTEGER IS
rectangulo rectangulo%ROWTYPE;
flag INTEGER;
BEGIN
OPEN elRec(elRid);
FETCH elRec INTO rectangulo;
flag := 0;
IF( x >= rectangulo.XL and x <= rectangulo.XH and y >= rectangulo.YL and y <= rectangulo.YH) THEN
 flag := 1;
END IF;
CLOSE elRec;
RETURN flag
END puntoEnRectangulo;
--
FUNCTION iguales(x NUMBER, y NUMBER, IDP INTEGER)
RETURN INTEGER IS
sonIguales INTEGER;
punto puntos%ROWTYPE;
BEGIN
OPEN elPunto(IDP);
FETCH elPunto INTO punto;
 IF punto.X = x AND punto.Y = y THEN
  sonIguales := 1;
 ELSE
  sonIguales := 0;
 END IF;
 CLOSE punto;
 RETURN sonIguales;
--
FUNCTION distancia(x NUMBER, y NUMBER, IDP INTEGER)
RETURN NUMBER IS
distancia NUMBER;
punto puntos%ROWTYPE;
BEGIN
    OPEN elPunto(IDP);
    FETCH elPunto INTO elPuntito;
    distancia := SQRT((elPuntito.X-x)**2+(elPuntito.Y-y)**2);
    CLOSE elPunto;
    RETURN distancia;
END distancia;
--
FUNCTION enCirculo(x NUMBER, y NUMBER, r NUMBER, IDP INTEGER)
RETURN INTEGER IS
distancia NUMBER;
flag INTEGER;
elPuntito puntos%ROWTYPE;
BEGIN
    OPEN elPunto(IDP);
    FETCH elPunto INTO elPuntito;
    distancia := SQRT((elPuntito.X-x)**2+(elPuntito.Y-y)**2);
    IF distancia < r THEN
    flag := 1;
    ELSE
    flag := 0;
    END IF;
    CLOSE elPunto;
    RETURN flag;
END enCirculo;
END RectangleTools;
/