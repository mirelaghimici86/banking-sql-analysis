 Banking Payments SQL Analysis

## About the Project

This project demonstrates the practical use of SQL for banking and payments data analysis.

I created a simulated banking database in PostgreSQL containing customers, accounts and payment transactions, and used SQL to answer business-related questions and calculate payment KPIs.

The project focuses on using SQL not only for data retrieval, but also for investigating business questions relevant to Product Management and Business Analysis in banking and payments.

## Data Model

The database contains three main entities:

CUSTOMERS → ACCOUNTS → PAYMENTS

- A customer can have one or multiple accounts.
- Each account belongs to a customer.
- An account can have multiple payment transactions.

Primary and foreign keys are used to establish the relationships between the entities.

## Business Questions

The SQL analysis addresses questions such as:

- What is the total payment volume by currency?
- What is the payment success rate?
- Which payments were rejected?
- Which customers generate the highest completed payment volumes?
- Which customers have payment volumes above a defined threshold?
- How are payments distributed by payment type?
- How do payment volumes evolve over time?
- Which payments are above the average payment amount?
- Which customers have payment volumes above the average customer payment volume?
- How are rejected payments distributed across payment types?

## SQL Skills Demonstrated

- SELECT and filtering with WHERE
- ORDER BY
- INNER JOIN
- Aggregations: COUNT, SUM and AVG
- GROUP BY and HAVING
- CASE expressions
- Date functions
- Subqueries
- Common Table Expressions (CTEs)
- Primary and Foreign Keys
- Basic relational data modelling
- KPI calculation from transaction-level data

## Example: Payment Success Rate

One of the KPIs calculated in the project is Payment Success Rate.

The analysis derives the KPI directly from transaction-level payment data by comparing successfully completed payments with the relevant payment population.

This demonstrates how SQL can be used to transform transaction data into information that can support product monitoring and business decisions.

## Tools

- PostgreSQL
- pgAdmin 4
- SQL

## Repository Structure

- `01_database_setup.sql` – database structure and simulated banking data
- `02_banking_analysis.sql` – SQL queries addressing banking and payment business questions
- `README.md` – project documentation

## Data Privacy

All customers, accounts, IBANs, beneficiaries and transactions included in this project are fictional and were created exclusively for learning and demonstration purposes.

No real customer or banking data is used.

## Purpose

The purpose of this project is to strengthen and demonstrate practical SQL knowledge in a banking and payments context, particularly from a Product Management and Business Analysis perspective.
