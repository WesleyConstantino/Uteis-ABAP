"O comando SUBMIT acessa um outro programa e passa valores para ele.

SUBMIT zavtsdr_envio_nf_sfdc WITH s_docnum-low = i_active-docnum
                             WITH s_perio-low  = sy-datum.
               
"Aqui o comando SUBMIT acessa o programa "zavtsdr_envio_nf_sfdc" e preenche os parâmetros da tela de seleção "s_docnum-low" e  "s_perio-low" com os dados "i_active-docnum" 
e "sy-datum".  
