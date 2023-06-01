-- 9) 查询购买了货币型(f_type='货币型')基金的用户的名称、电话号、邮箱。
--   请用一条SQL语句实现该查询：




SELECT c_name,c_phone,c_mail FROM client
WHERE c_id in(SELECT pro_c_id FROM property
WHERE pro_type = 3 AND EXISTS(SELECT 1 FROM fund WHERE fund.f_id = property.pro_pif_id AND f_type = '货币型'));






/*  end  of  your code  */