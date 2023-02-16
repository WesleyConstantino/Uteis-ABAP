*Explicação: Sempre que usar "EQ" no campo "option" de um Range, passarei o valor do intervalo somente para o campo "low" e estarei fazendo uma comparação
             "de igualdade, onde posso passar um ou diversos valores para comporem o meu Range; sempre lembrando de appendar os valores para criar uma nova
             "linha sem sobreescrever o anterior. 

"Exemplo:  
ln_matnr-sign = 'I'.  "Aqui fiz um Range com valor estático no sign.
ln_matnr-option = 'EQ'. "Aqui fiz um Range com valor estático no option.
ln_matnr-low = '10'.  "Aqui qureo um valor para cada linha.
APPEND ln_matnr TO lr_matnr.  "Appendo para criar uma linha com os dados acima

ln_matnr-low = '20'. "Aqui quero criar mais uma linha identica a de cima, exeto o valor de "low", que desejo outro.
APPEND ln_matnr TO lr_matnr. "Appendo, e agora tenho duas linha com dois intervalos diferentes no meu Range.

ln_matnr-low = '30'.
APPEND ln_matnr TO lr_matnr.

ln_matnr-low = '40'.
APPEND ln_matnr TO lr_matnr.

ln_matnr-low = '9999'.
APPEND ln_matnr TO lr_matnr.

*O que vai acontecer quando procurar esse Range no SELECT? ___________________________________________
*  
* O Select vai verificar se existe alguns valor igual ao que foi passado a cada um dos campos "low";
* '10', '20', '30', '40' ou '9999'. Isso é bem melhor do que fazer uma gigantesco IF no select!
*
*______________________________________________________________________________________________________
CLEAR ln_matnr. "São boas práticas dar um clear a workarea do Range.


********************************************************************************************************************************************************
********************************************************************************************************************************************************

*-----------* CÓDIGO:

*&---------------------------------------------------------------------*
*                              Ranges                                  *
*&---------------------------------------------------------------------*
DATA lr_matnr TYPE RANGE OF mara-matnr.

*&---------------------------------------------------------------------*
*                            Workareas                                 *
*&---------------------------------------------------------------------*
DATA ln_matnr LIKE LINE OF lr_matnr.

*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT
*&---------------------------------------------------------------------*
FORM zf_selecto.
PERFORM zf_range_estrutura.

IF lr_matnr IS NOT INITIAL.
  SELECT *
    FROM mara
    INTO TABLE @DATA(lt_mara)
    WHERE matnr in @lr_matnr.
ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_RANGE_ESTRUTURA
*&---------------------------------------------------------------------*
FORM zf_range_estrutura.

ln_matnr-sign = 'I'.
ln_matnr-option = 'EQ'.
ln_matnr-low = '10'.
APPEND ln_matnr TO lr_matnr.

ln_matnr-low = '20'.
APPEND ln_matnr TO lr_matnr.

ln_matnr-low = '30'.
APPEND ln_matnr TO lr_matnr.

ln_matnr-low = '40'.
APPEND ln_matnr TO lr_matnr.

ln_matnr-low = '9999'.
APPEND ln_matnr TO lr_matnr.

CLEAR ln_matnr.

ENDFORM.
