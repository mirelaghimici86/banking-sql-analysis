CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    customer_type VARCHAR(20),
    onboarding_date DATE
);

SELECT *
FROM customers;

CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    iban VARCHAR(34) UNIQUE NOT NULL,
    currency VARCHAR(3) NOT NULL,
    balance NUMERIC(15,2) DEFAULT 0,
    account_status VARCHAR(20),
    opening_date DATE,

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    account_id INTEGER NOT NULL,
    amount NUMERIC(15,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL,
    payment_type VARCHAR(30),
    beneficiary_name VARCHAR(100),
    payment_date DATE NOT NULL,

    CONSTRAINT fk_account
        FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

INSERT INTO customers
(customer_id, first_name, last_name, city, customer_type, onboarding_date)
VALUES
(1, 'Andrei', 'Popescu', 'Bucharest', 'Individual', '2025-01-15'),
(2, 'Maria', 'Ionescu', 'Cluj', 'Individual', '2025-02-10'),
(3, 'Alex', 'Dumitrescu', 'Bucharest', 'Individual', '2025-03-05'),
(4, 'Elena', 'Marin', 'Brasov', 'Individual', '2025-03-20'),
(5, 'Mihai', 'Stan', 'Iasi', 'Individual', '2025-04-12'),
(6, 'Ioana', 'Radu', 'Bucharest', 'Individual', '2025-05-08'),
(7, 'Cristian', 'Matei', 'Constanta', 'Individual', '2025-06-17'),
(8, 'Diana', 'Tudor', 'Cluj', 'Individual', '2025-07-01'),
(9, 'Robert', 'Ilie', 'Bucharest', 'Individual', '2025-07-22'),
(10, 'Ana', 'Georgescu', 'Timisoara', 'Individual', '2025-08-14'),
(11, 'Dan', 'Petrescu', 'Brasov', 'Individual', '2025-09-03'),
(12, 'Laura', 'Munteanu', 'Bucharest', 'Individual', '2025-10-10'),
(13, 'Victor', 'Nistor', 'Iasi', 'Individual', '2025-11-05'),
(14, 'Simona', 'Enache', 'Cluj', 'Individual', '2025-12-01'),
(15, 'Paul', 'Dragomir', 'Bucharest', 'Individual', '2026-01-12');

SELECT *
FROM accounts
ORDER BY account_id;

INSERT INTO accounts
(account_id, customer_id, iban, currency, balance, account_status, opening_date)
VALUES
(101, 1, 'RO01BANK000000000001', 'RON', 12500.00, 'ACTIVE', '2025-01-15'),
(102, 1, 'RO01BANK000000000002', 'EUR', 3200.00, 'ACTIVE', '2025-02-01'),

(103, 2, 'RO01BANK000000000003', 'RON', 8700.00, 'ACTIVE', '2025-02-10'),

(104, 3, 'RO01BANK000000000004', 'RON', 22100.00, 'ACTIVE', '2025-03-05'),
(105, 3, 'RO01BANK000000000005', 'EUR', 7500.00, 'ACTIVE', '2025-03-06'),

(106, 4, 'RO01BANK000000000006', 'RON', 4500.00, 'ACTIVE', '2025-03-20'),
(107, 5, 'RO01BANK000000000007', 'EUR', 2800.00, 'ACTIVE', '2025-04-12'),
(108, 6, 'RO01BANK000000000008', 'RON', 15300.00, 'ACTIVE', '2025-05-08'),

(109, 7, 'RO01BANK000000000009', 'RON', 6700.00, 'ACTIVE', '2025-06-17'),
(110, 7, 'RO01BANK000000000010', 'EUR', 4100.00, 'ACTIVE', '2025-06-20'),

(111, 8, 'RO01BANK000000000011', 'RON', 9100.00, 'ACTIVE', '2025-07-01'),
(112, 9, 'RO01BANK000000000012', 'RON', 18500.00, 'ACTIVE', '2025-07-22'),



(113, 10, 'RO01BANK000000000013', 'EUR', 6200.00, 'ACTIVE', '2025-08-14'),
(114, 10, 'RO01BANK000000000014', 'RON', 14300.00, 'ACTIVE', '2025-08-15'),

(115, 11, 'RO01BANK000000000015', 'RON', 3900.00, 'ACTIVE', '2025-09-03'),
(116, 12, 'RO01BANK000000000016', 'RON', 27400.00, 'ACTIVE', '2025-10-10'),
(117, 12, 'RO01BANK000000000017', 'EUR', 8900.00, 'ACTIVE', '2025-10-11'),

(118, 13, 'RO01BANK000000000018', 'RON', 7600.00, 'ACTIVE', '2025-11-05'),
(119, 14, 'RO01BANK000000000019', 'RON', 11200.00, 'ACTIVE', '2025-12-01'),
(120, 15, 'RO01BANK000000000020', 'EUR', 5100.00, 'ACTIVE', '2026-01-12');


SELECT *
FROM accounts
ORDER BY account_id;

--join
SELECT
    c.first_name,
    c.last_name,
    a.iban,
    a.currency,
    a.balance
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
ORDER BY c.customer_id;

--Creează PAYMENTS
CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    account_id INTEGER NOT NULL,
    amount NUMERIC(15,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL,
    payment_type VARCHAR(30),
    beneficiary_name VARCHAR(100),
    payment_date DATE NOT NULL,

    CONSTRAINT fk_account
        FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

--verific
SELECT *
FROM payments;

INSERT INTO payments
(payment_id, account_id, amount, currency, status, payment_type, beneficiary_name, payment_date)
VALUES
(1001, 101, 450.00, 'RON', 'COMPLETED', 'DOMESTIC', 'Electricity Supplier', '2026-01-10'),
(1002, 101, 1200.00, 'RON', 'COMPLETED', 'INSTANT', 'ABC Services', '2026-01-15'),
(1003, 102, 750.00, 'EUR', 'COMPLETED', 'SEPA', 'Euro Consulting', '2026-01-20'),

(1004, 103, 2300.00, 'RON', 'COMPLETED', 'DOMESTIC', 'Business Solutions', '2026-02-02'),
(1005, 103, 900.00, 'RON', 'REJECTED', 'INSTANT', 'Digital Store', '2026-02-05'),

(1006, 104, 5000.00, 'RON', 'COMPLETED', 'DOMESTIC', 'Logistics Romania', '2026-02-10'),
(1007, 104, 7800.00, 'RON', 'COMPLETED', 'INSTANT', 'Technology SRL', '2026-02-12'),
(1008, 105, 3500.00, 'EUR', 'COMPLETED', 'SEPA', 'European Supplier', '2026-02-15'),

(1009, 106, 350.00, 'RON', 'COMPLETED', 'DOMESTIC', 'Utility Company', '2026-03-01'),
(1010, 106, 125.00, 'RON', 'REJECTED', 'INSTANT', 'Online Shop', '2026-03-03'),

(1011, 107, 1200.00, 'EUR', 'COMPLETED', 'SEPA', 'German Supplier', '2026-03-08'),
(1012, 108, 6400.00, 'RON', 'COMPLETED', 'DOMESTIC', 'Corporate Services', '2026-03-12'),

(1013, 109, 850.00, 'RON', 'PENDING', 'INSTANT', 'Retail Partner', '2026-04-01'),
(1014, 109, 1400.00, 'RON', 'COMPLETED', 'DOMESTIC', 'Insurance Company', '2026-04-03'),
(1015, 110, 2100.00, 'EUR', 'COMPLETED', 'SEPA', 'Italian Supplier', '2026-04-10'),

(1016, 111, 760.00, 'RON', 'COMPLETED', 'INSTANT', 'Medical Services', '2026-05-02'),
(1017, 112, 9500.00, 'RON', 'COMPLETED', 'DOMESTIC', 'Industrial Supplier', '2026-05-08'),
(1018, 112, 4200.00, 'RON', 'COMPLETED', 'INSTANT', 'IT Services', '2026-05-11'),

(1019, 113, 2800.00, 'EUR', 'COMPLETED', 'SEPA', 'France Consulting', '2026-06-01'),
(1020, 114, 3100.00, 'RON', 'REJECTED', 'DOMESTIC', 'Construction SRL', '2026-06-04'),

(1021, 115, 550.00, 'RON', 'COMPLETED', 'INSTANT', 'Telecom Provider', '2026-06-15'),
(1022, 116, 12500.00, 'RON', 'COMPLETED', 'DOMESTIC', 'Corporate Partner', '2026-07-01'),
(1023, 116, 6800.00, 'RON', 'COMPLETED', 'INSTANT', 'Software Company', '2026-07-03'),
(1024, 117, 4500.00, 'EUR', 'COMPLETED', 'SEPA', 'Netherlands Supplier', '2026-07-08'),

(1025, 118, 1100.00, 'RON', 'PENDING', 'DOMESTIC', 'Education Services', '2026-08-02'),
(1026, 119, 2600.00, 'RON', 'COMPLETED', 'INSTANT', 'Travel Company', '2026-08-07'),
(1027, 119, 1750.00, 'RON', 'COMPLETED', 'DOMESTIC', 'Insurance Broker', '2026-08-09'),

(1028, 120, 1900.00, 'EUR', 'COMPLETED', 'SEPA', 'Spanish Supplier', '2026-09-01'),
(1029, 120, 650.00, 'EUR', 'REJECTED', 'SEPA', 'Online Services EU', '2026-09-04'),
(1030, 101, 3200.00, 'RON', 'COMPLETED', 'INSTANT', 'Home Services', '2026-09-10');

SELECT *
FROM payments
ORDER BY payment_id;

--verific nr
SELECT COUNT(*) AS number_of_payments
FROM payments;

--join verific realtia account-payment
SELECT
    a.account_id,
    a.iban,
    p.payment_id,
    p.amount,
    p.currency,
    p.status
FROM accounts a
JOIN payments p
    ON a.account_id = p.account_id
ORDER BY a.account_id;

--join relatia dintre cele 3 tabele
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.iban,
    a.currency AS account_currency,
    p.payment_id,
    p.amount,
    p.currency AS payment_currency,
    p.status,
    p.payment_type,
    p.payment_date
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN payments p
    ON a.account_id = p.account_id
ORDER BY c.customer_id, p.payment_date;

--verificare date
SELECT
    (SELECT COUNT(*) FROM customers) AS customers,
    (SELECT COUNT(*) FROM accounts) AS accounts,
    (SELECT COUNT(*) FROM payments) AS payments;