-- 16) 查询持有相同基金组合的客户对，如编号为A的客户持有的基金，编号为B的客户也持有，反过来，编号为B的客户持有的基金，编号为A的客户也持有，则(A,B)即为持有相同基金组合的二元组，请列出这样的客户对。为避免过多的重复，如果(1,2)为满足条件的元组，则不必显示(2,1)，即只显示编号小者在前的那一对，这一组客户编号分别命名为c_id1,c_id2。

-- 请用一条SQL语句实现该查询：



SELECT A.c_id AS c_id1, B.c_id AS c_id2 
FROM client AS A, client AS B 
WHERE A.c_id < B.c_id 
AND NOT EXISTS (
  SELECT 1 
  FROM property AS pro_A 
  WHERE pro_A.pro_c_id = A.c_id 
  AND pro_A.pro_type = 3 
  AND NOT EXISTS (
    SELECT 1 
    FROM property AS pro_B 
    WHERE pro_B.pro_c_id = B.c_id 
    AND pro_A.pro_pif_id = pro_B.pro_pif_id 
    AND pro_B.pro_type = 3
  )
)
AND NOT EXISTS (
  SELECT 1 
  FROM property AS pro_B 
  WHERE pro_B.pro_c_id = B.c_id 
  AND pro_B.pro_type = 3 
  AND NOT EXISTS (
    SELECT 1 
    FROM property AS pro_A 
    WHERE pro_A.pro_c_id = A.c_id 
    AND pro_B.pro_pif_id = pro_A.pro_pif_id 
    AND pro_A.pro_type = 3
  )
)
AND A.c_id in (SELECT pro_c_id FROM property WHERE pro_type = 3)
AND B.c_id in (SELECT pro_c_id FROM property WHERE pro_type = 3);




/*  end  of  your code  */