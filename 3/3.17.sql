-- 17 查询2022年2月购买基金的高峰期。至少连续三个交易日，所有投资者购买基金的总金额超过100万(含)，则称这段连续交易日为投资者购买基金的高峰期。只有交易日才能购买基金,但不能保证每个交易日都有投资者购买基金。2022年春节假期之后的第1个交易日为2月7日,周六和周日是非交易日，其余均为交易日。请列出高峰时段的日期和当日基金的总购买金额，按日期顺序排序。总购买金额命名为total_amount。
--    请用一条SQL语句实现该查询：


WITH daily_amount AS (
  SELECT pro_purchase_time, SUM(pro_quantity * f_amount) AS amount
  FROM property JOIN fund ON property.pro_pif_id = fund.f_id
  WHERE pro_type = 3 AND pro_purchase_time BETWEEN '2022-02-01' AND '2022-02-28'
  GROUP BY pro_purchase_time
),
three_day_amount AS (
  SELECT pro_purchase_time,
    amount + COALESCE(LAG(amount, 1) OVER (ORDER BY pro_purchase_time), 0)
          + COALESCE(LAG(amount, 2) OVER (ORDER BY pro_purchase_time), 0) AS three_days,
    COALESCE(LEAD(amount, 1) OVER (ORDER BY pro_purchase_time), 0) AS next_day_amount
  FROM daily_amount
)
SELECT daily_amount.pro_purchase_time, amount
FROM three_day_amount JOIN daily_amount ON daily_amount.pro_purchase_time = three_day_amount.pro_purchase_time
WHERE amount >= 1000000 AND (three_days >= 3000000 OR next_day_amount >= 1000000)
ORDER BY daily_amount.pro_purchase_time;

-- SELECT * FROM daily_amount;


/*  end  of  your code  */