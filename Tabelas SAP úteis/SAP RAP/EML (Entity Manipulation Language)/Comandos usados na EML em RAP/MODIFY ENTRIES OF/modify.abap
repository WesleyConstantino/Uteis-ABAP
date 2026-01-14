*Comandos usados no RAP:
"Esses códigos são exemplos clássicos de uso da EML (Entity Manipulation Language) no ABAP "RESTful Application Programming Model (RAP) para atualizar dados de uma entidade de negócio.


"Aqui você declara uma tabela interna tipada para UPDATE:
DATA agencies_upd TYPE TABLE FOR UPDATE /DMO/I_AgencyTP.

"Aqui você preenche a tabela interna. Apenas os campos que você pretende atualizar precisam ser preenchidos:   
agencies_upd = VALUE #( ( agencyid = '0700##' name = 'Some fancy new name' ) ).


     "Indica que você está manipulando entidades do Business Object definido pela interface /DMO/I_AgencyTP:
     MODIFY ENTITIES OF /dmo/i_agencytp
       "Define qual entidade dentro do BO será afetada:
        ENTITY /dmo/agency
        "Define explicitamente quais campos podem ser atualizados:
        UPDATE FIELDS ( name )
         "Passa a tabela interna com os dados a serem atualizados:
          WITH agencies_upd.

          "Os dados são efetivamente gravados no banco:
          COMMIT ENTITIES.
