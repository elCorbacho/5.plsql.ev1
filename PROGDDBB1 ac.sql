PROMPT Por favor, ingrese el n�mero de RUN del m�dico:
ACCEPT med_run NUMBER PROMPT 'Ingrese el n�mero de RUN: '

PROMPT Por favor, ingrese el d�gito verificador del m�dico:
ACCEPT dv_run NUMBER PROMPT 'Ingrese el D�gito Verificador: '

DECLARE
    v_medrun     NUMBER;
    v_dv         NUMBER;
    v_nombre     VARCHAR(100);
    v_apaterno   VARCHAR(100);
    v_amaterno   VARCHAR(100);
    v_sueldobase NUMBER;
    bonificacion NUMBER := 0.15;
BEGIN
    SELECT
        med_run,
        dv_run,
        pnombre,
        apaterno,
        amaterno,
        sueldo_base
    INTO
        v_medrun,
        v_dv,
        v_nombre,
        v_apaterno,
        v_amaterno,
        v_sueldobase
    FROM
        medico
    WHERE
            sueldo_base <= 1000000
        AND med_run = &med_run
        AND dv_run = &dv_run;

    dbms_output.put_line('DATOS CALCULO BONIFICACION EXTRA DEL 15% DEL SUELDO');
    dbms_output.put_line('---------------------------------------------------');
    dbms_output.put_line('RUN medico: '
                         || v_medrun
                         || '-'
                         || v_dv);
    dbms_output.put_line('Nombre medico: '
                         || v_nombre
                         || ' '
                         || v_apaterno
                         || ' '
                         || v_amaterno);

    dbms_output.put_line('Sueldo: ' || v_sueldobase);
    dbms_output.put_line('Bonificacion extra: ' || round(v_sueldobase * bonificacion));
    dbms_output.put_line('Sueldo final: '
                         || round(v_sueldobase +(v_sueldobase * bonificacion)));

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No se encontr� ning�n m�dico con el RUN y d�gito verificador proporcionados.');
    WHEN too_many_rows THEN
        dbms_output.put_line('Se encontr� m�s de un m�dico con el mismo RUN y d�gito verificador.');
    WHEN OTHERS THEN
        dbms_output.put_line('Ocurri� un error al intentar recuperar los datos del m�dico.');
END;