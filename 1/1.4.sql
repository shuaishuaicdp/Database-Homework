-------请在以下空白处填写完成任务的语句，空白行可通过回车换行添加。
-------你也可以在命令行窗口完成任务，不过，在命令行键入的语句不会被保存。

CREATE TABLE products
(
    pid char(10) PRIMARY KEY,
    name varchar(32),
    brand char(10),
    price int,
    CONSTRAINT CK_products_brand CHECK(brand in ('A','B')),
    CONSTRAINT CK_products_price CHECK(price > 0)
);


--------结束 