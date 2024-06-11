"INFOTYPES - serve para declarar no código os infotipos que usaremos.
"Ex do uso do comando INFOTYPES: "INFOTYPES: 0001."

*Campo de tabela inpotante no HCM:
"PENR - PERNR é um identificador único atribuído a cada funcionário dentro do sistema SAP HCM. Ele é um campo chave para talvez todas as tabelas do HCM.

*Temas importantes abordados na aula:
"Criando um report que usa tabela lógica de HCM (criação do primeiro repor para HCM).

"Reports criados:

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
