alter table articulos add cou char(32);
alter table art_upd_tempo add cou char(32);
alter table art_tempo add cou char(32);

alter table articulos add index idx_articulos_cou (cou asc);
alter table art_upd_tempo add index idx_art_upd_tempo_cou (cou asc);
alter table art_tempo add index idx_art_tempo_cou (cou asc);