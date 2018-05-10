SET SERVEROUTPUT ON;
/

CREATE OR REPLACE FUNCTION PRZEDMIOTY_STUDENTA(
    p_student_album STUDENT.NRALBUMU%TYPE,
    p_budynek_nazwa BUDYNEK.NAZWA%TYPE,
    p_sala_kod SALA.KODSALI%TYPE)
  RETURN NUMBER
IS
  liczba_przedmiotow NUMBER(10) DEFAULT 0;
BEGIN
  SELECT COUNT(*)
  INTO liczba_przedmiotow
    FROM STUDENT st
    JOIN ZAJECIA za
      ON za.ID_GRUPA = st.ID_GRUPA
    JOIN SALA sa
      ON za.ID_SALA = sa.ID_SALA
    JOIN BUDYNEK bu
      ON sa.ID_BUDYNEK = bu.ID_BUDYNEK
    WHERE bu.NAZWA LIKE '%' || p_budynek_nazwa || '%'
      AND sa.KODSALI  = p_sala_kod
      AND st.NRALBUMU = p_student_album;

  RETURN liczba_przedmiotow;
END PRZEDMIOTY_STUDENTA;
/

DECLARE
  album_studenta STUDENT.NRALBUMU%TYPE DEFAULT 86066;
  nazwa_budynku BUDYNEK.NAZWA%TYPE DEFAULT 'Wydzia³ In¿ynierii i Technologii Chemicznej';
  kod_sala SALA.KODSALI%TYPE DEFAULT '136';
BEGIN
  dbms_output.put_line('Liczba przedmiotów studneta - ' || album_studenta || ':');
  dbms_output.put_line('  * W budynku: "' || nazwa_budynku || '"');
  dbms_output.put_line('    W sali: "' || kod_sala || '"');
  dbms_output.put_line('    Wynosi: ' || PRZEDMIOTY_STUDENTA(album_studenta, nazwa_budynku, kod_sala));
END;

--
--
-- Zadanie 5.4.
--
-- Napisaæ funkcje PL/SQL, która dla podanego nr albumu studenta oraz budynku
-- i sali (parametry) zwróci liczbê przedmiotów, na które uczêszcza dany student.
