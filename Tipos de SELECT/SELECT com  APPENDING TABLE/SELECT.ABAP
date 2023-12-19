  SELECT *
    FROM vbup
    APPENDING TABLE pt_vbup
    FOR ALL ENTRIES IN pt_lips
    WHERE vbeln EQ pt_lips-vgbel.

"O APPENDING TABLE vai adicionar os novos dados em uma tebela interna sem sobreescrever os dados já existentes nela, diferente do INTO TABLE.
