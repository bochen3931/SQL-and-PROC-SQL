
/* Defines the path to your data and assigns the libref. */
%let path=~/ADV;

libname certadv xlsx "&path/Lab.xlsx";

proc print data=certadv.lab1;
proc print data=certadv.lab12;
run;

data advlab1;
merge certadv.lab1(in=a) certadv.lab12(in=b);
if b;
run;

proc sql;
create table certadv_lab1_sql as
select * from certadv.lab1
where name in (select name from certadv.lab12);
quit;

proc print data=certadv.lab2;
run;

proc print data=certadv.lab2 label;
label Name="Employee Name" DID="Department ID";
run;

proc sql;
/* create table certadv_lab2_sql as */
select Name label="Employee Name",
       DID label="Department ID"
from certadv.lab2;
quit;

/* 用sql把region='AMR'的avg（var）存成一个macro variable */
proc print data=certadv.lab3;
run;

proc sql;
select avg(height) into :macro_var1 
from certadv.lab3;
quit;
%put &macro_var1;

Proc sql;
create table lab3a as
select avg(height) as height_avg
from certadv.lab3
where region = "AMR";
select height_avg into :macro_var1 from lab3a
;
quit;
%put &macro_var1;


proc print data=certadv.lab5;
run;

data certadvlab5;
set certadv.lab5;
if height <= 170 then HLM="Low";
else if height <181 then HLM="Middle";
else HLM="High";
run;

proc format;
value fmt low-170="Low"
          170<-<181="Middle"
          181-high="High";
run;
data certadvlab5a;
set certadv.lab5;
height1=height;
format height1 fmt.;
run;

proc sql;
select *,
case when height <= 170 then "Low"
     when 170 < height < 181 then "Middle"
     when 181 <= height then "High"
     end as HLM
from certadv.lab5;
quit;











