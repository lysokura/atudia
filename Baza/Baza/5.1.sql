SET SERVEROUTPUT ON;
/

CREATE OR REPLACE PROCEDURE NAJLEPSZY_STUDENT(
    p_nazwisko OUT STUDENT.NAZWISKO%TYPE,
    p_imie OUT STUDENT.IMIE%TYPE,
    p_album OUT STUDENT.NRALBUMU%TYPE,
    p_srednia OUT NUMBER)
IS
  znaleziono BOOLEAN DEFAULT false;
  CURSOR najlepsi_studenci
  IS
    SELECT ID_STUDENT, SREDNIA
      FROM (
        SELECT ID_STUDENT, AVG(OCENA) AS SREDNIA
          FROM OCENA
          GROUP BY ID_STUDENT)
      ORDER BY SREDNIA DESC;
BEGIN
  FOR najlepszy IN najlepsi_studenci
  LOOP
    znaleziono := true;
    p_srednia  := najlepszy.SREDNIA;

    SELECT NAZWISKO, IMIE, NRALBUMU
    INTO p_nazwisko, p_imie, p_album
      FROM STUDENT
      WHERE ID_STUDENT = najlepszy.ID_STUDENT;

    IF najlepsi_studenci%ROWCOUNT > 1 THEN
      raise_application_error(-20001, 'Wyst�puje wi�cej ni� jeden najlepszy student. U�yj innej procedury.');
    END IF;
  END LOOP;

  IF NOT znaleziono THEN
    raise_application_error(-20003, 'Studneci nieposiadaj� ocen. Nie ma najlepszego studenta.');
  END IF;
END NAJLEPSZY_STUDENT;
/

DECLARE
  student_nazwisko STUDENT.NAZWISKO%TYPE;
  student_imie STUDENT.IMIE%TYPE;
  student_album STUDENT.NRALBUMU%TYPE;
  student_srednia NUMBER(3,2);
BEGIN
  NAJLEPSZY_STUDENT(student_nazwisko, student_imie, student_album, student_srednia);
  dbms_output.put_line('Student: ' || student_nazwisko || ' ' || student_imie || ' #' || student_album || ' => �rednia: ' || student_srednia);
END;

--
--
-- Zadanie 5.1.
--
-- Napisz procedur� sparametryzowan�, w kt�rej zostanie wybrany najlepszy
-- student, a jego nazwisko, imi� i numer albumu oraz �rednia zostan� przekazane
-- do �rodowiska wywo�uj�cego, gdzie nale�y wypisa� je na ekranie. Wprowad�
-- obs�ug� b��d�w, je�li wi�cej ni� jeden student uzyska najwy�sz� �redni�.
