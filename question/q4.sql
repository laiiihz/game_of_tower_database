/*
 查找所有拥有攻击加成超过90的武器的公会会长。
 */

select union_chairman,status_ack,user_level,(status_ack-user_level*100) as ack_add
from union_table,status_table,user_table
where union_chairman=status_table.user_id and
      union_chairman=user_table.user_id and
      (status_ack-user_level*100)>90
