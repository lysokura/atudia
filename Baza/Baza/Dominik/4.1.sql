accept PODANA_DATA prompt 'Podaj datê w formacie YYYY-MM-DD: ';

declare
  podana_data date;
  moje_urodziny date;  
  liczba_dni number(10);
begin
  moje_urodziny := to_date('1989-05-15', 'yyyy-mm-dd');
  podana_data := to_date('&PODANA_DATA', 'yyyy-mm-dd');
  
  dbms_output.put_line('Podana data (yyyy-mm-dd): ' || to_char(podana_data, 'yyyy-mm-dd'));  

  if podana_data < moje_urodziny then
    dbms_output.put_line('Có¿, jeszcze siê nie urodzi³em...');
  else
    liczba_dni := podana_data - moje_urodziny;
    dbms_output.put_line('Od moich urodzin minê³o ' || liczba_dni || ' dni.');
  end if;
end;
