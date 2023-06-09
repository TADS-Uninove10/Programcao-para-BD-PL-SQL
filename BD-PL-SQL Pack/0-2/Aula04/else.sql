CREATE TABLE ALUNO (
RA NUMBER(9),
DISCIPLINA VARCHAR2(30),
MEDIA NUMBER(3,1),
CARGA_HORA NUMBER(2),
FALTAS NUMBER(2),
RESULTADO VARCHAR2(10));



INSERT INTO ALUNO VALUES (1,'Matem�tica',7.5,80,20,NULL);
INSERT INTO ALUNO VALUES (2,'Portugu�s',7.5,80,21,NULL);
INSERT INTO ALUNO VALUES (3,'Ingl�s',6.5,80,20,NULL);


declare
       vRESULTADO ALUNO.RESULTADO%TYPE;
       vFALTAS ALUNO.FALTAS%TYPE;
       vMEDIA ALUNO.MEDIA%TYPE;
       vRA ALUNO.RA%TYPE:1;
       vCARAGAHORA ALUNO.CARGA_HORA%TYPE;
       BEGIN
          SELECT CARAGA_HORA INTO v.CARGAHORA;
          SELECT FALTAS INTO vFALTAS;
          SELECT MEDIA INTO vMEDIA;
          FROM ALUNO WHERE vRA = RA;
          
          IF v.FALTAS * 25/100 < vCARAGAHORA;
          ELSIF v.MEDIA <7.0 
          THEN v.RESULTADO :='REPROVADO';
          ELSE v.RESULTADO :='APROVADO';
          
          END IF;
                    
           IF v.FALTAS * 25/100 > vCARAGAHORA;
          THEN v.RESULTADO :='REPROVADO';
          END IF;
          
          DBMS_OUTPUT.PUT_LINE('RESULTADO'||v.RESULTADO);
          
          END;
          
          
          
          