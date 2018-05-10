Zestaw II

1:
DECLARE 
  vimie VARCHAR2(50) := '&imie'; 
  vnazwisko VARCHAR2(50) := '&nazwisko'; 
  vsklejone VARCHAR2(100) := '';
BEGIN 
  vsklejone := 'Witaj bazy danych ' || vimie || ' ' || vnazwisko || '!'; 
  dbms_output.put_line(vsklejone); 
END;

2:
SET SERVEROUTPUT ON
DECLARE 
  pi CONSTANT NUMBER(5,4) := 3.1415;
  nPromien number(5,4) := &promien; 
  pole number(10,4) := 0;
  obwod number(10,4) := 0;
BEGIN 
  pole := nPromien * nPromien * pi;
  obwod := 2 * pi * nPromien;
  dbms_output.put_line('pole ' || pole || ' obwod ' || obwod); 
END;

3:
DECLARE 
  liczba1 number(5) := &liczba1; 
  liczba2 number(5) := &liczba2; 
  wynik number(6) := 0;
BEGIN 
  wynik := liczba1 + liczba2;
  dbms_output.put_line('Wynik dodawania ' || wynik); 
END;

4:
DECLARE 
  nn number(5) := &n; 
  wynik number(6) := 1;
BEGIN 
  FOR licznik IN  2 .. nn LOOP 
    wynik := wynik * licznik; 
  END LOOP;
  dbms_output.put_line('Wynik silnia ' || wynik); 
END;

5:
to co 2!

6;
DECLARE 
  liczba1 number(5) := &l1; 
  liczba2 number(5) := &l2; 
  wynik number(10) := 1;
BEGIN 
  if liczba1 < 1 OR liczba1 > 10 then
    dbms_output.put_line('Liczba pierwsza jest w zlym zakresie, prawidlowy zakres od 1 do 10'); 
    return;
  end if;
  
  if liczba2 < 1 OR liczba2 > 10 then
    dbms_output.put_line('Liczba druga jest w zlym zakresie, prawidlowy zakres od 1 do 10'); 
    return;
  end if;
  
  FOR licznik IN  1 .. liczba2 LOOP 
    wynik := wynik * liczba1; 
  END LOOP;
  dbms_output.put_line('Wynik potegowania ' || wynik); 
END;

7: 
DECLARE 
  nn number(10) := &n; 
  wynik number(38,37) := 0;
  temp number(10) := 1;
BEGIN 
  
  for licznik in 0 .. nn LOOP 
    temp := 1;
    FOR licznik2 IN  1 .. licznik LOOP 
      temp := temp * licznik2; 
    END LOOP;
    wynik := wynik + (1/temp);
  END LOOP; 

  dbms_output.put_line('Liczba e wynosi: ' || wynik); 
END;


DECLARE 
  nn number(10) := &n; 
  wynik number(38,37) := 0;
  temp number(10) := 1;
BEGIN 
  
  for licznik in 0 .. nn LOOP 
    if licznik > 1 then
      temp := temp * licznik;
    end if;
    wynik := wynik + (1/temp);
  END LOOP; 

  dbms_output.put_line('Liczba e wynosi: ' || wynik); 
END;

8:
Declare
  vseconds Number(2) := 0;
  vtest VARCHAR2(3) := '';
BEGIN 
  vseconds := TO_NUMBER(TO_CHAR (SYSDATE,'SS'),'99');
  
  loop
    vseconds := 	;
    exit when
     MOD(vseconds, 15) =0;-- 0 OR   vseconds / 15 = 1 OR vseconds / 15 = 2 OR vseconds / 15 = 3;
  end loop;
  dbms_output.put_line(TO_CHAR (SYSDATE,'HH:mm:SS')); 
END;

Zestaw III
1:
Declare
  vImie varchar(50) := '';
  vNazwisko varchar(50) := '';
  vNumer Number(10) := 0;
  vSrednia Number(5,4) := 0;  
  vIdStudneta Number(2) := 0;
BEGIN 
  select *  INTO vSrednia, vIdStudneta from(
    SELECT avg(ocena) sr, id_student from ocena group by id_student order by sr desc
  )where rownum = 1;
  dbms_output.put_line(vSrednia); 
  select imie, nazwisko, nralbumu into vImie, vNazwisko, vNumer from student where id_student = vIdStudneta;
  dbms_output.put_line(vImie || ' ' || vNazwisko || ' ' || vNumer || ' ' || vSrednia); 
END;

