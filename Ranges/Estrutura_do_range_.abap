"A estrutura do RANGE consiste nos campos: sign, option, low e high.

*---------------------Definições de cada campo----------------------*
sign: pode receber 'I', que traz tudo que existe dentro do intervalo passado para os outros campos ou 'E', que traz somente o que esteja fora do intervalo.
option: pode receber 'EQ' Igual, 'BT' entre, 'CP' contém padrão.
low: recebe o intervalo menor.
high: recebe o intervalo maior.

*-----------------------Trecho de código real------------------------*
ln_matnr-sign = 'I'. 
ln_matnr-option = 'BT'. "
ln_matnr-low = '10'.
ln_matnr-high = '50'.
