-- 19) 以日历表格式列出2022年2月每周每日基金购买总金额，输出格式如下：
-- week_of_trading Monday Tuesday Wednesday Thursday Friday
--               1
--               2    
--               3
--               4
--   请用一条SQL语句实现该查询：


-- WITH daily_fund AS (SELECT pro_purchase_time,SUM(pro_quantity * f_amount) FROM property JOIN fund ON property.pro_fid_id = fund.f_id WHERE pro_type = 3 GROUP BY pro_purchase_time)
-- SELECT 
SELECT date_part('week', pro_purchase_time)-5 AS week_of_trading,
       NULLIF(SUM(CASE WHEN extract(DOW FROM cast(pro_purchase_time as TIMESTAMP)) = 1 THEN pro_quantity * f_amount ELSE 0 END),0) AS Monday,
       NULLIF(SUM(CASE WHEN extract(DOW FROM cast(pro_purchase_time as TIMESTAMP)) = 2 THEN pro_quantity * f_amount ELSE 0 END),0) AS Tuesday,
       NULLIF(SUM(CASE WHEN extract(DOW FROM cast(pro_purchase_time as TIMESTAMP)) = 3 THEN pro_quantity * f_amount ELSE 0 END),0) AS Wendnesday,
       NULLIF(SUM(CASE WHEN extract(DOW FROM cast(pro_purchase_time as TIMESTAMP)) = 4 THEN pro_quantity * f_amount ELSE 0 END),0) AS Thursday,
       NULLIF(SUM(CASE WHEN extract(DOW FROM cast(pro_purchase_time as TIMESTAMP)) = 5 THEN pro_quantity * f_amount ELSE 0 END),0) AS Friday
FROM property JOIN fund ON property.pro_pif_id = fund.f_id
WHERE pro_type = 3 AND pro_purchase_time BETWEEN '2022-02-01' AND '2022-02-28'
GROUP BY date_part('week', pro_purchase_time)
ORDER BY week_of_trading;





/*  end  of  your code  */