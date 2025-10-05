-- Qual é o valor total que cada cliente já pagou até agora?
CREATE VIEW view_total_receitas_por_cliente AS
SELECT 
	customers.company_name,
	SUM(order_details.unit_price * order_details.quantity *(1 - order_details.discount)) AS Total
FROM
	customers
INNER JOIN
	orders ON customers.customer_id = orders.customer_id
INNER JOIN
	order_details ON order_details.order_id = orders.order_id
GROUP BY
	customers.company_name
ORDER BY 
	Total DESC;