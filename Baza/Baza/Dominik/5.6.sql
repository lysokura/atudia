SET SERVEROUTPUT ON;
/
CREATE OR REPLACE PROCEDURE OBNIZ_OCENE(
  p_student_nralbumu IN STUDENT.NRALBUMU%TYPE,
  p_przedmiot_nazwa IN PRZEDMIOT.NAZWA%TYPE,
  p_ocena_faktor_obizenia IN OCENA.OCENA%TYPE DEFAULT 0.5)
IS
  OBNIZ_OCENE_ERROR EXCEPTION;
  student_id STUDENT.ID_STUDENT%TYPE;
  przedmiot_id PRZEDMIOT.ID_PRZEDMIOT%TYPE;
  nowa_ocena OCENA.OCENA%TYPE;

  CURSOR oceny_do_obnizenia(
    std_id STUDENT.ID_STUDENT%TYPE,
    prz_id PRZEDMIOT.ID_PRZEDMIOT%TYPE
  ) IS
    SELECT *
      FROM OCENA
      WHERE ID_STUDENT = student_id
        AND ID_ZAJECIA IN (
          SELECT ID_ZAJECIA
            FROM ZAJECIA
            WHERE ID_PRZEDMIOT = ID_PRZEDMIOT
        );
      FOR UPDATE;
BEGIN
  BEGIN
    SELECT ID_STUDENT INTO student_id
      FROM STUDENT
      WHERE NRALBUMU = p_student_nralbumu;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      raise_application_error(-20001, 'Brak studenta o nr: ' || p_przedmiot_nazwa);
  END;

  BEGIN
    SELECT ID_PRZEDMIOT INTO przedmiot_id
      FROM PRZEDMIOT
      WHERE NAZWA = p_przedmiot_nazwa;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      raise_application_error(-20002, 'Brak przemiotu: ' || p_przedmiot_nazwa);
  END;

  FOR oc IN oceny_do_obnizenia(p_student_nralbumu, p_przedmiot_nazwa)
  LOOP
    nowa_ocena := oc.OCENA - p_ocena_faktor_obizenia;
    UPDATE OCENA
      SET OCENA = nowa_ocena;
      WHERE CURRENT OF oceny_do_obnizenia;
  END LOOP;

  UPDATE OCENA o
    SET OCENA = (o.OCENA - p_ocena_faktor_obizenia);
    WHERE ID_STUDENT = student_id
      AND ID_ZAJECIA IN (
        SELECT ID_ZAJECIA
          FROM ZAJECIA
          WHERE ID_PRZEDMIOT = ID_PRZEDMIOT
      );
END OBNIZ_OCENE;
/
DECLARE
BEGIN
  OBNIZ_OCENE(123, 'Niewa¿ny');
END;
/
--
-- Zadanie 5.6.
--
-- Napisz procedurê, która obni¿y ocenê danego studenta (parametr) z danego
-- przedmiotu (parametr) o podan¹ wartoœæ przekazan¹ przez parametr, domyœlna
-- wartoœæ: 0,5. Dodaj obs³ugê b³êdu – w przypadku podania danych studenta
-- oraz przedmiotów, których nie ma w bazie.