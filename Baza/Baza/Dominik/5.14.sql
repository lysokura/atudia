SET SERVEROUTPUT ON;
/
CREATE OR REPLACE FUNCTION SILNIA(
    p_n NUMBER)
  RETURN NUMBER
IS
BEGIN
  IF p_n < 2 THEN
    RETURN 1;
  END IF;
RETURN p_n * SILNIA(p_n - 1);
END SILNIA;
/
BEGIN
  dbms_output.put_line('Przykladowe wartoœci obliczonej silnej:');
  FOR sample_n IN 0..8
  LOOP
    dbms_output.put_line(sample_n || '! == ' || SILNIA(sample_n));
  END LOOP;
END;
/
--
--
-- Zadanie 5.14.
--
-- Napisz funkcjê SILNIA w sposób rekurencyjny. Przetestuj jej dzia³anie.