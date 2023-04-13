"O que o programa faz: Recebe um número como parâmetro, o coloca dentro de três variáveis de forma formatada, isto é: (sem pontos, sem espaços e preenchendo as posições
                       "vazias das variáveis com zeros). 

REPORT zteste_wesley_adiciona_zeros.

PARAMETERS p_valor TYPE dmbtr.

DATA: lv_teste_206 TYPE j_1bxt206,  "Char de 18 posições
      lv_teste_207 TYPE j_1bxt207,  "Char de 18 posições
      lv_teste_208 TYPE j_1bfil171. "Char de 171 posições

START-OF-SELECTION.

  PERFORM converte_valor USING: p_valor CHANGING lv_teste_206,
                                p_valor CHANGING lv_teste_207,
                                p_valor CHANGING lv_teste_208.

  WRITE: lv_teste_206, lv_teste_207, lv_teste_208.

*&---------------------------------------------------------------------*
*&      Form  CONVERTE_VALOR
*&---------------------------------------------------------------------*
FORM converte_valor  USING    p_valor
                     CHANGING p_field .
  DATA lv_field TYPE char18.
  lv_field =  p_valor.

  SHIFT p_field LEFT DELETING LEADING '0'. "Deleta todos os zeros.
  REPLACE '.' WITH ' ' INTO lv_field.      "Onde tiver ponto substiui por espaço.
  CONDENSE lv_field   NO-GAPS.             "Tira todos os espaços.
  SHIFT lv_field LEFT DELETING LEADING space.
  TRANSLATE lv_field   USING ' 0'.         "Adiciona zeros nas posições vazias da variável.

  p_field = lv_field.
  TRANSLATE p_field   USING ' 0'.
ENDFORM.                    " CONVERTE_VALOR
