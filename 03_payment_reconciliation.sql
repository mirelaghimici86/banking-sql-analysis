
-- ============================================================
-- 03_payment_reconciliation.sql
-- Banking SQL Analysis Project
-- Purpose: Reconcile payments against settlements
-- Database: banking_sql_project (PostgreSQL)
-- ============================================================


-- 1. PAYMENT RECONCILIATION VIEW
-- Compare payment records with their corresponding settlements.
-- A LEFT JOIN preserves payments even when no settlement exists.

CREATE OR REPLACE VIEW public.vw_payment_reconciliation AS
SELECT
    p.payment_id,
    p.amount AS payment_amount,
    s.settlement_amount,
    s.settlement_date,
    s.settlement_status,
    p.amount - s.settlement_amount AS amount_difference,
    CASE
        WHEN s.payment_id IS NULL
            THEN 'MISSING_SETTLEMENT'
        WHEN s.settlement_status::text <> 'SETTLED'
            THEN 'NOT_SETTLED'
        WHEN p.amount <> s.settlement_amount
            THEN 'AMOUNT_MISMATCH'
        ELSE 'MATCH'
    END AS reconciliation_status
FROM payments p
LEFT JOIN settlements s
    ON p.payment_id = s.payment_id;


-- 2. RECONCILIATION SUMMARY
-- Count payments and aggregate amounts by reconciliation status.

SELECT
    reconciliation_status,
    COUNT(*) AS number_of_payments,
    SUM(payment_amount) AS total_payment_amount,
    SUM(settlement_amount) AS total_settlement_amount,
    SUM(amount_difference) AS total_amount_difference
FROM public.vw_payment_reconciliation
GROUP BY reconciliation_status
ORDER BY reconciliation_status;


-- 3. EXCEPTION DETAILS
-- Identify payments requiring further investigation.

SELECT
    payment_id,
    payment_amount,
    settlement_amount,
    settlement_date,
    settlement_status,
    amount_difference,
    reconciliation_status
FROM public.vw_payment_reconciliation
WHERE reconciliation_status <> 'MATCH'
ORDER BY reconciliation_status, payment_id;
