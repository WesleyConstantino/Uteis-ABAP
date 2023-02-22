*Introdução ao Field-Symbol:
"Os Field-Symbols funcionam como uma de workarea

"------------------------------------------------
"Exemplo de trecho de código:--------------------

"Declaração:
FIELD-SYMBOLS <fs_out> TYPE ty_out.  
"----------------------------------

SELECT mara~matnr        
       makt~maktx         
       mara~ersda         
       mara~ernam  
       FROM mara INNER JOIN makt ON makt~matnr = mara~matnr 
       INTO TABLE t_out  WHERE mara~matnr IN s_matnr  AND makt~spras = 'P'.  

"Populando o Field-Symbol com o Read com os dados da t_out. Também pode der feito com um Loop AT
READ TABLE t_out ASSIGNING <fs_out> WITH KEY matnr = '0000-0158-9'. 
"------------------------------------------------------------------------------------------------

"É importante verificar se o Field-Symbol está assinado(recebeu os valores) para evitar dumps
 IF <fs_out> IS ASSIGNED.    
 <fs_out>-maktx = 'TESTE FIELD SYMBOL'. "Passando valor para um campo do Field-Symbol
 ENDIF.  
 "---------------------------------------------------------------------------------------------

"Limpa Field-Symbol sem apagar a útima linha
UNASSIGN <fs_out>.
"--------------------------------------------
