"""
Projeto 01 - Análise de Produtividade em Obras
Autor: Guilherme Nascimento

Objetivo:
- carregar e validar os dados;
- criar indicadores de produtividade, custo e atraso;
- responder perguntas de negócio;
- exportar tabelas agregadas para Power BI.
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

DATA = ROOT / "data" / "raw" / "obras_produtividade.csv"

OUT = ROOT / "resultados" / "EDA"
OUT.mkdir(parents=True, exist_ok=True)

df = pd.read_csv(DATA, parse_dates=["data"])

# -----------------------------
# Qualidade e transformação
# -----------------------------
print("Dimensões:", df.shape)
print("\nValores nulos:")
print(df.isna().sum())
print("\nDuplicados:", df.duplicated().sum())

df["produtividade"] = df["quantidade_executada"] / df["horas_trabalhadas"]
df["desvio_quantidade_pct"] = (
    (df["quantidade_executada"] - df["quantidade_planejada"])
    / df["quantidade_planejada"]
) * 100
df["custo_por_unidade"] = df["custo_realizado"] / df["quantidade_executada"]

# -----------------------------
# Perguntas de negócio
# -----------------------------

# 1. Quais serviços têm maior produtividade?
q1 = (
    df.groupby("servico", as_index=False)
      .agg(produtividade_media=("produtividade", "mean"),
           custo_total=("custo_realizado", "sum"),
           atraso_medio=("dias_atraso", "mean"))
      .sort_values("produtividade_media", ascending=False)
)
q1.to_csv(OUT / "01_servicos.csv", index=False)

# 2. Quais equipes apresentam maior produtividade?
q2 = (
    df.groupby("equipe", as_index=False)
      .agg(produtividade_media=("produtividade", "mean"),
           horas=("horas_trabalhadas", "sum"),
           quantidade=("quantidade_executada", "sum"),
           atraso_medio=("dias_atraso", "mean"))
      .sort_values("produtividade_media", ascending=False)
)
q2.to_csv(OUT / "02_equipes.csv", index=False)

# 3. Quais obras concentram maior custo?
q3 = (
    df.groupby(["obra", "cidade"], as_index=False)
      .agg(custo_total=("custo_realizado", "sum"),
           atraso_medio=("dias_atraso", "mean"),
           qualidade_media=("indice_qualidade", "mean"))
      .sort_values("custo_total", ascending=False)
)
q3.to_csv(OUT / "03_obras.csv", index=False)

# 4. O clima está associado ao atraso?
q4 = (
    df.groupby("condicao_climatica", as_index=False)
      .agg(atraso_medio=("dias_atraso", "mean"),
           produtividade_media=("produtividade", "mean"),
           registros=("id_registro", "count"))
)
q4.to_csv(OUT / "04_clima.csv", index=False)

# 5. Evolução mensal
q5 = (
    df.assign(mes_ano=df["data"].dt.to_period("M").astype(str))
      .groupby("mes_ano", as_index=False)
      .agg(custo_total=("custo_realizado", "sum"),
           produtividade_media=("produtividade", "mean"),
           atraso_medio=("dias_atraso", "mean"),
           qualidade_media=("indice_qualidade", "mean"))
)
q5.to_csv(OUT / "05_evolucao_mensal.csv", index=False)

# -----------------------------
# Gráfico simples
# -----------------------------
plt.figure(figsize=(10, 5))
q1_sorted = q1.sort_values("produtividade_media")
plt.barh(q1_sorted["servico"], q1_sorted["produtividade_media"])
plt.title("Produtividade média por serviço")
plt.xlabel("Unidades executadas por hora")
plt.tight_layout()
plt.savefig(OUT / "produtividade_por_servico.png", dpi=160)
plt.close()

print("\nArquivos exportados para:", OUT)
