CREATE PROCEDURE ventascab_getControlSalida ()
BEGIN
  SELECT
    ventascab.idVentasC,
    ventascab.fecEmision,
    clientes.idCliente,
    clientes.razSoc,
    ventascab.cbte,
    formatear_NroCbte(ventascab.ptovta, ventascab.numCbte) AS numCbte
  FROM ventascab
    INNER JOIN clientes
      ON clientes.idCliente = ventascab.idCliente
  WHERE ventascab.cbte = 'PED'
  AND ventascab.fecBaja IS NULL
  AND ventascab.idVentasC NOT IN (SELECT
      idVtaCO
    FROM ventasrel)
  ORDER BY ventascab.fecEmision DESC, ventascab.idCliente ASC;
END