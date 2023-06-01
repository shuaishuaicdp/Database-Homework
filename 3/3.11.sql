-- 11) 给出黄姓用户的编号、名称、办理的银行卡的数量(没有办卡的卡数量计为0),持卡数量命名为number_of_cards,
--     按办理银行卡数量降序输出,持卡数量相同的,依客户编号排序。
-- 请用一条SQL语句实现该查询：


SELECT c_id,c_name,(SELECT count(b_number) FROM bank_card WHERE b_c_id = c_id) AS number_of_cards FROM client WHERE c_name LIKE '黄%' ORDER BY number_of_cards DESC,c_id ASC;









/*  end  of  your code  */ 