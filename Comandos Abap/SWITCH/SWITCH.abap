"Este comando funciona como um CASE. A diferença é que pode ser feito de forma in line, como abaixo:

  DATA(v_switch) = SWITCH #( v_day_number WHEN 1 THEN 'Segunda-feira'
                                          WHEN 2 THEN 'Trça-feira'
                                          WHEN 3 THEN 'Quarta-feira'
                                          WHEN 4 THEN 'Quinta-feira'
                                          WHEN 6 THEN 'Sexta-feira'
                                          WHEN 7 THEN 'Sábado'
                                          ELSE 'Domingo' ).
