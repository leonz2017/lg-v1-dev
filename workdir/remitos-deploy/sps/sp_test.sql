DELIMITER $$
DROP PROCEDURE IF EXISTS test $$

CREATE PROCEDURE IF NOT EXISTS test()
BEGIN
	SELECT 'Prueba de modificación de un procedimiento almacenado';
END