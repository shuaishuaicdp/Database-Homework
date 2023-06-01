      -- 24) 查询任意两个客户的相同理财产品数
--   请用一条SQL语句实现该查询：



SELECT DISTINCT A.pro_c_id,B.pro_c_id,
(SELECT COUNT(DISTINCT C.pro_pif_id) 
FROM property C 
WHERE C.pro_type = 1 
AND C.pro_c_id = A.pro_c_id 
AND C.pro_pif_id IN (
    SELECT D.pro_pif_id 
    FROM property D 
    WHERE D.pro_type = 1 
    AND D.pro_c_id = B.pro_c_id
)
) AS total_count
FROM property AS A, property AS B
WHERE A.pro_c_id != B.pro_c_id AND total_count >= 2
ORDER BY A.pro_c_id ASC;





--/*  end  of  your code  */