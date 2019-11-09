create or replace PROCEDURE masCercanos(a IN INTEGER, b IN INTEGER) AS

CURSOR sitios_a IS SELECT * FROM sitios WHERE tipositio = a; --almacenamos los sitios que tengan la key foranea a
CURSOR sitios_b IS SELECT * FROM sitios WHERE tipositio = b; --almacenamos los sitios que tengan la key foreanea b
CURSOR tipo_sitio_a IS SELECT * FROM tipositios WHERE idtipo = a; --almacenamos el tipo de sitio que tenga key igual a
CURSOR tipo_sitio_b IS SELECT * FROM tipositios WHERE idtipo = b; --almacenamos el tipo de sitio que tenga key igual b

el_sitio_a sitios%ROWTYPE; --registro de tipo sitios
el_sitio_b sitios%ROWTYPE; -- registro de tipo sitios

el_sitio_a_min sitios%ROWTYPE; --registro de sitios
el_sitio_b_min sitios%ROWTYPE; --registro de sitios
el_tipo_sitio_a tipositios%ROWTYPE; --registro de tipo sitios
el_tipo_sitio_b tipositios%ROWTYPE; --registro de tipo sitios

distancia NUMBER := 0; -- distancia min comparada
min_distancia NUMBER := 100; --distancia comparadora

--valores para almacenar las coordenadas
num_x_a NUMBER;
num_y_a NUMBER;
num_x_b NUMBER;
num_y_b NUMBER;

BEGIN
    FOR el_sitio_a IN sitios_a LOOP
        FOR el_sitio_b IN sitios_b LOOP

            num_x_a := el_sitio_a.coorx; --x1
            num_y_a := el_sitio_a.coory; --y1

            num_x_b := el_sitio_b.coorx; --x2
            num_y_b := el_sitio_b.coory; --y2

            distancia := sqrt((num_x_b-num_x_a)*(num_x_b-num_x_a)+(num_y_b-num_y_a)*(num_y_b-num_y_a));

            IF min_distancia > distancia THEN
                min_distancia := distancia; -- lo almacenamos

                el_sitio_a_min := el_sitio_a;
                el_sitio_b_min := el_sitio_b;
            END IF;

        END LOOP;        
    END LOOP;

    -- lectura de los cursores e impresion de datos finalmente
    OPEN tipo_sitio_a;
    FETCH tipo_sitio_a INTO el_tipo_sitio_a;
    DBMS_OUTPUT.put_line('Origen: '|| el_tipo_sitio_a.nombretipo || ' (' || el_sitio_a_min.nombresitio || ')' );
    CLOSE tipo_sitio_a;

    OPEN tipo_sitio_b;
    FETCH tipo_sitio_b INTO el_tipo_sitio_b;
    DBMS_OUTPUT.put_line('Destino: ' || el_tipo_sitio_b.nombretipo || ' (' || el_sitio_b_min.nombresitio || ')' );
    CLOSE tipo_sitio_b;
    DBMS_OUTPUT.put_line('Son los sitios mas cercanos entre si');

END;