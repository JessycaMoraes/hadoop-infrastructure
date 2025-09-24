SELECT
    u.state,
    COUNT(o.order_id) AS total_pedidos,
    SUM(oi.sale_price) AS receita_total
FROM
    orders o
JOIN
    users u ON o.user_id = u.id
JOIN
    order_items oi ON o.order_id = oi.order_id
GROUP BY
    u.state
ORDER BY
    receita_total DESC
LIMIT 10;