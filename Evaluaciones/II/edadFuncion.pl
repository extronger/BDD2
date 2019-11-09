create or replace FUNCTION edad(id_amigo number)
RETURN number AS
fnac_amigo date;
now date;

BEGIN

SELECT SYSDATE INTO now FROM dual;
SELECT fnac INTO fnac_amigo FROM amigos WHERE id_amigo = id;
RETURN (now - fnac_amigo)/365;

END;