create function art_cdp_formatear_string (
	xstr varchar(255))
returns varchar(255) deterministic
begin
	set xstr = replace(xstr, ' ', '');
	set xstr = replace(xstr, '(', '');
    set xstr = replace(xstr, ')', '');
    set xstr = replace(xstr, '/', '');
    set xstr = replace(xstr, '.', '');
    set xstr = replace(xstr, '-', '');
	set xstr = replace(xstr, '*', '');
	set xstr = replace(xstr, '\"', '');
	set xstr = replace(xstr, ',', '');
	set xstr = replace(xstr, '\'', '');
	set xstr = replace(xstr, '=>', '');
	set xstr = replace(xstr, ':', '');
	set xstr = replace(xstr, ';', '');
	set xstr = replace(xstr, '>', '');
	set xstr = replace(xstr, '<', '');
	set xstr = replace(xstr, '=', '');
	set xstr = replace(xstr, '+', '');
	set xstr = replace(xstr, '-', '');
    set xstr = replace(xstr, '}', '');
    return xstr;
end