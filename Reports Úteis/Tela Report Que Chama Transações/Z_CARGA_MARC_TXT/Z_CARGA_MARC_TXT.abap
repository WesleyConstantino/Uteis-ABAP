*&---------------------------------------------------------------------*
*& Report Z_CARGA_MARC_TXT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_CARGA_MARC_TXT.

INCLUDE zi_top_txt.
INCLUDE zi_tela_txt.
INCLUDE zi_classes_txt.

*Evento para trazer o caminho do download
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_upld.
  DATA ol_upload TYPE REF TO lcl_upload.
  CREATE OBJECT ol_upload.

  "Seleciona o arquivo de upload
  ol_upload->seleciona_arquivo(
    CHANGING
      i_upld = p_upld
  ).
