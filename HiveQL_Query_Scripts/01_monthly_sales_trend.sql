SELECT
    date_format(o.created_at, 'yyyy-MM') AS periodo_mes,
    COUNT(o.order_id) AS total_pedidos,
    SUM(oi.sale_price) AS receita_total
FROM
    orders o
JOIN
    order_items oi ON o.order_id = oi.order_id
GROUP BY
    date_format(o.created_at, 'yyyy-MM')
ORDER BY
    periodo_mes;
