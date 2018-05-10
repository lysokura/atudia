SET SERVEROUTPUT ON;
/

CREATE OR REPLACE PROCEDURE PRZEDMIOTY_PROWADZACEGO(
    p_nazwisko IN WYKLADOWCA.NAZWISKO%TYPE,
    p_imie IN WYKLADOWCA.NAZWISKO%TYPE,
    p_liczba_przedmiotow OUT NUMBER)
IS
  wykladowaca_id WYKLADOWCA.ID_WYKLADOWCA%TYPE;
  CURSOR przedmioty_wykladowcy(wyk_id WYKLADOWCA.ID_WYKLADOWCA%TYPE)
  IS
    SELECT COUNT(ID_PRZEDMIOT) AS SUMA
    FROM ( SELECT DISTINCT ID_PRZEDMIOT FROM ZAJECIA WHERE ID_WYKLADOWCA = wyk_id );
BEGIN
  SELECT ID_WYKLADOWCA
  INTO wykladowaca_id
    FROM WYKLADOWCA
    WHERE NAZWISKO = p_nazwisko
      AND IMIE = p_imie;
      
  p_liczba_przedmiotow := 0;
  FOR przedmioty IN przedmioty_wykladowcy(wykladowaca_id)
  LOOP
    -- Powinno wykona� si�, nie wi�cej ni� raz.
    p_liczba_przedmiotow := przedmioty.SUMA;
  END LOOP;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  raise_application_error(-20001, 'Nie ma prowadzacego o podanych danych.');
END PRZEDMIOTY_PROWADZACEGO;
/

DECLARE
  prowadzacy_nazwisko WYKLADOWCA.NAZWISKO%TYPE DEFAULT 'Bukerzy�ski';
  prowadzacy_imie WYKLADOWCA.IMIE%TYPE DEFAULT 'Naczes�aw';
  --prowadzacy_nazwisko WYKLADOWCA.NAZWISKO%TYPE DEFAULT 'Hoteit';
  --prowadzacy_imie WYKLADOWCA.IMIE%TYPE DEFAULT 'Wszemi�';
  prowadzacy_liczba_przedmiotow NUMBER(10);
BEGIN
  PRZEDMIOTY_PROWADZACEGO(prowadzacy_nazwisko, prowadzacy_imie, prowadzacy_liczba_przedmiotow);
  dbms_output.put_line('Podany wykladowca - ' || prowadzacy_imie || ' ' || prowadzacy_nazwisko);
  dbms_output.put_line('  * prowadzi przedmiot�w w liczbie: ' || prowadzacy_liczba_przedmiotow || '.');
END;

--
--
-- Zadanie 5.3.
--
-- Utworzy� funkcj�, kt�ra dla podanego nazwiska i imienia prowadz�cego
-- (parametr), zwr�ci liczb� przedmiot�w przez niego prowadzonych.
