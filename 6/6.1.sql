
 
-- 创建存储过程`sp_fibonacci(in m int)`，向表fibonacci插入斐波拉契数列的前m项，及其对应的斐波拉契数。fibonacci表初始值为一张空表。请保证你的存储过程可以多次运行而不出错。

CREATE PROCEDURE sp_fibonacci(IN m INT)
AS
DECLARE 
    a INT := 0;
    b INT := 1;
    fib INT;
    i INT := 2;
BEGIN
    IF m > 0 THEN 
        INSERT INTO fibonacci VALUES(0,0); 
    END IF;
    IF m > 1 THEN 
        INSERT INTO fibonacci VALUES(1,1); 
    END IF;

    WHILE i < m LOOP
        fib := a + b;
        INSERT INTO fibonacci VALUES(i,fib);
        a := b;
        b := fib;
        i := i + 1;
    END LOOP;
END;
/
 
