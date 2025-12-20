alter table articulos add usarMonExt bit not null default 0 after tmon; -- Indica si usa moneda extranjera
alter table articulos add usarImpuIn bit not null default 0 after prfinalMin; -- Indica si usa impuestos internos
alter table articulos add porImpuIn decimal(5, 2) default 0 after usarImpuIn; -- Porcentaje de impuestos internos
alter table articulos add impImInMay decimal (20, 2) default 0 after porImpuIn; -- Importe de impuestos internos mayorista.
alter table articulos add impImInMin decimal (20, 2) default 0 after impImInMay; -- Importe de impuestos internos minorista.
alter table ventascab add totaNoGrav decimal(20, 2) not null default 0 after impDesc4; -- Total no gravado
alter table ventasdet add porNoGrav decimal(5, 2) not null default 0 after impNeto; -- Porcentaje no gravado en el ítem.
alter table ventasdet add baseGrav decimal(20, 2) not null default 0 after porNoGrav; -- Base gravada en el ítem. Queda igual a impNeto
alter table ventasdet add subtNoGrav decimal(20, 2) not null default 0 after baseGrav; -- Base no gravada en el ítem.
