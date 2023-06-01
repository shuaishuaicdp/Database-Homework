/*
   用create function语句创建符合以下要求的函数：
   依据客户编号计算该客户所有储蓄卡的存款总额。
   函数名为：get_Records。函数的参数名可以自己命名:*/

CREATE OR REPLACE FUNCTION get_deposit(client_id integer) 
RETURNS numeric(10,2)
LANGUAGE plpgsql
AS
$$
DECLARE 
total_deposit NUMERIC(10,2);
BEGIN
   SELECT INTO total_deposit SUM(b_balance) FROM bank_card WHERE b_c_id = client_id AND b_type = '储蓄卡';
   RETURN total_deposit;
END;
$$;

SELECT c_id_card, c_name, get_deposit(c_id) AS total_deposit
FROM client
WHERE get_deposit(c_id) >= 1000000
ORDER BY total_deposit DESC;


/*  代码文件结束     */
/*  代码文件结束     */