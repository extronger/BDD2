CREATE OR REPLACE PROCEDURE masCercanos(x IN INTEGER, y IN INTEGER, nombre TipoSitios.nombreTipo%TYPE) AS
	CURSOR misSitios IS
	SELECT * FROM Sitios;
	miSitio Sitios%ROWTYPE;
	idDelTipo INTEGER;
	-- Variables que almacenan la distancia de las ciudades cercanas
	cercanoUno INTEGER := 100000; 
	cercanoDos INTEGER := 100000;
	cercanoTres INTEGER := 100000;
	-- Variables que almacenan los nombres de las ciudades cercanas
	nombreSitioUno Sitios.nombreSitio%TYPE;
	nombreSitioDos Sitios.nombreSitio%TYPE;
	nombreSitioTres Sitios.nombreSitIo%TYPE;
	distancia INTEGER;
    flag boolean;
    nombreUnoAuxiliar Sitios.nombreSitio%TYPE;
    nombreDosAuxiliar Sitios.nombreSitio%TYPE;
    distanciaUnoAuxiliar INTEGER;
    distanciaDosAuxiliar INTEGER;
BEGIN
	-- Obtiene la id del tipo de sitio ingresado como parametro y lo guarda en idDelTipo
	SELECT idTipo INTO idDelTipo FROM TipoSitios WHERE nombreTipo = nombre;
	FOR miSitio IN misSitios LOOP
		-- Obtiene la distancia entre dos coordenadas
		SELECT sqrt((x-miSitio.coorX)*(x-miSitio.coorX)+(y-miSitio.coorY)*(y-miSitio.coorY)) INTO distancia FROM dual;
		IF(miSitio.tipoSitio = idDelTipo) THEN
			-- Guarda la distancia mas cercana
			IF (distancia <= cercanoUno) THEN
                nombreUnoAuxiliar :=  nombreSitioUno;
                distanciaUnoAuxiliar := cercanoUno;
				cercanoUno := distancia;
				nombreSitioUno := miSitio.nombresitio;
                flag := true;
            END IF;
            -- Guarda la segunda distancia mas cercana
			IF (distancia <= cercanoDos AND flag) THEN
                nombreDosAuxiliar := nombreSitioDos;
                distanciaDosAuxiliar := cercanoDos;
				cercanoDos := distanciaUnoAuxiliar;
				nombreSitioDos := nombreUnoAuxiliar;
            END IF;
            -- Guarda la tercera distancia mas cercana
			IF (distancia <= cercanoTres AND flag) THEN
				cercanoTres := distanciaDosAuxiliar;
				nombreSitioTres := nombreDosAuxiliar;
			END IF;
		END IF;
        flag := false;
	END LOOP;
    if cercanoUno != 100000 THEN
	DBMS_OUTPUT.PUT_LINE('Primer punto cercano: '||nombreSitioUno||' con una distancia de '||cercanoUno);
    END IF;
    IF cercanoDos != 100000 THEN
	DBMS_OUTPUT.PUT_LINE('Segundo punto cercano: '||nombreSitioDos||' con una distancia de '||cercanoDos);
    END IF;
    IF cercanoTres != 100000 THEN
	DBMS_OUTPUT.PUT_LINE('Tercer punto cercano: '||nombreSitioTres||' con una distancia de '||cercanoTres);
    END IF;
END;