declare
  najgorsza_srednia number(5, 4);
  najgorszy_przedmiot_id ZAJECIA.ID_PRZEDMIOT%TYPE;
  najgorszy_przedmiot_nazwa PRZEDMIOT.NAZWA%TYPE;
begin
  select min(SREDNIA)
  --select max(SREDNIA)
  into najgorsza_srednia
    from (
      select avg(OCENA) as SREDNIA
        from OCENA natural join ZAJECIA
        group by ID_PRZEDMIOT);

  select ID_PRZEDMIOT
  into najgorszy_przedmiot_id
    from (
      select
        cast(avg(OCENA) as number(5, 4)) as SREDNIA,
        ZAJECIA.ID_PRZEDMIOT
      from OCENA natural join ZAJECIA
      group by ID_PRZEDMIOT
    )
    where SREDNIA = najgorsza_srednia;

  for zajecie in (
    select * from ZAJECIA
      where ID_PRZEDMIOT = najgorszy_przedmiot_id
      for update)
  loop
    delete from OCENA
      where ID_ZAJECIA = zajecie.ID_ZAJECIA;
      
    delete from ZAJECIA
      where ID_ZAJECIA = zajecie.ID_ZAJECIA;
  end loop;

  delete from PRZEDMIOT
    where ID_PRZEDMIOT = najgorszy_przedmiot_id
    returning NAZWA into najgorszy_przedmiot_nazwa;

  dbms_output.put_line('Usunieto przedmiot: [' || najgorszy_przedmiot_id || '] ' || najgorszy_przedmiot_nazwa);

exception
  when TOO_MANY_ROWS then
    dbms_output.put_line('Wystêpuje wiêcej ni¿ jeden przedmiot o najgorszej œredniej: ' || najgorsza_srednia);
end;