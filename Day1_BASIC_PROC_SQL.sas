/* SO | SELECT */
/* FEW | FROM  */
/* WORKERS | WHERE */
/* GO | GROUP BY */
/* HOME | HAVING */
/* ON TIME | ORDER BY */


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

data c;
merge a b;
by ID;
run;

proc sql;
create table c as /* create a new dataset */
select a.id, a.name, a.salary, b.dept /* "*" stands for all variables */
from a full join b 
on a.id=b.id
order by id; 
quit;


DATA ITDEPT; 
   INPUT empid ename $ salary  ; 
DATALINES; 
1 Rick 623.3 
3 Mike 611.5 
6 Tusar 578.6 
; 
RUN; 
DATA NON_ITDEPT; 
   INPUT empid empname $ salary  ; 
DATALINES; 
2 Dan 515.2 
4 Ryan 729.1 
5 Gary 843.25 
7 Pranab 632.8 
8 Rasmi 722.5 
RUN; 

data concatenate_rename;
set ITDEPT NON_ITDEPT(rename=(empname=ename));
run;

proc sql;
create table CONCATENATE__rename_SQL as
select * from ITDEPT
outer union corr
select empname as ename, empid, salary    
from NON_ITDEPT
order by empid;
quit;


/* 2--CONCATENATE the above dataset-- */
DATA ITDEPT; 
   INPUT empid name $ salary DOJ date9.  ; 
DATALINES; 
1 Rick 623.3 02APR2001
3 Mike 611.5 21OCT2000
6 Tusar 578.6 01MAR2009 
; 
RUN; 
DATA NON_ITDEPT; 
   INPUT empid name $ salary  ; 
DATALINES; 
2 Dan 515.2 
4 Ryan 729.1 
5 Gary 843.25 
7 Pranab 632.8 
8 Rasmi 722.5 
;
RUN; 

data CONCATENATE;
set ITDEPT NON_ITDEPT;
run;

proc sql;
create table CONCATENATE_SQL as
select * from ITDEPT
outer union corr
select * from NON_ITDEPT
order by empid;
quit;


proc sql;
create table CONCATENATE_SQL as
select * from ITDEPT
union 
select * from ITDEPT;
quit;

libname cert "/home/u44723226/ECRBM6/data/cert/input";

proc print data=cert.input04;
run;

proc contents data=cert.input04; run;

data a;
set cert.input04;
var20=sum(of var12-var20);
run;

* The COALESCE function will also work in SQL Server. But will also work in standard SQL database systems;
proc sql;
create table output04 as
select *, 
round(var1*var2) as var3, COALESCE(var12,0)+COALESCE(var13,0)+COALESCE(var14,0)
+COALESCE(var15,0)+COALESCE(var16,0)+COALESCE(var17,0)+COALESCE(var18,0)+COALESCE(var19,0) as var20
from cert.input04;
quit;

/* Combine data sets cert.input08a and cert.input08b by matching values of the ID variable. */
/* Write only observations that are in both data sets to a new data set named results.match08. */
/* Write all other non-matching observations from either data set to a new data set named results.nomatch08. */
/* Exclude all variables that begin with "ex" from results.nomatch08. */

data match nomatch(drop=ex:);
merge cert.input08a(in=a) cert.input08b(in=b);
if a and b then output match;
else output nomatch;
run;


































