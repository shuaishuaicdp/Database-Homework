--创建触发器函数TRI_INSERT_FUNC()
CREATE OR REPLACE FUNCTION TRI_INSERT_FUNC() RETURNS TRIGGER AS
$$
DECLARE
   --此处用declare语句声明你所需要的变量
   msg TEXT;
BEGIN
   --此处插入触发器业务
   IF NEW.pro_type NOT IN (1,2,3) THEN
      msg := concat('type ',NEW.pro_type,' is illegal!');
      raise exception '%',msg;
   END IF;
   IF NEW.pro_type = 1 AND NEW.pro_pif_id NOT IN (SELECT p_id FROM finances_product) THEN
      msg := concat('finances product #',NEW.pro_pif_id,' not found!');
      raise exception '%',msg;
   END IF;
   IF NEW.pro_type = 2 AND NEW.pro_pif_id NOT IN (SELECT i_id FROM insurance) THEN
      msg := concat('insurance #',NEW.pro_pif_id,' not found!');
      raise exception '%',msg;
   END IF;
   IF NEW.pro_type = 3 AND NEW.pro_pif_id NOT IN (SELECT f_id FROM fund) THEN
      msg := concat('fund #',NEW.pro_pif_id,' not found!');
      raise exception '%',msg;
   END IF;

   --触发器业务结束
   return new;--返回插入的新元组
END;
$$ LANGUAGE PLPGSQL;


-- 创建before_property_inserted触发器，使用函数TRI_INSERT_FUNC实现触发器逻辑：
CREATE  TRIGGER before_property_inserted BEFORE INSERT ON property
FOR EACH ROW 
EXECUTE PROCEDURE TRI_INSERT_FUNC();