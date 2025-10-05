-- Faça uma análise de crescimento mensal e o caálculo de YTD

-- Receitas Mensais
WITH Receitas_Mensais AS (
	SELECT
		EXTRACT (YEAR FROM orders.order_date) AS Ano,
		EXTRACT (MONTH FROM orders.order_date) AS Mês,
		SUM((order_details.unit_price * order_details.quantity) * (1 - order_details.discount)) 
		AS Total
	FROM
		orders
	INNER JOIN 
		order_details ON orders.order_id = order_details.order_id
	GROUP BY Ano
	GROUP BY Mes
)

SELECT * FROM Receitas_Mensais;

