"Essa estrutura de controle é particularmente propensa a erros e deve ser substituída por ramificações com variáveis auxiliares explicitamente declaradas.

****************************************************************************
"Ex:
"Abaixo fizenos um loop SELECT, um bloco de instrução só deve ser executado se o conteúdo da coluna CARRID tiver sido alterado.

"ON CHANGE OF:

DATA spfli_wa TYPE spfli.

SELECT *
       FROM spfli
       ORDER BY carrid
       INTO @spfli_wa
  ...

  ON CHANGE OF spfli_wa-carrid.
   ...
  ELSE.
   ...
  ENDON.

ENDSELECT.

****************************************************************************
"A mesma coisa com "IF":

DATA: spfli_wa TYPE spfli,
      carrid_buffer TYPE spfli-carrid.

CLEAR carrid_buffer.

SELECT *
       FROM spfli
       ORDER BY carrid
       INTO @spfli_wa.

  ...

  IF spfli_wa-carrid <> carrid_buffer.
    carrid_buffer = spfli_wa-carrid.
    ...
  ELSE. 
    ... 
  ENDIF.

  ...

ENDSELECT.
