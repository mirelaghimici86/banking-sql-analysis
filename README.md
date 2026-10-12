# Banking SQL Analysis – Payment Reconciliation

## Project Overview

This project demonstrates how SQL can be used to analyze corporate payment data and reconcile payments against their corresponding settlements.

The objective is to identify payments that have been successfully reconciled, payments with amount discrepancies, and payments for which no matching settlement record exists.

The project uses PostgreSQL and a sample banking dataset.

## Business Context

In payment operations, reconciliation helps ensure that payment records match settlement records. Differences or missing records may require investigation by Operations or Payments teams.

This analysis addresses three key questions:

* Which payments match their settlement records?
* Are there differences between payment amounts and settlement amounts?
* Which payments have no corresponding settlement record?

A missing settlement record does not automatically mean that a payment has failed. Further investigation is required to determine the cause.

## Data Model

The analysis uses two tables:

* **`payments`** – contains payment records, including payment IDs and amounts.
* **`settlements`** – contains settlement records, including payment IDs, settlement amounts, dates, and statuses.

The tables are linked using `payment_id`.

## SQL Implementation

The project uses a PostgreSQL view named `vw_payment_reconciliation`.

The view combines payment and settlement data using a `LEFT JOIN`. This ensures that payments without a matching settlement record remain visible in the results.

The reconciliation logic identifies the following statuses:

| Status               | Meaning                                                                        |
| -------------------- | ------------------------------------------------------------------------------ |
| `MATCH`              | Payment and settlement amounts match, and the settlement status is `SETTLED`.  |
| `AMOUNT_MISMATCH`    | Payment and settlement amounts differ, and the settlement status is `SETTLED`. |
| `MISSING_SETTLEMENT` | No matching settlement record exists.                                          |
| `NOT_SETTLED`        | A settlement record exists, but its status is not `SETTLED`.                   |

The order of the conditions in the SQL view determines which status is assigned when more than one exception applies.

## Results

The current sample dataset contains 30 payment records and 6 settlement records.

| Reconciliation status | Number of payments | Total payment amount | Total settlement amount |
| --------------------- | -----------------: | -------------------: | ----------------------: |
| `MATCH`               |                  5 |             8,300.00 |                8,300.00 |
| `AMOUNT_MISMATCH`     |                  1 |             2,300.00 |                2,250.00 |
| `MISSING_SETTLEMENT`  |                 24 |            79,635.00 |                       — |

### Key Findings

* **5 payments matched** their settlement records.
* **1 payment had an amount discrepancy** of 50.00.
* **24 payments had no matching settlement record** in the sample dataset.

These findings identify exceptions for further investigation. They do not, by themselves, establish the operational cause of the missing settlement records.

## Repository Structure

* `01_database_setup.sql` – database setup and initial data preparation.
* `02_banking_analysis.sql` – banking data analysis queries.
* `03_payment_reconciliation.sql` – reconciliation view, summary query, and exception analysis.
* `README.md` – project overview, methodology, and results.

## Skills Demonstrated

* SQL and PostgreSQL
* `LEFT JOIN`, `CASE WHEN`, aggregation, and filtering
* Data quality checks and exception identification
* Payment and settlement reconciliation concepts
* Translating a business control into SQL logic
* Communicating findings for operational investigation

## Potential Next Steps

* Add test cases for non-settled records and amount discrepancies.
* Investigate missing settlement records using additional operational data.
* Build a Power BI dashboard to visualize reconciliation outcomes and exceptions.

## Disclaimer

This project uses sample data for learning and portfolio purposes. The results should not be interpreted as actual banking operational data.
 

