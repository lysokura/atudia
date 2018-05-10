accept PODANE_NAZWIOSKO prompt 'Podaj nazwisko nowego studenta: ';
accept PODANE_IMIE prompt 'Podaj imie nowego studenta: ';
accept PODANE_ADRES_ID number format '99999999' default '-1' prompt 'Podaj ID adresu nowego studenta: ';
accept PODANE_GRUPA_ID number format '99999999' default '-1' prompt 'Podaj ID grupy studenta: ';
accept CZY_JEST_OK prompt 'Czy dane s¹ wporz¹dku [ TAK / NIE ]? ';

declare
  student_nazwisko STUDENT.NAZWISKO%TYPE;
  student_imie STUDENT.IMIE%TYPE;
  student_adres_id STUDENT.ID_ADRES%TYPE;
  student_grupa_id STUDENT.ID_GRUPA%TYPE;
  ADRES_NOT_FOUD EXCEPTION;
  GRUPA_NOT_FOUD EXCEPTION;
  STUDNET_ERROR EXCEPTION;
  ANDRZEJ_TO_BNIE EXCEPTION;
  studnet_id STUDENT.ID_STUDENT%TYPE;
  studnet_nralbumu STUDENT.NRALBUMU%TYPE;
begin
  if 'TAK' <> '&CZY_JEST_OK' then
    raise ANDRZEJ_TO_BNIE;
  end if;

  student_nazwisko := '&PODANE_NAZWIOSKO';
  student_imie := '&PODANE_IMIE';
  
  begin
    select ID_ADRES
    into student_adres_id
      from ADRES
      where ID_ADRES = &PODANE_ADRES_ID;
  exception
    when NO_DATA_FOUND then
      dbms_output.put_line('Nie ma adresu o podanym id: ' || &PODANE_ADRES_ID);
      raise STUDNET_ERROR;
  end;

  begin
    select ID_GRUPA
    into student_grupa_id
      from GRUPA
      where ID_GRUPA = &PODANE_GRUPA_ID;
  exception
    when NO_DATA_FOUND then
      dbms_output.put_line('Nie ma grupy studenckiej o podanym id: ' || &PODANE_ADRES_ID);
      raise STUDNET_ERROR;
  end;

  select max(ID_STUDENT) + 1
  into studnet_id
    from STUDENT;

  select max(NRALBUMU) + 1
  into studnet_nralbumu
    from STUDENT;

  insert into STUDENT (ID_STUDENT, IMIE, NAZWISKO, ID_ADRES, NRALBUMU, ID_GRUPA)
    values (studnet_id, student_imie, student_nazwisko, student_adres_id, studnet_nralbumu, student_grupa_id);

  exception
    when STUDNET_ERROR then
      dbms_output.put_line('I koniec...');
    when ANDRZEJ_TO_BNIE then
      dbms_output.put_line('iebo... ¯adne dane nie ucierpaialy.');      
end;
