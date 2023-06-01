 -- 18) 查询至少有一张信用卡余额超过5000元的客户编号，以及该客户持有的信用卡总余额，总余额命名为credit_card_amount。
--    请用一条SQL语句实现该查询：

SELECT DISTINCT b_c_id,(SELECT SUM(b_balance) FROM bank_card AS B WHERE A.b_c_id = B.b_c_id AND B.b_type = '信用卡' GROUP BY B.b_c_id) AS credit_card_amount FROM bank_card AS A 
WHERE A.b_c_id IN(SELECT b_c_id FROM bank_card WHERE b_balance > 5000 AND b_type = '信用卡')
ORDER BY A.b_c_id ASC;





/*  end  of  your code  */


 