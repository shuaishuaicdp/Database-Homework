  -- 20) 查询销售总额前三的理财产品
--   请用一条SQL语句实现该查询：



SELECT EXTRACT(YEAR FROM pro_purchase_time) AS pyear, rk, p_id, sumamount
FROM (
        SELECT pro_purchase_time, 
         RANK() OVER (PARTITION BY EXTRACT(YEAR FROM pro_purchase_time) ORDER BY sum(pro_quantity * p_amount) DESC) AS rk, 
         p_id, 
         SUM(pro_quantity * p_amount) AS sumamount
  FROM property 
  JOIN finances_product ON property.pro_pif_id = finances_product.p_id
  WHERE pro_type = 1
  GROUP BY pro_purchase_time,p_id
) AS subquery
WHERE rk <= 3 AND pyear BETWEEN 2010 AND 2011
ORDER BY pyear ASC, rk ASC, p_id ASC;



--/*  end  of  your code  */