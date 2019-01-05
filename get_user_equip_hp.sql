select myid,myhp1+myhp2+myhp3 as sum
from(select all_temp.myid,all_temp.myhp1,all_temp.myhp2,hp3 as myhp3
from (select tem.user_id as myid,hp1 as myhp1,hp2 as myhp2
  from (select user_id,eq_hp_add as hp1
        from status_table,equipment_table
        where status_equip_hand=eq_id)as tem,
      (select user_id,eq_hp_add as hp2
        from status_table,equipment_table
        where status_equip_body=eq_id)as tem2
  where tem.user_id=tem2.user_id)as all_temp,
     (select user_id,eq_hp_add as hp3
       from status_table,equipment_table
       where status_equip_necklace=eq_id)as tem3
where myid=user_id) as result


