*Comandos usados no RAP:
"Esses códigos são exemplos clássicos de uso da EML (Entity Manipulation Language) no ABAP "RESTful Application Programming Model (RAP) para atualizar dados de uma entidade de negócio.


"Declaração das tabelas de IMPORT e RESULT:
DATA input_keys TYPE TABLE FOR READ IMPORT /DMO/I_AgencyTP.
DATA result_tab TYPE TABLE FOR READ RESULT /DMO/I_AgencyTP.


"Aqui você cria uma tabela interna de chaves:  
input_keys = VALUE #( ( agencyid = '070050' ) ).


     "Indica que a leitura acontece no Business Object definido pela interface CDS:
     READ ENTRIES OF /dmo/i_agencytp
        "Define qual entidade do BO será lida:
        ENTITY /dmo/agency
        "ndica que todos os campos da entidade devem ser retornados:
        ALL FIELDS 
          "Recebe o resultado da leitura:
          WITH result_tab.
