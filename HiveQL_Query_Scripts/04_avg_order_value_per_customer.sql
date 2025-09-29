SELECT
    u.id AS id_cliente,
    u.first_name,
    u.last_name,
    AVG(sub.valor_pedido) AS valor_medio_pedido
FROM
    (SELECT
        order_id,
        user_id,
        SUM(sale_price) AS valor_pedido
    FROM
        order_items
    GROUP BY
        order_id, user_id
    ) sub
JOIN
    users u ON sub.user_id = u.id
GROUP BY
    u.id, u.first_name, u.last_name
ORDER BY
    valor_medio_pedido DESC
LIMIT 10;