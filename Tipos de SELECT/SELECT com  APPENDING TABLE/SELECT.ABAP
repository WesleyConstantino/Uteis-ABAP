  SELECT *
    FROM vbup
    APPENDING TABLE pt_vbup
    FOR ALL ENTRIES IN pt_lips
    WHERE vbeln EQ pt_lips-vgbel.
