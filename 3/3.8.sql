-- 8) 查询持有两张(含）以上信用卡的用户的名称、身份证号、手机号。
--    请用一条SQL语句实现该查询：


SELECT c_name,c_id_card,c_phone FROM client
WHERE EXISTS(SELECT 1 FROM bank_card WHERE client.c_id = bank_card.b_c_id  AND b_type = '信用卡' GROUP BY b_c_id HAVING COUNT(*) > 1 );



/*  end  of  your code  */