       -- 25) 查找相似的理财客户
--   请用一条SQL语句实现该查询：



SELECT pac,pbc,common,crank FROM (SELECT B.pro_c_id AS pac, C.pro_c_id AS pbc ,COUNT(DISTINCT C.pro_pif_id) AS common,(RANK() OVER(partition by B.pro_c_id order by COUNT(DISTINCT C.pro_pif_id) DESC,C.pro_c_id ASC))AS crank FROM property AS B,property AS C
WHERE B.pro_c_id != C.pro_c_id AND C.pro_type = 1 AND 
C.pro_pif_id in (SELECT DISTINCT pro_pif_id FROM property AS A
WHERE A.pro_c_id = B.pro_c_id AND A.pro_type = 1)
GROUP BY B.pro_c_id,C.pro_c_id
ORDER BY B.pro_c_id ASC, crank ASC)
WHERE crank < 3;




--/*  end  of  your code  */