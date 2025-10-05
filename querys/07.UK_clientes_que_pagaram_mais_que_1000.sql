-- Quais clientes do Reino Unido pagaram mais de 1000 dólares?
CREATE VIEW UK_clientes_que_pagaram_mais_que_1000 AS
SELECT 
	customers.contact_name, 
	SUM(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount) * 100) / 100 AS Pagamentos
FROM 
	customers
INNER JOIN orders ON orders.customer_id = customers.customer_id
INNER JOIN order_details ON order_details.order_id = orders.order_id
WHERE LOWER(customers.country) = 'uk'
GROUP BY 
	customers.contact_name
HAVING SUM(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) > 1000;