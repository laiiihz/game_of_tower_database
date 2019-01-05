create table enemy_talbe
(
  enemy_id         char(10) charset utf8 not null
    primary key,
  enemy_name       char(10) charset utf8 not null,
  enemy_hp         smallint(6) default 1 not null,
  enemy_mp         smallint(6) default 1 not null,
  enemy_ack        smallint(6) default 1 not null,
  enemy_def        smallint(6) default 1 not null,
  enemy_exp        int         default 0 not null,
  enemy_coin       int         default 0 not null,
  enemy_real_level int         default 1 not null
);

create table equipment_table
(
  eq_id      char(10) charset utf8 not null
    primary key,
  eq_name    char(10) charset utf8 not null,
  eq_cost    smallint(6) default 0 not null comment '0 for "free"',
  eq_sell    smallint(6) default 0 not null comment '0 for "free"',
  eq_type    tinyint     default 0 not null comment '0-not set,1-body,2-weapon,3-necklace',
  eq_hp_add  smallint(6) default 0 not null,
  eq_mp_add  smallint(6) default 0 not null,
  eq_ack_add smallint(6) default 0 not null,
  eq_def_add smallint(6) default 0 not null
);

create table enemy_drop_equip_table
(
  enemy_id        char(10) charset utf8 not null,
  equip_id        char(10) charset utf8 not null,
  ede_probability double default 0      not null,
  primary key (enemy_id, equip_id),
  constraint enemy_drop_equip_table_enemy_talbe_enemy_id_fk
    foreign key (enemy_id) references enemy_talbe (enemy_id)
      on delete cascade,
  constraint enemy_drop_equip_table_equipment_table_eq_id_fk
    foreign key (equip_id) references equipment_table (eq_id)
      on delete cascade
);

create table tools_table
(
  tool_id       char(10) charset utf8 not null
    primary key,
  tool_name     char(10) charset utf8 not null,
  tool_cost     smallint(6) default 0 not null,
  tool_sell     smallint(6) default 0 not null,
  tool_type     tinyint     default 0 not null comment '0-not set,1-blood-heal,2-magic-heal,3-ack-up,
4-def-up,5-others',
  tool_effect   smallint(6) default 0 not null,
  tool_duration double      default 0 not null comment '0 for  Take effect immediately',
  tool_cd       double      default 0 not null comment 'cool duration'
);

create table enemy_drop_tool_table
(
  enemy_id         char(10) charset utf8 not null,
  tool_id          char(10) charset utf8 not null,
  drop_probability double default 0      not null,
  primary key (enemy_id, drop_probability),
  constraint enemy_drop_tool_table_enemy_talbe_enemy_id_fk
    foreign key (enemy_id) references enemy_talbe (enemy_id)
      on delete cascade,
  constraint enemy_drop_tool_table_tools_table_tool_id_fk
    foreign key (tool_id) references tools_table (tool_id)
      on delete cascade
);

create table user_table
(
  user_id       char(10) charset utf8 not null
    primary key,
  user_nickname char(25) charset utf8 not null,
  user_sex      tinyint(1)            not null comment '0 for "女" ,1 for "男"',
  user_level    tinyint    default 1  not null,
  user_exp      int        default 0  not null,
  user_is_union tinyint(1) default 0  not null
)
  comment '用户表';

create table currency_table
(
  user_id        char(10) charset utf8 not null
    primary key,
  currency_coin  int default 0         not null,
  currency_ngots int default 0         not null,
  constraint currency_table_user_table_user_id_fk
    foreign key (user_id) references user_table (user_id)
      on update cascade on delete cascade
)
  comment '货币';

create table pack_equip_table
(
  user_id  char(10) charset utf8 not null,
  equip_id char(10) charset utf8 not null,
  pack_num int default 1         not null,
  primary key (user_id, equip_id),
  constraint pack_equip_table_equipment_table_eq_id_fk
    foreign key (equip_id) references equipment_table (eq_id)
      on delete cascade,
  constraint pack_equip_table_user_table_user_id_fk
    foreign key (user_id) references user_table (user_id)
      on delete cascade
);

create table pack_tool_table
(
  user_id  char(10) charset utf8 not null,
  tool_id  char(10) charset utf8 not null,
  pack_num int default 1         not null,
  primary key (user_id, tool_id),
  constraint pack_tool_table_tools_table_tool_id_fk
    foreign key (tool_id) references tools_table (tool_id)
      on delete cascade,
  constraint pack_tool_table_user_table_user_id_fk
    foreign key (user_id) references user_table (user_id)
      on delete cascade
);

create table status_table
(
  user_id               char(10) charset utf8 not null
    primary key,
  status_hp             smallint(6) default 1 not null,
  status_mp             smallint(6) default 1 null,
  status_ack            smallint(6) default 1 not null,
  status_def            smallint(6) default 1 not null,
  status_equip_hand     char(10) charset utf8 null,
  status_equip_body     char(10) charset utf8 null,
  status_equip_necklace char(10) charset utf8 null,
  constraint equip_table_user_table_user_id_fk
    foreign key (user_id) references user_table (user_id)
      on update cascade on delete cascade,
  constraint status_table_equipment_table_eq_id_fk
    foreign key (status_equip_hand) references equipment_table (eq_id),
  constraint status_table_equipment_table_eq_id_fk_2
    foreign key (status_equip_body) references equipment_table (eq_id),
  constraint status_table_equipment_table_eq_id_fk_3
    foreign key (status_equip_necklace) references equipment_table (eq_id)
);

create table union_table
(
  union_id        char(10) charset utf8              not null
    primary key,
  union_name      char(10) charset utf8              not null,
  union_level     tinyint  default 1                 not null,
  union_exp       int      default 0                 not null,
  union_join_time datetime default CURRENT_TIMESTAMP not null,
  union_nums      int      default 1                 not null,
  union_chairman  char(10) charset utf8              not null,
  union_vice      char(10) charset utf8              not null,
  constraint union_table_user_table_user_id_fk
    foreign key (union_chairman) references user_table (user_id),
  constraint union_table_user_table_user_id_fk_2
    foreign key (union_vice) references user_table (user_id)
)
  comment '工会表';

create table union_user
(
  user_id  char(10) charset utf8 not null
    primary key,
  union_id char(10) charset utf8 not null,
  constraint union_user_union_table_union_id_fk
    foreign key (union_id) references union_table (union_id)
      on delete cascade,
  constraint union_user_user_table_user_id_fk
    foreign key (user_id) references user_table (user_id)
      on delete cascade
);

create procedure pl(IN inid char(10), OUT hp int)
begin

  select adds into hp
  from (select user_table.user_id,sum + user_id * 1000 as adds
        from (select myid,myhp1 + myhp2 + myhp3 as sum
              from (select all_temp.myid,all_temp.myhp1,all_temp.myhp2,hp3 as myhp3
                    from (select tem.user_id as myid,hp1 as myhp1,hp2 as myhp2
                          from (select user_id,eq_hp_add as hp1
                                from status_table,
                                     equipment_table
                                where status_equip_hand = eq_id) as tem,
                               (select user_id,eq_hp_add as hp2
                                from status_table,
                                     equipment_table
                                where status_equip_body = eq_id) as tem2
                          where tem.user_id = tem2.user_id) as all_temp,
                         (select user_id,eq_hp_add as hp3
                          from status_table,
                               equipment_table
                          where status_equip_necklace = eq_id) as tem3
                    where myid = user_id) as result) as all_add,
             user_table
        where all_add.myid = user_table.user_id) as fff
  where user_id = inid;
end;


