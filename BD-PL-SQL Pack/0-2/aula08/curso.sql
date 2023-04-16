SELECT * FROM aluno;
set serveroutput on;
DECLARE
      CURSOR c_aluno IS
      SELECT RA,DISCIPLINA,MEDIA,CARGA_HORA,FALTAS,RESULTADO FROM aluno;
      v_aluno c_aluno%ROWTYPE;
BEGIN
      OPEN c_aluno;
      LOOP
      FETCH c_aluno INTO v_aluno;
      CASE v_aluno.FALTAS * 25/100 < v_aluno.CARGA_HORA when
                v_aluno.MEDIA <7.0
                THEN v_aluno.RESULTADO :='REPROVADO';
                ELSE v_aluno.RESULTADO :='APROVADO';
          
      end case;
      
      EXIT when c_aluno%notfound;
      DBMS_OUTPUT.PUT_LINE('resultado'|| v_aluno.RESULTADO);
      END LOOP;
      CLOSE c_aluno;
END;
      