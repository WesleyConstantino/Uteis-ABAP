*Classes abstratas

"São classes que servem como base para outras classes, não podem ser instanciadas,
são classes incompletas.

REPORT ZR_CLASSES_ABSTRATAS.

*IMPLEMENTAÇÕES DE CLASSES:
*zcl_trabalhador *CLASSE ABSTRATA
CLASS zcl_trabalhador DEFINITION ABSTRACT. "Indicamos uma classe abstrata com o comando ABSTRACT.
 PUBLIC SECTION.
 DATA salario TYPE CHAR10.
 METHODS trabalhar ABSTRACT. "Indicamos um método abstrata com o comando ABSTRACT.

ENDCLASS.

*zcl_engenheiro
CLASS zcl_engenheiro DEFINITION INHERITING FROM zcl_trabalhador.
 PUBLIC SECTION.
  METHODS: trabalhar REDEFINITION. "Indicamos a redefinição de um método abstrato com o comando REDEFINITION.
ENDCLASS.

*zcl_medico
CLASS zcl_medico DEFINITION INHERITING FROM zcl_trabalhador.
 PUBLIC SECTION.
  METHODS: trabalhar REDEFINITION.
ENDCLASS.

*DEFINIÇÕES DE CLASSES:
*zcl_engenheiro
CLASS zcl_engenheiro IMPLEMENTATION.
  METHOD trabalhar.
    WRITE:/ 'Planejar construção de obra.'.
  ENDMETHOD.
ENDCLASS.

*zcl_medico
CLASS zcl_medico  IMPLEMENTATION.
  METHOD trabalhar.
    WRITE:/ 'Atender paciente.'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA: ol_engenheiro TYPE REF TO zcl_engenheiro,
        ol_medico     TYPE REF TO zcl_medico.

  ol_engenheiro = NEW zcl_engenheiro( ).
  ol_medico     = NEW zcl_medico( ).

  ol_engenheiro->salario = '5.000'.
  ol_medico->salario = '10.000'.

  ol_engenheiro->trabalhar( ).
  ol_medico->trabalhar( ).
