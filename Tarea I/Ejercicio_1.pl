create or replace PROCEDURE rango(x1 IN INTEGER,y1 IN INTEGER,x2 IN INTEGER,y2 IN INTEGER) AS
CURSOR los_tipos IS SELECT * FROM tipositios;
CURSOR los_sitios IS SELECT * FROM sitios;
el_tipo tipositios%ROWTYPE;
el_sitio sitios%ROWTYPE;
contador NUMBER := 0; 
BEGIN 
    IF x1 < x2 THEN 
        IF y1 < y2 THEN

            FOR el_tipo IN los_tipos LOOP
                FOR el_sitio IN los_sitios LOOP
                    IF el_tipo.idtipo = el_sitio.tipositio THEN 
                        IF el_sitio.coorx > x1 THEN
                            IF el_sitio.coorx < x2 THEN
                                IF el_sitio.coory > y1 THEN
                                    IF el_sitio.coory < y2 THEN
                                        contador := contador + 1;
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END LOOP;

                DBMS_OUTPUT.put_line(el_tipo.nombretipo || ' contiene: '|| contador || ' sitios.');
                contador := 0;

            END LOOP;
        ELSE 
            FOR el_tipo IN los_tipos LOOP
                FOR el_sitio IN los_sitios LOOP
                    IF el_tipo.idtipo = el_sitio.tipositio THEN 
                        IF el_sitio.coorx >= x1 THEN
                            IF el_sitio.coorx <= x2 THEN
                                IF el_sitio.coory <= y1 THEN
                                    IF el_sitio.coory >= y2 THEN
                                        contador := contador + 1; 
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END LOOP;

                DBMS_OUTPUT.put_line(el_tipo.nombretipo || ' contiene: '|| contador || ' sitios.');
                contador := 0;

            END LOOP;
        END IF;
    ELSE 
        IF y1 < y2 THEN
            FOR el_tipo IN los_tipos LOOP
                FOR el_sitio IN los_sitios LOOP
                    IF el_tipo.idtipo = el_sitio.tipositio THEN
                        IF el_sitio.coorx <= x1 THEN
                            IF el_sitio.coorx >= x2 THEN
                                IF el_sitio.coory >= y1 THEN
                                    IF el_sitio.coory <= y2 THEN
                                        contador := contador + 1;
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END LOOP;
                
                DBMS_OUTPUT.put_line(el_tipo.nombretipo || ' contiene: '|| contador || ' sitios.');
                contador := 0;
            END LOOP;
        ELSE
            FOR el_tipo IN los_tipos LOOP
                FOR el_sitio IN los_sitios LOOP
                    IF el_tipo.idtipo = el_sitio.tipositio THEN
                        IF el_sitio.coorx <= x1 THEN
                            IF el_sitio.coorx >= x2 THEN
                                IF el_sitio.coory <= y1 THEN
                                    IF el_sitio.coory >= y2 THEN
                                        contador := contador + 1;
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END LOOP;

                DBMS_OUTPUT.put_line(el_tipo.nombretipo || ' contiene: '|| contador || ' sitios.');
                contador := 0;

            END LOOP;
        END IF;
    END IF;
END rango;