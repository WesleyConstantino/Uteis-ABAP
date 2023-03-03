*Explicação:: O comando PACKAGE SIZE serve para ganho de performance no SELECT; numa tabela com muitos dados, damos o comando PACKAGE SIZE seguido de
            "um número, como no exemplo real abaixo; o número vai indicar a quantidade de dados que o SELECT trará por vez do banco de dados, em vez 
            "de trazer tudo de uma vez. Isso melhora a performance do nosso código.


********************************************************************************************************************************************************
"Exemplo real:
  SELECT vbeln vbeln erdat erzet ernam vbtyp auart augru  lifsk
         faksk vkorg vtweg spart vkgrp vkbur vsbed
         bsark bukrs_vf kunnr
    FROM vbak
    INTO TABLE lt_vbak_aux
    PACKAGE SIZE 1000     "Essa seleção trará dados de 1000 em 1000 do banco de dados
    WHERE erdat    IN s_erdat AND 
          vkorg    IN s_vkorg AND
          vbeln    IN s_vbeln AND
          kunnr    IN s_kunnr AND
          bukrs_vf IN s_bukrs AND
          vtweg    IN s_vtweg AND
          spart    IN s_spart.
