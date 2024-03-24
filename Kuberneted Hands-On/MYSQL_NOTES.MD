# MYSQL NOTES

```bash
CREATE TABLE order_table (
order_id INT,
customer VARCHAR(50),
product_name VARCHAR(50),
location VARCHAR(50),
order_quantity INT,
order_date date);
SELECT * FROM order_table;
INSERT INTO order_table VALUES 
(1, 'SURAJ', 'tshirt', 'BERHAMPUR', 10, '2024-01-02'),
(2, 'BIKASH', 'jeans', 'BHUBANESWAR', 8, '2024-01-03'),
(3, 'RAHUL', 'tshirt', 'BHUBANESWAR', 10, '2024-01-05'),
(4, 'RAM', 'shirt', 'BHUBANESWAR', 10, '2024-01-06'),
(5, 'RAJU', 'jeans', 'CUTTACK', 11, '2024-01-07'),
(6, 'AJAY', 'shirt', 'BERHAMPUR', 6, '2024-01-08'),
(7, 'RITU', 'jeans', 'BHUBANESWAR', 8, '2024-01-09'),
(8, 'HARI', 'shirt', 'KORAPUT', 10, '2024-01-10'),
(9, 'MANSIH', 'tshirt', 'BHUBANESWAR', 9, '2024-01-11'),
(10, 'DHARA', 'thsirt', 'KHORDHA', 4, '2024-01-12');
SELECT customer , COUNT(*) FROM order_table GROUP BY customer;

-- SELECT customer , order_quantity FROM order_table;
-- SELECT customer, SUM(order_quantity) FROM order_table GROUP BY customer;
-- SELECT customer, order_quantity FROM order_table WHERE order_quantity>=10;

-- SELECT customer FROM order_table GROUP BY customer HAVING COUNT(*) > 3;
-- SELECT customer FROM order_table WHERE YEAR(order_date) =2024 AND MONTH(order_date) = 1 GROUP BY customer HAVING COUNT(*) > 3;
-- SELECT customer, COUNT(*)  FROM order_table WHERE location = 'BHUBANESWAR' GROUP BY customer HAVING COUNT(*) > 2;
-- SELECT customer, COUNT(*) AS num_orders  FROM order_table WHERE location = 'BBSR' GROUP BY customer HAVING COUNT(*) > 2 ORDER BY num_orders;
```


--------------------------------------------------

2024-01-09
2024-01-19
2024-01-12
2024-01-13
2024-01-15
2024-01-20
----------------------

