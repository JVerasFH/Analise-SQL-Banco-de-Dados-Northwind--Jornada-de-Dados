-- Faça uma análise de crescimento mensal e o cálculo de YTD
CREATE VIEW view_receitas_acumuladas AS
WITH ReceitasMensais AS (
	SELECT
		EXTRACT(YEAR FROM o.order_date) AS Ano,
		EXTRACT(MONTH FROM o.order_date) AS Mes,
		SUM((os.unit_price * os.quantity) * (1 - os.discount)) AS Receita_Mensal
	FROM
		orders AS o
	INNER JOIN order_details AS os ON o.order_id = os.order_id
	GROUP BY Ano, Mes 
	ORDER BY Ano, Mes
),
ReceitasAcumuladas AS (
    SELECT
        Ano,
        Mes,
        Receita_Mensal,
        SUM(Receita_Mensal) OVER (PARTITION BY Ano ORDER BY Mes) AS Receita_YTD
    FROM
        ReceitasMensais
)

SELECT
    Ano,
    Mes,
    Receita_Mensal,
    Receita_Mensal - LAG(Receita_Mensal) OVER (PARTITION BY Ano ORDER BY Mes) AS Diferenca_Mensal,
    Receita_YTD,
    (Receita_Mensal - LAG(Receita_Mensal) OVER (PARTITION BY Ano ORDER BY Mes)) / LAG(Receita_Mensal) OVER (PARTITION BY Ano ORDER BY Mes) * 100 AS Percentual_Mudanca_Mensal
FROM
    ReceitasAcumuladas
ORDER BY
    Ano, Mes;