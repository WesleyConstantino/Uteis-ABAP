  SELECT SUM( olikw ) SUM( ofakw )
  INTO (l_olikw, l_ofakw)
  FROM s067
  WHERE knkli = w_cliente_gen-kunnr AND
  kkber = p_kkber.
