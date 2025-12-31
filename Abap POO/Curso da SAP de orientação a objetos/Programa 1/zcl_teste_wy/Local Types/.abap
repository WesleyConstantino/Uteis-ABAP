*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_connection definition.

  public section.

   DATA carrier_id    TYPE S_CARR_ID.
   DATA connection_id TYPE S_CONN_ID.

   CLASS-DATA conn_counter TYPE i.

  protected section.
  private section.

endclass.

class lcl_connection implementation.

endclass.
