declare
  dane_od date;
  dane_do date;
  cursor dane(OD date, DO date) is
    select 
      O.DATA,
      O.OCENA,
      S.NRALBUMU,
      S.NAZWISKO as S_NAZWISKO,
      W.NAZWISKO as W_NAZWISKO
    from OCENA O
      join STUDENT S on O.ID_STUDENT = S.ID_STUDENT
      join ZAJECIA Z on O.ID_ZAJECIA = Z.ID_ZAJECIA
      join WYKLADOWCA W on Z.ID_WYKLADOWCA = W.ID_WYKLADOWCA
    where O.DATA between OD and DO;
begin
  dane_od := to_date('1970-01-01', 'yyyy-mm-dd');
  dane_do := to_date('2233-01-01', 'yyyy-mm-dd');
  
  for dane_oceny in dane(dane_od, dane_do) loop    
    dbms_output.put_line(dane%ROWCOUNT ||  '. Ocena: ' || dane_oceny.OCENA || ' dnia: ' || to_char(dane_oceny.DATA, 'yyyy-mm-dd'));
    dbms_output.put_line('  Student: [' || dane_oceny.NRALBUMU || '] ' || dane_oceny.S_NAZWISKO);
    dbms_output.put_line('  Wykladowca: ' || dane_oceny.W_NAZWISKO);
  end loop;
end;
