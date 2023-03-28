"Para criar um FIELD SYMBOL dessa forma, primeiro preciso declarar a tabela interna que desejo fazer o FIELD SYMBOL, como abaixo:
*-------------------------------------------------------------------------------------------------------------------------------*
        DATA: lt_log_msg TYPE zavtsdt_message_log. "Tabela interna

*-------------------------------------------------------------------------------------------------------------------------------*
"Em seguida, appendo uma linha vazia assinando com o FIELD SYMBOL, como abaixo:
*-------------------------------------------------------------------------------------------------------------------------------*  
        APPEND INITIAL LINE TO lt_log_msg ASSIGNING FIELD-SYMBOL(<lfs_log_msg>).

*-------------------------------------------------------------------------------------------------------------------------------*
"Depois, verifico se o meu FIELD SYMBOL está assinado, como abaixo:
*-------------------------------------------------------------------------------------------------------------------------------*
        IF <lfs_log_msg> IS ASSIGNED.
 
*-------------------------------------------------------------------------------------------------------------------------------* 
"E por fim, atribuo os valores aos campos do meu FIELD SYMBOL, como  abaixo:        
*-------------------------------------------------------------------------------------------------------------------------------*
        <lfs_log_msg>-docnum = s_docnum-low.
        <lfs_log_msg>-idoctp = 'SFDC_NOTAFISCAL'.
        <lfs_log_msg>-status = 'E'.
        <lfs_log_msg>-text = lv_text.
        ENDIF.
 
*-------------------------------------------------------------------------------------------------------------------------------*
 "UNASSIGN limpa o FIELD SYMBOL, é como se fosse uma CLEAR. Usar por boas práticas.
*-------------------------------------------------------------------------------------------------------------------------------*
 UNASSIGN <lfs_log_msg>.
