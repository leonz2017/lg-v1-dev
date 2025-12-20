CREATE PROCEDURE `art_upd_tempo_insert`(
	pIdArticulo int, 
    pIdProv int, 
    pStock varchar(10), 
    pCodigo varchar(40),
    pCodArt varchar(20), 
    pArticulo varchar(200), 
    pLinea varchar(60),
    pRubro varchar(60), 
    pVenta decimal(18, 2), 
    pLista decimal(18, 2), 
    pCosto decimal(18, 2),
    pBonif1 decimal(5, 2),
    pBonif2 decimal(5, 2),
    pBonif3 decimal(5, 2),
    pBonif4 decimal(5, 2),
    pMargenMay decimal(5, 2),
    pMargenMin decimal(5, 2)
)
begin
	declare vIdArticulo int;
    declare vEsNuevo bit;
	declare mensaje text;
    declare vDuplicado bit;
    declare vCOU char(32);
	declare exit handler for sqlexception
    begin
        get diagnostics condition 1 mensaje = message_text;
        call art_upd_log_insert ('art_upd_tempo_insert', mensaje);
        select mensaje as result;
    end;
    
    -- Genero el COU del artículo para validar
    set vCOU = art_generar_cdp (pIdProv, pCodigo, pArticulo);
    
    -- Localizo el ID artículo para verificar si se trata
    -- de un producto nuevo o que ya existe.
    select 
		min(articulos.idArticulo)
	into 
		vIdArticulo
    from 
		articulos
    where 
		articulos.cou = vCOU and		-- Reemplazo codArtPV por cou
		articulos.idprov = pIdProv and
		articulos.fecBaja is null
	group by
		articulos.cou;
    
    if (vIdArticulo is null) then
		set vEsNuevo = 1;
	else
		set vEsNuevo = 0;
    end if;
    
    -- Antes de insertar el registro verifico que el mismo no se encuentre
    -- duplicado por su COU.
    select
		case when count(*) > 0 then 1 else 0 end
	into
		vDuplicado
	from
		art_upd_tempo
	where art_upd_tempo.cou = vCOU and -- Reemplazo codigo por COU
		art_upd_tempo.idProv = pIdProv;
    
    if vDuplicado = 0 then
		insert into art_upd_tempo (
			idArticulo, idProv, stock, codigo, codArt, articulo, linea, rubro,
			venta, lista, bonif1, bonif2, bonif3, bonif4, margenMax, margenMin, costo, esNuevo, cou)
		values (
			vIdArticulo, pIdProv, pStock, ucase(pCodigo), ucase(pCodArt), ucase(pArticulo), pLinea, pRubro,
			pVenta, pLista, pBonif1, pBonif2, pBonif3, pBonif4, pMargenMay, pMargenMin, pCosto, vEsNuevo, vCOU);
	end if;
    select 'OK' as result;
end