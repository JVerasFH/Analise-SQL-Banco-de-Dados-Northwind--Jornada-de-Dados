-- Identificar os 10 produtos mais vendidos.
CREATE VIEW top_10_produtos AS
SELECT 
	products.product_name, 
	SUM(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) AS Vendas
FROM 
	products
INNER JOIN order_details ON order_details.product_id = products.product_id
GROUP BY 
	products.product_name
ORDER BY 
	Vendas DESC;