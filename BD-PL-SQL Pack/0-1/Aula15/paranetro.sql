
CREATE OR REPLACE PROCEDURE formato_fone
  (p_num_fone IN OUT VARCHAR2) IS
  BEGIN
  p_num_fone := '('  || SUBSTR (p_num_fone,1,3)  ||
                  ') '|| SUBSTR (p_num_fone,4,3)  ||
                  ' _ '|| SUBSTR (p_num_fone,7);
END formato_fone;
/



set serveroutput on
DECLARE
 v_tel varchar(15);
 BEGIN
  v_tel =&prm_tel;
  formato_fone(v_tel);
  DBMS_OUTPUT.PUT_LINE('O novo formato do telefone e' || v_tel);
  END;
 

