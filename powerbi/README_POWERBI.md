# Power BI — Guia do projeto

## Modelo

Para a primeira versão, use a tabela `obras_produtividade` como fato principal.

Crie uma tabela calendário:

```DAX
Calendario =
ADDCOLUMNS(
    CALENDAR(
        MIN(obras_produtividade[data]),
        MAX(obras_produtividade[data])
    ),
    "Ano", YEAR([Date]),
    "Mês", MONTH([Date]),
    "Mês Ano", FORMAT([Date], "YYYY-MM")
)
```

Relacione:

`Calendario[Date]` 1 ---- * `obras_produtividade[data]`

## Medidas DAX

### Custo total
```DAX
Custo Total =
SUM(obras_produtividade[custo_realizado])
```

### Quantidade executada
```DAX
Quantidade Executada =
SUM(obras_produtividade[quantidade_executada])
```

### Horas trabalhadas
```DAX
Horas Trabalhadas =
SUM(obras_produtividade[horas_trabalhadas])
```

### Produtividade
```DAX
Produtividade =
DIVIDE(
    [Quantidade Executada],
    [Horas Trabalhadas]
)
```

### Atraso médio
```DAX
Atraso Médio =
AVERAGE(obras_produtividade[dias_atraso])
```

### Qualidade média
```DAX
Qualidade Média =
AVERAGE(obras_produtividade[indice_qualidade])
```

### Custo por unidade
```DAX
Custo por Unidade =
DIVIDE(
    [Custo Total],
    [Quantidade Executada]
)
```

### Desvio de quantidade
```DAX
Desvio Quantidade % =
DIVIDE(
    SUM(obras_produtividade[quantidade_executada])
        - SUM(obras_produtividade[quantidade_planejada]),
    SUM(obras_produtividade[quantidade_planejada])
)
```

## Página 1 — Visão Executiva

Cards:
- Custo Total
- Quantidade Executada
- Produtividade
- Atraso Médio
- Qualidade Média

Gráficos:
1. Linha: custo total por mês
2. Barras: produtividade por serviço
3. Barras: custo por obra
4. Colunas: atraso médio por condição climática

Filtros:
- Ano
- Cidade
- Obra
- Serviço
- Equipe

## Página 2 — Produtividade

Visualizações:
- produtividade por equipe
- produtividade por serviço
- quantidade executada x horas trabalhadas
- custo por unidade

## Página 3 — Atrasos e Qualidade

Visualizações:
- atraso médio por obra
- atraso por condição climática
- qualidade média por serviço
- retrabalho por serviço

## Storytelling

O dashboard deve responder:

1. Onde está o maior custo?
2. Quais serviços apresentam menor produtividade?
3. Quais equipes possuem maior produtividade?
4. Como o atraso varia conforme a condição climática?
5. Onde existe maior retrabalho?
6. A qualidade está associada ao retrabalho?
