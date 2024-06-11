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

*Campo de tabela inpotante no HCM:
"PENR - PERNR é um identificador único atribuído a cada funcionário dentro do sistema SAP HCM. Ele é um campo chave para talvez todas as tabelas do HCM.

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
