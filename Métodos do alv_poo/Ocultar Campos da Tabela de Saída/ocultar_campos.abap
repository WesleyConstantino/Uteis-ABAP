"Ocultar campos da t_out na exibição:

lo_table->get_columns( )->get_column( 'NOME DO CAMPO A SER OCULTADO DA T_OUT' )->set_visible( abap_false ). 

*Obs: #Chamar o método apenas depois de declarar a lo_table.
*     #O NOME DO CAMPO A SER OCULTADO DA T_OUT passado dentro dos parêntesis em aspas simples deve estar sempre em MAIUSCÚLO.
