
-- 在金融应用场景数据库中，编程实现一个转账操作的存储过程sp_transfer_balance，实现从一个帐户向另一个帐户转账。
-- 请补充代码完成该过程：
CREATE PROCEDURE sp_transfer(IN applicant_id INT,      
                     IN source_card_id CHAR(30),
					 IN receiver_id INT, 
                     IN dest_card_id CHAR(30),
					 IN	amount NUMERIC(10,2),
					 OUT return_code INT)
AS
BEGIN
    return_code := 0;
    IF source_card_id IN (SELECT b_number FROM bank_card WHERE b_c_id = applicant_id) AND dest_card_id IN (SELECT b_number FROM bank_card WHERE b_c_id = receiver_id) AND (SELECT b_balance FROM bank_card WHERE b_number = source_card_id) >= amount THEN
        IF (SELECT b_type FROM bank_card WHERE b_number = source_card_id) = '储蓄卡' AND (SELECT b_type FROM bank_card WHERE b_number = dest_card_id) = '储蓄卡' THEN
            UPDATE bank_card 
            SET b_balance = b_balance - amount
            WHERE b_number = source_card_id;
            UPDATE bank_card
            SET b_balance = b_balance + amount
            WHERE b_number = dest_card_id;
            return_code := 1;
        ELSIF (SELECT b_type FROM bank_card WHERE b_number = source_card_id) = '储蓄卡' AND (SELECT b_type FROM bank_card WHERE b_number = dest_card_id) = '信用卡' THEN
            UPDATE bank_card 
            SET b_balance = b_balance - amount
            WHERE b_number = source_card_id;
            UPDATE bank_card
            SET b_balance = b_balance - amount
            WHERE b_number = dest_card_id;
            return_code := 1;
        END IF;
    END IF;
END;


/*  end  of  your code  */ 








/*  end  of  your code  */ 