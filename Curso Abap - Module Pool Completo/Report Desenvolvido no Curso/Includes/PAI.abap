*&---------------------------------------------------------------------*
*&  Include           MZAULAI01
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE lv_okcode_100.
    WHEN 'VIEWVOO'.
      PERFORM: f_detalhe_do_voo.

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

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0300 INPUT.

  CASE lv_okcode_300.
    WHEN 'BACK'.
      lo_grid_300->free( ). "Limpa o conteúdo do grid.
      lo_container_300->free( ). "Limpa o conteúdo do container.

      FREE: lo_grid_300, lo_container_300. "Tira a referência da memória.

      LEAVE TO SCREEN 0. "Volta para a tela anterior.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
