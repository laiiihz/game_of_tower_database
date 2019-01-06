/*
 1、查找防御力大于200的80级以上女玩家。
 */
select user_table.user_id,user_level,user_sex,status_def
from user_table,status_table
where user_sex=0 and user_table.user_id=status_table.user_id and user_level>=80 and status_def>=200
