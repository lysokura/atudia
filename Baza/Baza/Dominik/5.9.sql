SET SERVEROUTPUT ON;
/
CREATE OR REPLACE FUNCTION LICZBA_OCEN(
    p_student_id STUDENT.ID_STUDENT%TYPE)
  RETURN NUMBER
IS
  liczba NUMBER(10, 0) := 0;
  nr_album STUDENT.NRALBUMU%TYPE;
BEGIN
  SELECT NRALBUMU INTO nr_album
    FROM STUDENT
    WHERE ID_STUDENT = p_student_id;

  SELECT count(*) INTO liczba
    FROM OCENA
    WHERE ID_STUDENT = p_student_id;

  IF liczba = 0 THEN
    raise_application_error(-20001, 'Wyglada na to i�, dany student (' || nr_album || ') nie posiada ocen.');
  END IF;

  RETURN liczba;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20002, 'Brak studenta o ID: ' || p_student_id || '.');  
END LICZBA_OCEN;
/
DECLARE
  student_id STUDENT.ID_STUDENT%TYPE;
BEGIN
  student_id := 33;
  dbms_output.put_line('Liczba ocen studenta o ID: ' || student_id || ' == ' || LICZBA_OCEN(student_id));

  student_id := 1;
  dbms_output.put_line('Liczba ocen studenta o ID: ' || student_id || ' == ' || LICZBA_OCEN(student_id));

  student_id := 9999;
  dbms_output.put_line('Liczba ocen studenta o ID: ' || student_id || ' == ' || LICZBA_OCEN(student_id));
END;
/
--
--
-- Zadanie 5.9.
--
-- Napisz funkcj�, kt�ra dla podanego id studenta (poprzez parametr) liczb�
-- ocen przez niego uzyskanych. W przypadku, gdy student nie ma ocen skorzystaj
-- zaproponuj alternatywn� obs�ug� b��d�w. Przetestuj dzia�anie funkcji.