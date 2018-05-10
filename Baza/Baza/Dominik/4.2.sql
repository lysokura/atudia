-- Nowy wykladowca:
declare
  wykladowca_id WYKLADOWCA.ID_WYKLADOWCA%TYPE;
  tytul_id TYTULNAUKOWY.ID_TYTUL%TYPE;
  adres_id ADRES.ID_ADRES%TYPE;
  
  inserted_wykladowca WYKLADOWCA%ROWTYPE;
  wykladowca_tytul TYTULNAUKOWY%ROWTYPE;
  wykladowca_adres ADRES%ROWTYPE;
begin
  select max(ID_WYKLADOWCA) into wykladowca_id from WYKLADOWCA;
  wykladowca_id := wykladowca_id + 1;

  select max(ID_TYTUL) into tytul_id from TYTULNAUKOWY;
  tytul_id := dbms_random.value(1, tytul_id);

  select max(ID_ADRES) into adres_id from ADRES;
  adres_id := dbms_random.value(1, adres_id);

  insert into WYKLADOWCA (ID_WYKLADOWCA, IMIE, NAZWISKO, ID_ADRES, ID_TYTUL)
    values (wykladowca_id, 'Losowy-' || dbms_random.string('L', 7), 'Randomowy', adres_id, tytul_id)
    returning ID_WYKLADOWCA into wykladowca_id;

  select * into inserted_wykladowca from WYKLADOWCA
    where ID_WYKLADOWCA = wykladowca_id;

  select * into wykladowca_tytul
    from TYTULNAUKOWY where ID_TYTUL = tytul_id;

  select * into wykladowca_adres
    from ADRES where ID_ADRES = adres_id;

  dbms_output.put_line('Wygenerowano nowego wykladowce:');
  dbms_output.put_line('  ' || wykladowca_tytul.nazwa || ' ' || inserted_wykladowca.nazwisko || ' ' || inserted_wykladowca.imie);
  dbms_output.put_line('  Zamieszka³y: ' || wykladowca_adres.ulica || ', ' || wykladowca_adres.miasto);
end;

-- Najgorszy przedmiot:
declare
begin
  NULL
end;