2: 
Declare 
  vIdStudneta Number(2) := 0;
  TYPE DaneOsobowe IS RECORD ( 
    ID_STUDENT NUMBER(10), 
    IMIE VARCHAR2(20),
    NAZWISKO VARCHAR2(20),
    ID_ADRES NUMBER(10),
    NRALBUMU NUMBER(10),
    ID_GRUPA NUMBER(10)
  ); 
  osoba DaneOsobowe;
  
  osoba2 STUDENT%ROWTYPE;
BEGIN 
  select id_student  INTO  vIdStudneta from(
    SELECT avg(ocena) sr, id_student from ocena group by id_student order by sr asc
  )where rownum = 1;
 
  select * into osoba2  from  student where id_student = vIdStudneta;
  select * into osoba  from  student where id_student = vIdStudneta;
  
  dbms_output.put_line(osoba.IMIE); 
  dbms_output.put_line(osoba2.IMIE); 
END;


3:

4:
Declare
  vIdPrzedmiot number(3) := &n;
BEGIN 

  update zajecia set
  id_charakter = 
  case 
  when (id_charakter = 1) then 3
  when (id_charakter = 3) then 2
  when (id_charakter = 5) then 1
  when (id_charakter = 2) then 5
  end 
  where id_grupa = &n and id_charakter in (1,3,2,5);

END;

5: 
Declare
  vImie varchar(50) := '&imie';
  vNazwisko varchar(50) := '&nazwisko';
  vIlosc Number(3);
BEGIN 
  select NVL( count(*), 0) into vIlosc from zajecia where id_wykladowca = (select  ID_WYkladowca from wykladowca where imie = vImie and nazwisko = vNazwisko);
  dbms_output.put_line(to_char(vIlosc));
END;

6:
Declare
  vSala varchar(50) := '&Sala';
  vNrIndeks number(5) := &NrIndeks;
  vBudenyk number(5) := &Budenyk;
  vIlosc Number(3);
BEGIN 
  select NVL(count(*),0) into vIlosc from zajecia where id_sala in(select id_sala from sala where id_budynek = vBudenyk and KODSALI = vSala) and id_grupa = (select id_grupa from student where nralbumu = vNrIndeks );
  dbms_output.put_line(to_char(vIlosc));
END;

Zestaw IV:

1:
Declare
  vDataUrodzin varchar(10) := '&DataUrodzin';
  vDataUrodzinMoja date := '1991-09-05';
  vDate date;
  vyear Number(4) := 0;
  vm Number(2) := 0;
  vd Number(2) := 0;
  vDataOtatni varchar(10);
  monthE exception;
  dayE exception;
  yearE exception;
  vIlosc number(10) :=0;
BEGIN 
  vyear := to_number(SUBSTR(vDataUrodzin, 0, 4));
  vm := to_number(SUBSTR(vDataUrodzin, 6, 2));
  vd := to_number(SUBSTR(vDataUrodzin, 9, 2));

  if vyear < 0 then
    raise yearE;
  end if; 

  if vm > 12 OR vm < 1 then
    raise monthE;
  end if;
  
  vDataOtatni := SUBSTR(vDataUrodzin, 0, 8) || '01';
  vDate := last_day(to_date(vDataOtatni,'yyyy-mm-dd'));

  if Extract (day from vDate) <  vd then
    raise dayE;
  end if;
  
  vDate := to_date(vDataUrodzin,'yyyy-mm-dd');

  vIlosc :=  vDate - vDataUrodzinMoja;
  dbms_output.put_line(ABS(vIlosc));

  EXCEPTION 
  WHEN monthE THEN dbms_output.put_line('zly miesiac'); 
  WHEN dayE THEN dbms_output.put_line('zly dzien'); 
  WHEN yearE THEN dbms_output.put_line('zly rok'); 
END;


2:
SET SERVEROUTPUT ON;
Declare

    
    updateE exception;
    idPrzedmiot Number(4);
    ocena Number(4,1);
BEGIN 


  insert into wykladowca(ID_WYKLADOWCA,IMIE,NAZWISKO,ID_ADRES,ID_TYTUL)
  values(
  (select max(id_wykladowca) + 1 from wykladowca),
  'Ja2',
  'Test2',
  1,
  1
  );

  
  select id_zajecia, avg(ocena) sroc 
  into idPrzedmiot, ocena 
  from ocena 
    group by id_zajecia having avg(ocena) = (select min(avg(ocena)) from ocena group by  id_zajecia);
  
  delete from ocena where id_zajecia = idPrzedmiot;
  
  
   EXCEPTION 
  WHEN TOO_MANY_ROWS THEN dbms_output.put_line('wiecej niz jeden do aktualizacji'); 
 