```bash
CREATE TABLE  empo (
employee_id INT,
employee_name VARCHAR(50),
employee_location VARCHAR(50),
product_name VARCHAR(50),
order_quant INT,
order_date date);
SELECT * FROM empo;
INSERT INTO empo VALUES 
(1, 'RAJ' , 'BBSR' , 'Tshirt' , 12, '2024-01-09'),
(2, 'ANIL' , 'BBSR' , 'Jeans' , 15, '2024-01-19'),
(3, 'RITU' , 'BAM' , 'Shirt' , 10, '2024-01-12'),
(4, 'SURAJ' , 'BBSR' , 'Tshirt' , 13 , '2024-01-13'),
(5, 'MANISH', 'BBSR' , 'Jeans' , 16 , '2024-01-15'),
(6, 'DHARA' , 'KHDR', 'Tshirt' , 18 , '2024-01-20');
SELECT * FROM empo WHERE employee_location IN('BBSR');
SELECT * FROM empo WHERE employee_location NOT IN('BBSR','BAM');
SELECT * FROM  empo WHERE employee_name!= 'BBSR';
SELECT employee_name FROM empo WHERE order_quant>=12;
SELECT * FROM empo WHERE employee_location NOT IN('BBSR','KHDR');
SELECT employee_name FROM empo WHERE DATE_FORMAT(order_date,'%d') NOT IN(20,15);
SELECT employee_name FROM empo WHERE DATE_FORMAT(order_date,'%Y') IN(2024);
SELECT employee_id,employee_name FROM empo WHERE DATE_FORMAT(order_date,'%Y') IN(2024);
SELECT employee_id,employee_name,employee_location FROM empo WHERE DATE_FORMAT(order_date,'%d') NOT IN (10,15,20);
SELECT employee_name FROM empo WHERE employee_location NOT IN('BBSR');
SELECT employee_name FROM empo WHERE employee_location IN('BAM');
SELECT order_quant FROM empo WHERE employee_location NOT IN('BBSR','BAM');
SELECT employee_name FROM empo WHERE order_quant BETWEEN 15 AND 20;
SELECT employee_name , order_quant FROM empo WHERE order_quant BETWEEN 15 AND 20;
SELECT employee_name,order_quant FROM empo WHERE order_quant BETWEEN 10 AND 12;
SELECT * FROM empo WHERE order_quant BETWEEN 10 AND 12;
SELECT * FROM empo WHERE DATE_FORMAT(order_date,'%d') BETWEEN 09 AND 12;
SELECT employee_name FROM empo WHERE DATE_FORMAT(order_date,'%Y') IN (2024);
SELECT employee_id,employee_name FROM empo WHERE DATE_FORMAT(order_date,'%Y') IN (2024);
SELECT employee_location, order_date FROM empo WHERE DATE_FORMAT(order_date,'%d') BETWEEN 15 AND 20;
SELECT employee_name FROM empo WHERE DATE_FORMAT(order_date,'%d') BETWEEN 15 AND 16;
SELECT employee_name FROM empo WHERE order_quant BETWEEN 10 AND 15;
SELECT employee_name FROM empo WHERE order_quant BETWEEN 10 AND 12;
SELECT * FROM empo WHERE order_date IS  NULL;
SELECT *  FROM empo WHERE product_name IS NULL;
SELECT *  FROM empo WHERE product_name IS NOT NULL;
SELECT * FROM empo WHERE  employee_name LIKE 'S%';
SELECT employee_name FROM empo WHERE employee_name LIKE 'R%';
SELECT employee_name FROM empo WHERE employee_name LIKE 'S%';
SELECT employee_name FROM empo WHERE employee_name LIKE '%J';
SELECT employee_name FROM empo WHERE employee_name LIKE '%A';
SELECT employee_name FROM empo WHERE employee_name LIKE '%j%';
SELECT employee_name FROM empo WHERE employee_name LIKE '%A';
SELECT employee_name FROM empo WHERE employee_name LIKE '%j';
SELECT employee_name FROM empo WHERE employee_name LIKE 'R%';

------------------------------------------
CHECK
-- CREATE TABLE student (
-- regd_no date CHECK(regd_Date BETWEEN '01-02-2024' AND 02-01-2024));

CREATE TABLE student (
regd_date DATE,
loction VARCHAR(30),
    regd_no DATE CHECK(regd_no BETWEEN '2024-01-02' AND '2024-02-01')
);
SELECT * FROM student;
INSERT INTO student VALUES('2024-01-30','BBSR',1);



-- CREATE TABLE student (
-- regd_no date CHECK(regd_Date BETWEEN '01-02-2024' AND 02-01-2024));

-- CREATE TABLE student (
-- regd_date DATE,
-- loction VARCHAR(30),
--     regd_no DATE CHECK(regd_no BETWEEN '2024-01-02' AND '2024-02-01')
-- );
-- SELECT * FROM student;
-- INSERT INTO student VALUES('2024-01-30','BBSR',1);

CREATE TABLE cons (
name VARCHAR(20),
adress varchar(20) default 'bbsr',
regdate  date default '2024-02-20'
);
SELECT * FROM cons;
INSERT INTO cons(name) VALUE ('sham');
INSERT INTO cons VALUES('RAM', null);
INSERT INTO cons(adress) VALUES('RAJ');

DROP TABLE cons;
```



