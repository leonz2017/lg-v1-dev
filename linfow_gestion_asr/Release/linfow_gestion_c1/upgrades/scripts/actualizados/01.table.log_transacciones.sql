/**
* Creo una tabla log para hacer seguimiento de ejecución SQL
*/

CREATE TABLE IF NOT EXISTS log_transacciones (
	id int not null unique auto_increment comment 'id',
    fecha datetime default current_timestamp comment 'Fecha de transaccion',
    componente varchar(50) not null comment 'Componente desde donde se ejecuta',
    modulo varchar(50) not null comment 'Módulo asociado',
    descripcio varchar(100) not null comment 'Descripción del proceso',
    valoresref text not null comment 'valores de referencia',
    linea_cod int not null comment 'Número de línea de código',
    sql_stmt text not null comment 'sentencia SQL que se ejecuta',
    error_msg text not null comment 'Mensaje de error en caso de fallo',
    primary key (id));
    
    
    