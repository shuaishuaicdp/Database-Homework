     -- 23) 查找相似的理财产品
--   请用一条SQL语句实现该查询：





SELECT DISTINCT pro_pif_id,(SELECT count(pro_c_id) FROM property AS pro_B WHERE pro_B.pro_pif_id = pro_A.pro_pif_id AND pro_B.pro_type = 1 GROUP BY pro_pif_id) as cc,DENSE_RANK() OVER(ORDER BY cc DESC) AS prank FROM property AS pro_A
WHERE pro_type = 1 AND pro_pif_id != 14 AND pro_c_id in 
(SELECT pro_c_id FROM
(SELECT pro_c_id,pro_pif_id, DENSE_RANK() OVER(ORDER BY sum(pro_quantity * p_amount) DESC) AS rk FROM property Join finances_product ON p_id = pro_pif_id 
WHERE pro_type = 1 AND pro_pif_id = 14
GROUP BY pro_pif_id,pro_c_id)
WHERE rk <= 3 
ORDER BY rk ASC,pro_c_id DESC)
GROUP BY pro_pif_id
ORDER BY prank ASC,pro_pif_id ASC;

--/*  end  of  your code  */