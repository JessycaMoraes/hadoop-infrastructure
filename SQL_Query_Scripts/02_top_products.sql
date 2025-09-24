SELECT
    p.name AS nome_produto,
    p.category AS categoria_produto,
    COUNT(oi.id) AS total_itens_vendidos
FROM
    order_items oi
JOIN
    products p ON oi.product_id = p.id
GROUP BY
    p.name, p.category
ORDER BY
    total_itens_vendidos DESC
LIMIT 10;