END;


SET SERVEROUTPUT ON;
Declare
    vImie varchar(50) := '&Imie';
    vNazwisko varchar(50) := '&Nazwisko';
    vIdAdres Number(4) := &IdAdres;
    vNrAlbumu varchar(6) := &NrAlbumu;
    vGrupa varchar(50) := &Grupa;
    
    addE exception;
    groupE exception;
    
    cursor curAdres(p_id_adres number) is 
    select * from adres where id_adres = p_id_adres;
    
    cursor curGrupa(p_id_grupa number) is 
    select * from grupa where id_grupa = vGrupa;
    
    adresR ADRES%ROWTYPE;
    grupaR GRUPA%ROWTYPE;
BEGIN 
  savepoint testPoint;
  
  open curAdres(vIdAdres);
  --dbms_output.put_line(curAdres%ROWCOUNT);
  FETCH curAdres into adresR;
  if curAdres%NOTFOUND  then
    close curAdres;
    raise addE;
  end if;
  close curAdres;
  
  open curGrupa(vGrupa);
  FETCH curGrupa into grupaR;
  if curGrupa%NOTFOUND  then
    close curGrupa;
    raise groupE;
  end if;
  close curGrupa;
  
  insert into student(ID_STUDENT, IMIE, NAZWISKO, ID_ADRES, NRALBUMU, ID_GRUPA)
  values
  (
    (select max(ID_STUDENT) + 1 from student),
    vImie,
    vNazwisko,
    vIdAdres,
    vNrAlbumu,
    vGrupa
  );
  
  if '&Pytanie' = 'TAK' then
    commit;
  else
    rollback to testPoint;
  end if;

  exception
    WHEN addE THEN dbms_output.put_line('zly adres'); 
    WHEN groupE THEN dbms_output.put_line('zla gruopa');
END;

4:
SET SERVEROUTPUT ON;
Declare
    cursor curOceny(dataOd date, dataDo date) is 
    select ocena.data, ocena.ocena, student.imie, student.nazwisko, wykladowca.imie, wykladowca.nazwisko 
    from ocena natural join student natural join zajecia join wykladowca on zajecia.id_wykladowca = wykladowca.id_wykladowca
    where ocena.data between dataOd and dataDo;
  
    TYPE DaneOcena IS RECORD ( 
      DATA_OCENY DATE,
      OCENA NUMBER(4,1), 
      IMIE VARCHAR2(50),
      NAZWISKO VARCHAR2(50),
      IMIEW VARCHAR2(50),
      NAZWISKOW VARCHAR2(50)
    ); 
    
    dane DaneOcena;
  
    vDataOd date := to_date('&Dataod', 'yyyy-mm-dd');
    vDataDo date := to_date('&DataDo', 'yyyy-mm-dd');
    
BEGIN 
  open curOceny(vDataOd, vDataDo);
  loop 
    fetch curOceny into dane;
    exit when curOceny%NOTFOUND;
    dbms_output.put_line(dane.DATA_OCENY || ' ' || dane.OCENA || ' ' || dane.IMIE
      || ' ' || dane.NAZWISKO || ' ' || dane.IMIEW || ' ' || dane.NAZWISKOW);
  end loop;
  close curOceny;
END;


5: 
SET SERVEROUTPUT ON;
Declare
    cursor curPrzedmiotWykladowca is 
    select distinct przedmiot.nazwa, wykladowca.imie, wykladowca.nazwisko from zajecia natural join wykladowca natural join przedmiot ;
  
    TYPE DanePrzedmiot IS RECORD ( 
      PRZEDMIOT VARCHAR2(50),
      IMIE VARCHAR2(50),
      NAZWISKO VARCHAR2(50)
    ); 
    
    dane DanePrzedmiot;

    
BEGIN 
  open curPrzedmiotWykladowca;
  loop 
    fetch curPrzedmiotWykladowca into dane;
    exit when curPrzedmiotWykladowca%NOTFOUND;
    dbms_output.put_line('Profesor ' || ' ' || dane.IMIE
      || ' ' || dane.NAZWISKO || ' prowadzi przedmiot ' || dane.PRZEDMIOT );
  end loop;
  close curPrzedmiotWykladowca;
END;

6:

select w.nazwisko, w.imie  from wykladowca w natural join przedmiot natural join zajecia   group by w.nazwisko, w.imie
