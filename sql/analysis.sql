-- Digital Payments Analytics
-- SQL Analysis
-- Database: payment_analytics
-- Table: digital_wallet_transactions


USE payment_analytics;


-- 1. Total number of transactions

SELECT
    COUNT(*) AS total_transactions
FROM digital_wallet_transactions;


-- 2. Total transaction value

SELECT
    ROUND(SUM(product_amount), 2) AS total_transaction_value
FROM digital_wallet_transactions;


-- 3. Average transaction value

SELECT
    ROUND(AVG(product_amount), 2) AS average_transaction_value
FROM digital_wallet_transactions;


-- 4. Transaction count by status

SELECT
    transaction_status,
    COUNT(*) AS transaction_count
FROM digital_wallet_transactions
GROUP BY transaction_status
ORDER BY transaction_count DESC;


-- 5. Transaction value by status

SELECT
    transaction_status,
    COUNT(*) AS transaction_count,
    ROUND(SUM(product_amount), 2) AS transaction_value
FROM digital_wallet_transactions
GROUP BY transaction_status
ORDER BY transaction_value DESC;


-- 6. Transaction performance by payment method

SELECT
    payment_method,
    transaction_status,
    COUNT(*) AS transaction_count,
    ROUND(SUM(product_amount), 2) AS transaction_value
FROM digital_wallet_transactions
GROUP BY payment_method, transaction_status
ORDER BY payment_method, transaction_count DESC;


-- 7. Failure rate by payment method

SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(transaction_status = 'Failed') AS failed_transactions,
    ROUND(
        SUM(transaction_status = 'Failed') / COUNT(*) * 100,
        2
    ) AS failure_rate
FROM digital_wallet_transactions
GROUP BY payment_method
ORDER BY failure_rate DESC;


-- 8. Failed transaction value by payment method

SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(transaction_status = 'Failed') AS failed_transactions,
    ROUND(
        SUM(
            CASE
                WHEN transaction_status = 'Failed'
                THEN product_amount
                ELSE 0
            END
        ),
        2
    ) AS failed_transaction_value
FROM digital_wallet_transactions
GROUP BY payment_method
ORDER BY failed_transaction_value DESC;


-- 9. Failure rate by device type

SELECT
    device_type,
    COUNT(*) AS total_transactions,
    SUM(transaction_status = 'Failed') AS failed_transactions,
    ROUND(
        SUM(transaction_status = 'Failed') / COUNT(*) * 100,
        2
    ) AS failure_rate
FROM digital_wallet_transactions
GROUP BY device_type
ORDER BY failure_rate DESC;


-- 10. Failure rate by product category

SELECT
    product_category,
    COUNT(*) AS total_transactions,
    SUM(transaction_status = 'Failed') AS failed_transactions,
    ROUND(
        SUM(transaction_status = 'Failed') / COUNT(*) * 100,
        2
    ) AS failure_rate
FROM digital_wallet_transactions
GROUP BY product_category
ORDER BY failure_rate DESC;
