A instrução COLLECT em ABAP é usada para criar uma tabela interna ou somar valores em uma tabela interna existente, geralmente com base em critérios específicos. Ela permite consolidar informações em uma tabela interna de resumo. Aqui estão os passos básicos para usar a instrução COLLECT no ABAP:

Crie ou defina uma tabela interna: Antes de usar o COLLECT, você precisa ter uma tabela interna onde os valores serão armazenados ou onde você deseja somar valores. Você pode criar uma tabela interna usando a declaração DATA ou trabalhar com uma tabela interna existente.

Preencha os dados na tabela interna: Preencha a tabela interna com os dados relevantes. Os dados podem ser provenientes de várias fontes, como leitura de um banco de dados, entrada do usuário ou cálculos.

Use a instrução COLLECT: Use a instrução COLLECT para somar ou agregar valores com base em critérios específicos. A sintaxe básica é a seguinte:

abap
Copy code
COLLECT <valor> INTO <tabela_interna>
       WHERE <condições>.
<valor>: O valor que você deseja somar ou agregar.
<tabela_interna>: A tabela interna onde os valores serão armazenados ou somados.
<condições>: As condições que determinam quais registros da tabela interna serão afetados pela operação COLLECT.
Exemplo de COLLECT:

Suponha que você tenha uma tabela interna chamada lt_dados e deseje somar os valores do campo valor com base no valor do campo categoria. Você pode usar a instrução COLLECT da seguinte forma:

abap
Copy code
LOOP AT lt_dados.
  COLLECT lt_dados-valor INTO lt_resumo
         WHERE categoria = lt_dados-categoria.
ENDLOOP.
Neste exemplo, a instrução COLLECT somará os valores do campo valor para cada categoria única na tabela interna lt_dados e armazenará o resultado na tabela interna lt_resumo.

Resultado:

Depois de usar o COLLECT, você terá uma tabela interna, como lt_resumo, que conterá os valores somados ou agregados com base nas condições especificadas.

Lembre-se de que a instrução COLLECT é útil quando você precisa resumir dados com base em critérios específicos, como categorias, valores, datas, etc. Certifique-se de adaptar os critérios e a lógica à sua necessidade específica.
