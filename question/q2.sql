/*
 2、设置所有等级低于30的敌人双倍金钱和双倍经验。
 */
update enemy_talbe
set enemy_coin=enemy_coin*2 ,enemy_exp=enemy_exp*2
where enemy_real_level<=30
