*Explicação: para criar um checkbox, basta declará-lo no PARAMETERS tipando-o com um char de uma posição seguido da declaração "AS CHECKBOX".
            "Caso queira que um dos checkboxs fique flegado por padrão, adiciono "DEFAULT 'X'".
            
 
 *-------------------* Trecho de código real:
 
PARAMETERS: c_todos TYPE char1 AS CHECKBOX DEFAULT 'X',
            c_matnr TYPE char1 AS CHECKBOX,
            c_item  TYPE char1 AS CHECKBOX.
