SELECT
    status,
    COUNT(order_id) AS contagem
FROM
    orders
GROUP BY
    status
ORDER BY
    contagem DESC;