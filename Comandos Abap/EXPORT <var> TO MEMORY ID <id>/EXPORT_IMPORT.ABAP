"Os comandos abaixo, nos permitem transpotar dados de um programa para outro (desde que estejam na mesma pilha de execução).

Ex real: 


"Progrma 1:
*&---------------------------------------------------------------------*
*& Report Z_EXPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_EXPORT.

DATA: v_1(10) TYPE C.

INITIALIZATION.

v_1 = 'Wesley'.

"EXPORT <nome da variável a ser exportada> TO MEMORY ID <'um nome qualquer para ser o id'>.
"O comando abaixo vai exportar os dados de V_1 para o programa chamado pela transação do call transaction:
EXPORT v_1 TO MEMORY ID 'V1'.

CALL TRANSACTION 'ZT_IMPORT'.


************************************************************************************************************
"Progrma 2:
*&---------------------------------------------------------------------*
*& Report Z_IMPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_IMPORT.

"É necessário  criar uma variável com mesmo nome do programa que estiver exportando:
DATA: v_1(10) TYPE C.

START-OF-SELECTION.

IMPORT <mesmo nome da variável do prog que está exportando> FROM MEMORY ID 'mesmo id'.
"O comando abaixo vai trazer os dados passados no export:
IMPORT v_1 FROM MEMORY ID 'V1'.

"O resultado do write abaixo será "Wesley".
WRITE: v_1.




