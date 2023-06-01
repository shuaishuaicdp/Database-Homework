   -- 21) 投资积极且偏好理财类产品的客户
--   请用一条SQL语句实现该查询：


SELECT pro_c_id 
FROM property
GROUP BY pro_c_id
HAVING COUNT(DISTINCT pro_pif_id) >= 3
AND (
  COALESCE(SUM(CASE WHEN pro_type = 3 THEN 1 ELSE 0 END), 0) 
  < COALESCE(SUM(CASE WHEN pro_type = 1 THEN 1 ELSE 0 END), 0)
)
ORDER BY pro_c_id ASC;




--/*  end  of  your code  */