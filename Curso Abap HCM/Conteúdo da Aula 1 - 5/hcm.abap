*Transações de HCM abordadas na aula:
"SE36 - criar, visualizar e editar tabelas lógicas.

*O que são tabelas lógicas:
"No SAP HCM (Human Capital Management), tabelas lógicas são utilizadas para simplificar a gestão de dados de recursos humanos. Elas permitem que você acesse informações armazenadas em várias tabelas físicas através de uma única interface lógica. Isso facilita a consulta e manipulação de dados sem a necessidade de lidar diretamente com a complexidade das tabelas subjacentes.

*Tabelas lógicas:
"PNP - tabela lógica para reculperar informações do submódulo PA.
"PNPCE - tabela lógica para reculperar informações do submódulo PA e TM (é uma versão melhorada da PNP).
"PCH - tabela lógica para reculperar informações do submódulo OM.
"PAP - tabela lógica para reculperar informações de recrutamento. 

*Comandos Abap específicos do módulo HCM:
"INFOTYPES - serve para declarar no código os infotipos que usaremos.
"PROVIDE - serve para ler os dados de um infotipo ou vários infotipos ao mesmo tempo (funciona como um loop).
"GET - Lê um registro UMA tabela e para cada registro, o bloco de código subsequente é executado (comando não exclusivo somente do HCM). 

*Tabela/campo inpotante no HCM:
"PENR - PERNR é um identificador único atribuído a cada funcionário dentro do sistema SAP HCM. Ele é um campo chave para talvez todas as tabelas do HCM (PERNR também é uma tabela).

*Temas importantes abordados na aula:
"Criando um report que usa tabela lógica de HCM (criação do primeiro repor para HCM).

"Reports criados:
**********************************************************************************************************************************************************

"Report 1:
REPORT Z_TESTE_WESLEY.

"O Infotype 0001 (Organizational Assignment) é declarado, indicando que os dados deste Infotype serão utilizados no report:
INFOTYPES: 0001.

"A tabela de banco de dados padrão PERNR é declarada. Esta tabela contém o número de identificação dos funcionários.
TABLES: pernr.

START-OF-SELECTION.

"O comando GET lê os dados de cada registro da tabela PERNR em uma iteração. Cada vez que um número de funcionário é lido, o bloco de código subsequente 
"é executado:
GET pernr.

"O comando PROVIDE é utilizado para ler dados de um ou mais Infotypes para um período especificado:
PROVIDE * FROM P0001 BETWEEN pn-begda AND pn-endda.

  WRITE:/ p0001-pernr,
          p0001-stell,
          p0001-begda.

ENDPROVIDE.

"Explicação do report 1:
"O que o report acima faz: Este report lê os registros de funcionários a partir da tabela PERNR. Para cada funcionário, ele obtém os dados do Infotype 
"0001 (P0001) dentro do período especificado (pn-begda e pn-endda). Em seguida, ele exibe na tela o número de identificação do funcionário (PERNR), a 
"posição (STELL) e a data de início (BEGDA).
**********************************************************************************************************************************************************

"Report 2:
REPORT Z_TESTE_WESLEY.

"O Infotype 0001 (Organizational Assignment) é declarado, indicando que os dados deste Infotype serão utilizados no report:
INFOTYPES: 0001.

"A tabela de banco de dados padrão PERNR é declarada. Esta tabela contém o número de identificação dos funcionários.
TABLES: pernr.

START-OF-SELECTION.

"O comando GET lê os dados de cada registro da tabela PERNR em uma iteração. Cada vez que um número de funcionário é lido, o bloco de código subsequente
"é executado:
GET pernr.

"Makro rp_provide_from_last, serve para reculperar o registro mais recente de um infotipo.
"p0001 é o infotipo que estamos acessando.
"space indica que o infotipo não possui nenhum subtipo. Caso possisse, deveria colocar o subtipo no lugar do comando space.
"pn-begda pn-endda indica o período que estou querendo acessar do infotipo.
rp_provide_from_last p0001 space pn-begda pn-endda.
 "pnp-sw-found = 1 sinaliza que foi encontrado um registro na makro.
 IF pnp-sw-found = 1.
   WRITE:/ pernr-pernr,
           p0001-stell,
           pn-begda,
           pn-endda.
 ELSE.
   "REJECT é semelhante ao comando CONTINUE.
   REJECT.
 ENDIF.
