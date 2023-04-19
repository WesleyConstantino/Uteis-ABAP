*&---------------------------------------------------------------------*
*&  Include           MZAULAI01
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE lo_okcode_100.
    WHEN 'EXIT'.
      lo_grid_100->free( ). "Limpa o conteúdo do grid.
      lo_container_100->free( ). "Limpa o conteúdo do container.

      FREE: lo_grid_100, lo_container_100. "Tira a referência da memória.

      LEAVE PROGRAM. "Sai do programa.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE lv_okcode_200.
    WHEN 'CANCEL'.
      lo_grid_200->free( ). "Limpa o conteúdo do grid.
      lo_container_200->free( ). "Limpa o conteúdo do container.

      FREE: lo_grid_200, lo_container_200. "Tira a referência da memória.

      LEAVE TO SCREEN 0. "Volta para a tela anterior.
  ENDCASE.

ENDMODULE.
