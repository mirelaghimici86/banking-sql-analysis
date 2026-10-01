/*
BANKING SQL ANALYSIS PROJECT

Database: PostgreSQL
Domain: Banking / Payments

Purpose:
Analyze customer, account and payment data using SQL
to answer business-related questions.
*/

--Operations wants to see all successfully completed payments.
SELECT *
FROM payments
WHERE status = 'COMPLETED';

--Identify RON payments above 5,000.
SELECT
    payment_id,
    amount,
    currency,
    status,
    payment_date
FROM payments
WHERE currency = 'RON'
  AND amount > 5000
ORDER BY amount DESC;

--Operations wants to investigate rejected payments.
SELECT
    payment_id,
    account_id,
    amount,
    currency,
    payment_type,
    payment_date
FROM payments
WHERE status = 'REJECTED'
ORDER BY payment_date;
--Calculate total payment volume by currency.

SELECT
    currency,
    SUM(amount) AS total_payment_volume
FROM payments
GROUP BY currency;
--Product Management wants to understand payment distribution by status.

SELECT
    status,
    COUNT(*) AS number_of_payments
FROM payments
GROUP BY status
ORDER BY number_of_payments DESC;

--Calculate the payment success rate.
--Completed payments
------------------- × 100
--Total payments

SELECT
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE status = 'COMPLETED')
        / COUNT(*),
        2
    ) AS payment_success_rate
FROM payments;

--Show the customer associated with each payment.
--PAYMENTS nu conține customer_id. De aceea ajung la customer prin ACCOUNTS

SELECT
    c.first_name,
    c.last_name,
    p.payment_id,
    p.amount,
    p.currency,
    p.status
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN payments p
    ON a.account_id = p.account_id
ORDER BY c.last_name;

--Calculate total completed payment volume for each customer.

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    p.currency,
    SUM(p.amount) AS total_payment_volume
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN payments p
    ON a.account_id = p.account_id
WHERE p.status = 'COMPLETED'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    p.currency
ORDER BY total_payment_volume DESC;
--HAVINg Identify customers whose completed RON payment volume exceeds 5,000 RON.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_ron_volume
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN payments p
    ON a.account_id = p.account_id
WHERE p.status = 'COMPLETED'
  AND p.currency = 'RON'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING SUM(p.amount) > 5000
ORDER BY total_ron_volume DESC;

--Classify payments according to their amount.
/* < 1,000          LOW
1,000 – 5,000    MEDIUM
> 5,000          HIGH*/

SELECT
    payment_id,
    amount,
    currency,
    CASE
        WHEN amount < 1000 THEN 'LOW'
        WHEN amount <= 5000 THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS payment_value_category
FROM payments
ORDER BY amount DESC;

--Analyze payment volumes by month.
SELECT
    EXTRACT(MONTH FROM payment_date) AS payment_month,
    currency,
    COUNT(*) AS number_of_payments,
    SUM(amount) AS payment_volume
FROM payments
WHERE status = 'COMPLETED'
GROUP BY
    EXTRACT(MONTH FROM payment_date),
    currency
ORDER BY payment_month, currency;
--Find payments whose amount is above the average payment amount for their currency.
--Nu vrem să comparăm direct EUR cu RON
/*Query interior
      ↓
calculează media

Query exterior
      ↓
găsește plățile peste acea medie*/

SELECT
    p.payment_id,
    p.amount,
    p.currency
FROM payments p
WHERE p.amount > (
    SELECT AVG(p2.amount)
    FROM payments p2
    WHERE p2.currency = p.currency
)
ORDER BY p.currency, p.amount DESC;

--Identify customers whose completed payment volume is above the average customer payment volume,
--within each currency.

WITH customer_totals AS (

    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        p.currency,
        SUM(p.amount) AS total_payment_volume

    FROM customers c

    JOIN accounts a
        ON c.customer_id = a.customer_id

    JOIN payments p
        ON a.account_id = p.account_id

    WHERE p.status = 'COMPLETED'

    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        p.currency
)

SELECT *
FROM customer_totals ct

WHERE total_payment_volume > (
    SELECT AVG(ct2.total_payment_volume)
    FROM customer_totals ct2
    WHERE ct2.currency = ct.currency
)

ORDER BY currency, total_payment_volume DESC;

--Compare adoption and completed payment volume across payment types.


SELECT
    payment_type,
    currency,
    COUNT(*) AS number_of_payments,
    SUM(amount) AS total_volume
FROM payments
WHERE status = 'COMPLETED'
GROUP BY
    payment_type,
    currency
ORDER BY number_of_payments DESC;

--Analyze rejected payments by payment type.
SELECT
    payment_type,
    currency,
    COUNT(*) AS rejected_payments,
    SUM(amount) AS rejected_volume
FROM payments
WHERE status = 'REJECTED'
GROUP BY
    payment_type,
    currency
ORDER BY rejected_payments DESC;

/*Business question
       ↓
Ce date îmi trebuie?
       ↓
În ce tabel sunt?
       ↓
Am nevoie de JOIN?
       ↓
Trebuie să filtrez?
       ↓
Trebuie să agreg?
       ↓
SELECT / WHERE / JOIN / GROUP BY / HAVING
       ↓
Business result*/