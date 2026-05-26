# Supply Chain Intelligence Platform

> Identifying $21M in revenue at risk across 180,519 orders using a star schema data model, automated ETL pipeline, advanced SQL analytics, and Prophet demand forecasting.

**Status: 🚧 In progress — Power BI dashboard coming soon**

---

## The Problem

A global retail company has a 57.3% late delivery rate — more than half of all orders arrive late. This project builds a complete analytics system to find out why, where, and what it costs.

## Biggest Findings So Far

- **First Class shipping: 100% late delivery rate** across 27,814 orders — every single order late
- **$21M revenue at risk** from late deliveries across 23 global regions
- **3 products dominate risk globally** — the same product ranks #1 in revenue at risk in every single region
- **Zero improvement in 3 years** — late rate flat at 57% from Jan 2015 to Jan 2018
- **Root cause is scheduling** — not geography, not customer type, not product category

## What's Built

| Phase | Status | What it is |
|---|---|---|
| Star schema design | ✅ Complete | fact_orders + 4 dim tables in SQLite |
| ETL pipeline | ✅ Complete | Modular Python pipeline with logging and run audit log |
| Exploratory analysis | ✅ Complete | 6 findings across shipping, region, category, trend, segment, correlation |
| Advanced SQL | ✅ Complete | CTEs, window functions, 3 SQL views as analytics layer |
| Statistical analysis + forecasting | ✅ Complete | Chi-square, Kruskal-Wallis, Prophet forecast (MAPE: 0.6%) |
| Power BI dashboard | 🚧 In progress | 3-page executive dashboard |

## Tech Stack

Python · pandas · SQLite · Prophet · scipy · matplotlib · seaborn · Power BI · SQL

## Dataset

[DataCo Smart Supply Chain Dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis) — 180,519 orders · 53 columns · 23 global regions · Jan 2015 to Jan 2018

---

*Full documentation, architecture diagram, and setup instructions coming with final release.*
