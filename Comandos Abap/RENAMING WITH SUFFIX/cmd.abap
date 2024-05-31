"O camndo RENAMING WITH SUFFIX serve para acrescentar um sufixo aos nomes de campos de uma estrutura. Isso serve para não
"gerar conflitos de nomes iguais. Segue o exemplo abaixo:  


*&---------------------------------------------------------------------*
*& Report Z_TESTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_TESTE.

"Criação da workarea ls_ekkoekpo:
  DATA BEGIN OF ls_ekkoekpo.
          INCLUDE STRUCTURE ekko AS ekko RENAMING WITH SUFFIX _ekko.
          INCLUDE STRUCTURE ekpo AS ekpo RENAMING WITH SUFFIX _ekpo.
  DATA END OF ls_ekkoekpo.

"Atribuindo valor a dois campos que teriam nomes iguais se não usassemos o comando RENAMING WITH SUFFIX:
ls_ekkoekpo-adrnr_ekko = ' '.
ls_ekkoekpo-adrnr_ekpo = ' '.
