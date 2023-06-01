    -- 22) 查询购买了所有畅销理财产品的客户
--   请用一条SQL语句实现该查询：


SELECT DISTINCT pro_c_id
FROM property AS C
WHERE pro_type = 1
AND NOT EXISTS (
    SELECT pro_pif_id
    FROM property
    WHERE pro_type = 1
    GROUP BY pro_pif_id
    HAVING COUNT(DISTINCT pro_c_id) > 2
    AND pro_pif_id NOT IN (
        SELECT pro_pif_id
        FROM property AS B
        WHERE B.pro_c_id = C.pro_c_id AND B.pro_type = 1
    )
)
ORDER BY pro_c_id ASC;





--/*  end  of  your code  */