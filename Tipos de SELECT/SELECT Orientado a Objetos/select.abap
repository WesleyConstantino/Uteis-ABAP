select (me->str_select)
  into table it_vbrk
  from vbrk
  where (vl_where)
     and DRAFT = SPACE.
