SET SERVEROUTPUT ON;
/

CREATE OR REPLACE PROCEDURE X (
    p_x IN VARCHAR2,
    p_y OUT NUMBER)
IS
  aaa BOOLEAN DEFAULT false;
BEGIN
  p_y := 42;
END X;
/

DECLARE
  bbb NUMBER(10);
BEGIN
  X('asdf', bbb);
  dbms_output.put_line('zxcv 1324 : ' || bbb);
END;

--
--
-- Zadanie X.Y.
--
-- ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ.