Rem Copyright (c) 1990, 2006, Oracle. All rights reserved.  
Rem NAME
REM    UTLSAMPL.SQL
Rem  FUNCTION
Rem  NOTES
Rem  MODIFIED
Rem     lburgess   04/02/06  - lowercase passwords 
Rem     menash     02/21/01 -  remove unnecessary users for security reasons
Rem     gwood      03/23/99 -  make all dates Y2K compliant
Rem     jbellemo   02/27/97 -  dont connect as system
Rem     akolk      08/06/96 -  bug 368261: Adding date formats
Rem     glumpkin   10/21/92 -  Renamed from SQLBLD.SQL 
Rem     blinden   07/27/92 -  Added primary and foreign keys to EMP and DEPT
Rem     rlim       04/29/91 -         change char to varchar2 
Rem     mmoore     04/08/91 -         use unlimited tablespace priv 
Rem     pritto     04/04/91 -         change SYSDATE to 13-JUL-87 
Rem   Mendels    12/07/90 - bug 30123;add to_date calls so language independent
Rem
rem 
rem $Header: utlsampl.sql 02-apr-2006.21:13:01 lburgess Exp $ sqlbld.sql 
rem 
SET TERMOUT OFF
SET ECHO OFF

rem CONGDON    Invoked in RDBMS at build time.   29-DEC-1988
rem OATES:     Created: 16-Feb-83
 
DROP USER SCOTT CASCADE;
DROP USER ADAMS CASCADE;
DROP USER JONES CASCADE;
DROP USER CLARK CASCADE;
DROP USER BLAKE CASCADE;
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT IDENTIFIED BY tiger;
DROP PUBLIC SYNONYM PARTS;

CONNECT SCOTT/tiger
CREATE TABLE DEPT
       (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14) ,
	LOC VARCHAR2(13) ) ;
CREATE TABLE EMP
       (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
INSERT INTO DEPT VALUES
	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
	(40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87','dd-mm-rr')-85,3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87', 'dd-mm-rr')-51,1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
CREATE TABLE BONUS
	(
	ENAME VARCHAR2(10)	,
	JOB VARCHAR2(9)  ,
	SAL NUMBER,
	COMM NUMBER
	) ;
CREATE TABLE SALGRADE
      ( GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER );
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;

/*________________________________________________________________________________________________________________________
__________________________________________________________________________________________________________________________
_____________________                                                            __________________________-______________
_____________________    AULA 13 EXE��ES                                                          _________________________________________
_________________________________________________________________________________________________________________________
__________________________________________________________________________________________________________________________
*/
set serveroutputon

DECLARE
aux_salarioemp.sal%type;
aux_faixasalgrade.grade%type;
BEGIN
select e.sal
,s.grade
into aux_salario
,aux_faixa
fromempe
,salgrades
where e.sal between s.losaland s.hisal
and e.empno= &prm_empno;

if aux_faixa= 1 then
aux_salario:= aux_salario* 1.1;
elsifaux_faixa= 2 then
aux_salario:= aux_salario* 1.2;
elsifaux_faixa= 3 then
aux_salario:= aux_salario* 1.3;
elsifaux_faixa= 4 then
aux_salario:= aux_salario* 1.4;
elsifaux_faixa= 5 then
aux_salario:= aux_salario* 1.5;
end if;

dbms_output.put_line('Salariode ' ||to_char(aux_salario));

exception
when no_data_foundthen
dbms_output.put_line('Empregado n�o cadastrado ou '
||' n�o se enquadra nas faixas pr�-cadastradas');
when others then
raise_application_error(-20501,'Erro: '||sqlerrm);
END;
/
Enter value for prm_empno: 111
old 12: and e.empno= &prm_empno;
new12: ande.empno= 111;
Empregado n�o cadastrado ou n�o se enquadra nas faixas pr�-cadastradas

PL/SQL procedure successfully completed.
