 -- 12) 综合客户表(client)、资产表(property)、理财产品表(finances_product)、保险表(insurance)和
 --     基金表(fund)，列出客户的名称、身份证号以及投资总金额（即投资本金，
 --     每笔投资金额=商品数量*该产品每份金额)，注意投资金额按类型需要查询不同的表，
 --     投资总金额是客户购买的各类资产(理财,保险,基金)投资金额的总和，总金额命名为total_amount。
 --     查询结果按总金额降序排序。
 -- 请用一条SQL语句实现该查询：




SELECT c_name, c_id_card, 
    (
      COALESCE((SELECT SUM(pro_quantity * p_amount) FROM finances_product,property WHERE pro_type = 1 AND pro_pif_id = p_id AND pro_c_id = c_id),0) +
      COALESCE((SELECT SUM(pro_quantity * i_amount) FROM insurance,property WHERE pro_type = 2 AND pro_pif_id = i_id AND pro_c_id = c_id),0) +
      COALESCE((SELECT SUM(pro_quantity * f_amount) FROM fund,property WHERE pro_type = 3 AND pro_pif_id = f_id AND pro_c_id = c_id),0)
    ) AS total_amount
FROM client
ORDER BY total_amount DESC;




/*  end  of  your code  */ 