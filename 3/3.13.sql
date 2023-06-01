-- 13) 综合客户表(client)、资产表(property)、理财产品表(finances_product)、
--     保险表(insurance)、基金表(fund)和投资资产表(property)，
--     列出所有客户的编号、名称和总资产，总资产命名为total_property。
--     总资产为储蓄卡余额，投资总额，投资总收益的和，再扣除信用卡透支的金额
--     (信用卡余额即为透支金额)。客户总资产包括被冻结的资产。
--    请用一条SQL语句实现该查询：


SELECT c_id,c_name, 
    ((
      COALESCE((SELECT SUM(pro_quantity * p_amount) FROM finances_product,property WHERE pro_type = 1 AND pro_pif_id = p_id AND pro_c_id = c_id),0) +
      COALESCE((SELECT SUM(pro_quantity * i_amount) FROM insurance,property WHERE pro_type = 2 AND pro_pif_id = i_id AND pro_c_id = c_id),0) +
      COALESCE((SELECT SUM(pro_quantity * f_amount) FROM fund,property WHERE pro_type = 3 AND pro_pif_id = f_id AND pro_c_id = c_id),0) +
      COALESCE((SELECT SUM(pro_income) FROM property 
      WHERE pro_c_id = c_id),0)) + 
      (
          COALESCE((SELECT SUM(b_balance) FROM bank_card WHERE b_c_id = c_id AND b_type = '储蓄卡'),0) - 
          COALESCE((SELECT SUM(b_balance) FROM bank_card WHERE b_c_id = c_id AND b_type = '信用卡'),0) 
        )) AS total_property
FROM client
ORDER BY c_id ASC;





/*  end  of  your code  */ 