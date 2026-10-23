-- Projeto 01 - Análise de Desempenho de Obras
-- SQL utilizado na análise exploratória do projeto
-- Banco/tabela: obras_produtividade

-- ============================================================
-- 1. VISÃO GERAL DOS DADOS
-- ============================================================
SELECT
    COUNT(*) AS quantidade_registros,
    ROUND(SUM(custo_realizado), 2) AS custo_total,
    ROUND(SUM(quantidade_planejada), 2) AS quantidade_planejada,
    ROUND(SUM(quantidade_executada), 2) AS quantidade_executada,
    ROUND(AVG(dias_atraso), 2) AS atraso_medio
FROM obras_produtividade;


-- ============================================================
-- 2. CUSTO TOTAL POR OBRA
-- ============================================================
SELECT
    obra,
    ROUND(SUM(custo_realizado), 2) AS custo_total
FROM obras_produtividade
GROUP BY obra
ORDER BY custo_total DESC;


-- ============================================================
-- 3. PRODUTIVIDADE POR EQUIPE
-- Produtividade = quantidade executada / horas trabalhadas
-- ============================================================
SELECT
    equipe,
    ROUND(SUM(quantidade_executada), 2) AS quantidade_total,
    ROUND(SUM(horas_trabalhadas), 2) AS horas_total,
    ROUND(
        SUM(quantidade_executada) / NULLIF(SUM(horas_trabalhadas), 0),
        2
    ) AS produtividade
FROM obras_produtividade
GROUP BY equipe
ORDER BY produtividade DESC;


-- ============================================================
-- 4. CUSTO POR UNIDADE POR SERVIÇO
-- ============================================================
SELECT
    servico,
    ROUND(SUM(custo_realizado), 2) AS custo_total,
    ROUND(SUM(quantidade_executada), 2) AS quantidade_total,
    ROUND(
        SUM(custo_realizado) / NULLIF(SUM(quantidade_executada), 0),
        2
    ) AS custo_por_unidade
FROM obras_produtividade
GROUP BY servico
ORDER BY custo_por_unidade DESC;


-- ============================================================
-- 5. ANÁLISE DE ATRASOS COM CASE WHEN
-- ============================================================
SELECT
    CASE
        WHEN dias_atraso > 0 THEN 'Com atraso'
        ELSE 'No prazo'
    END AS situacao,
    COUNT(*) AS quantidade_registros,
    ROUND(AVG(dias_atraso), 2) AS atraso_medio
FROM obras_produtividade
GROUP BY situacao;


-- ============================================================
-- 6. PRODUTIVIDADE E ATRASO POR CONDIÇÃO CLIMÁTICA
-- ============================================================
SELECT
    condicao_climatica,
    ROUND(
        SUM(quantidade_executada) / NULLIF(SUM(horas_trabalhadas), 0),
        2
    ) AS produtividade,
    ROUND(AVG(dias_atraso), 2) AS atraso_medio,
    COUNT(*) AS quantidade_registros
FROM obras_produtividade
GROUP BY condicao_climatica
ORDER BY atraso_medio DESC;


-- ============================================================
-- 7. RANKING DE PRODUTIVIDADE DAS EQUIPES COM CTE
-- ============================================================
WITH produtividade_equipes AS (
    SELECT
        equipe,
        SUM(quantidade_executada) /
            NULLIF(SUM(horas_trabalhadas), 0) AS produtividade
    FROM obras_produtividade
    GROUP BY equipe
)
SELECT
    equipe,
    ROUND(produtividade, 2) AS produtividade,
    RANK() OVER (ORDER BY produtividade DESC) AS ranking
FROM produtividade_equipes
ORDER BY ranking;


-- ============================================================
-- 8. EVOLUÇÃO MENSAL DA PRODUTIVIDADE, CUSTO E ATRASO
-- ============================================================
SELECT
    strftime('%Y-%m', data) AS mes,
    ROUND(
        SUM(quantidade_executada) /
            NULLIF(SUM(horas_trabalhadas), 0),
        2
    ) AS produtividade,
    ROUND(SUM(custo_realizado), 2) AS custo_total,
    ROUND(AVG(dias_atraso), 2) AS atraso_medio
FROM obras_produtividade
GROUP BY mes
ORDER BY mes;


-- ============================================================
-- 9. PLANEJADO X EXECUTADO POR SERVIÇO
-- ============================================================
SELECT
    servico,
    ROUND(SUM(quantidade_planejada), 2) AS quantidade_planejada,
    ROUND(SUM(quantidade_executada), 2) AS quantidade_executada,
    ROUND(
        SUM(quantidade_executada) - SUM(quantidade_planejada),
        2
    ) AS desvio_quantidade,
    ROUND(
        100.0 *
        (SUM(quantidade_executada) - SUM(quantidade_planejada)) /
        NULLIF(SUM(quantidade_planejada), 0),
        2
    ) AS desvio_percentual
FROM obras_produtividade
GROUP BY servico
ORDER BY desvio_percentual DESC;


-- ============================================================
-- 10. HORAS DE RETRABALHO POR SERVIÇO
-- ============================================================
SELECT
    servico,
    ROUND(SUM(horas_retrabalho), 2) AS horas_retrabalho,
    ROUND(SUM(horas_trabalhadas), 2) AS horas_trabalhadas,
    ROUND(
        100.0 * SUM(horas_retrabalho) /
        NULLIF(SUM(horas_trabalhadas), 0),
        2
    ) AS taxa_retrabalho
FROM obras_produtividade
GROUP BY servico
ORDER BY horas_retrabalho DESC;
