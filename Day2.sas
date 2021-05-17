libname cert "/home/u44723226/ECRBM6/data/cert/input";

data output04;
set cert.input04;
var3=round(var1)*round(var2);
var20=sum(of var12-var19); 
/* var20=var12+var13+var14; */
run;

proc print data=output04;run;

/* so few workers go home on time */
proc sql;
/* create table output04_sql as */
select *,
round(var1)*round(var2) as var3,
COALESCE (var12,0)+COALESCE (var13,0)+COALESCE (var14,0)+COALESCE (var15,0)+
COALESCE (var16,0)+COALESCE (var17,0)+COALESCE (var18,0)+COALESCE (var19,0) as var20
from cert.input04;
quit;

data output13;
set cert.input13;
Chdate=put(date1, date9.);
num1=input(charnum, comma12.);
run;

proc sql;
/* create table output13_sql as */
select *, date1 as chadate format=date9.,
       charnum as num1 format=$comma12.
from cert.input13;
quit;

/* 1.--FULL JOIN-- */
data a;
input ID NAME $ SALARY;
cards;	
1 Rick 623.3		 
2 Dan 515.2 		
3 Mike 611.5 		
4 Ryan 729.1 
5 Gary 843.25 
6 Tusar 578.6 
7 Pranab 632.8 
8 Rasmi 722.5
; 

data b;
input ID DEPT $;
cards;
1 IT 
2 OPS
3 IT 
4 HR 
5 FIN 
6 IT 
7 OPS
8 FIN 
;
run;

proc sql;
create table aa as
select a.id, a.name, a.salary, b.dept
from a
full join
b
on a.id=b.id;
quit;






