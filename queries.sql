/* CREATE DATABASE */

CREATE DATABASE transactional_sample;

/* Create Table */

CREATE TABLE datasets(

transaction_id int,
merchant_id int,
user_id int,
card_number varchar(16),
transaction_date DATE,
transaction_amount FLOAT,
device_id INT,
has_cbk varchar(5)
)

/* Import dataset */

LOAD DATA LOCAL INFILE 'C:/Users/Deivid/Desktop/cloudwalk_payment_fraud/transactional-sample.csv'

INTO TABLE datasets
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED by '"'
lines terminated by '\r\n'
ignore  1 rows;

/* Getting all user_id who purchased more than 10 times */
SELECT user_id, COUNT(*), merchant_id, COUNT(*)  FROM datasets GROUP BY user_id, merchant_id HAVING COUNT(*) >= 10;

/* Getting transactions equal or over 3000 who had chargeback transactions */
SELECT * FROM datasets WHERE transaction_amount > 3000 AND has_cbk = "TRUE";

/* Getting the highest transactions by a specifc period of time */
SELECT * from datasets WHERE  transaction_date BETWEEN '2019-12-01' AND  '2019-12-31' ORDER BY transaction_amount DESC;

/* Getting the highest transactions(Condition) by a specifc period of time, filtering only chargebacks transactions */
SELECT * FROM datasets WHERE transaction_date BETWEEN '2019-12-01' AND  '2019-12-01' AND has_cbk = 'TRUE' AND transaction_amount > 1500;

/* Getting all data of a specific user_id, where had chargebacks */
SELECT * FROM datasets WHERE user_id = 96025 AND has_cbk = "TRUE";

/* Getting highest transaction who had chargeback, limiting 10 transactions */
SELECT user_id, transaction_amount, has_cbk FROM datasets WHERE has_cbk = "TRUE" ORDER BY transaction_amount DESC LIMIT 10;

/* Getting the historical highest transactions, limiting 10 transactions */
SELECT user_id, transaction_amount FROM datasets ORDER BY transaction_amount DESC LIMIT 10;

/* Getting all data of a specific user_id, ordering by highest transaction of this user_id*/
SELECT user_id, transaction_amount merchant_id, card_number FROM datasets WHERE user_id = 78262 ORDER BY transaction_amount DESC;

