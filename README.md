# Irembo Voice AI Analytics Project

## Overview
This project evaluates whether Voice AI improves accessibility, efficiency, and adoption for public services.

The project includes:
* **Data modeling**: Fact and Staging layers.
* **Behavioral analysis**: SQL-based insight generation.
* **Friction simulation**: Modeling impact of misunderstandings and errors.
* **Success uplift projections**: What-if analysis for service improvement.
* **Executive-ready outputs**: Metabase dashboards and PDF reports.

---

## Repository Structure
```text
irembo-voice-ai-analytics/
├── README.md
├── analytics/
│   ├── stg_voice_sessions.sql
│   ├── stg_users.sql
│   ├── stg_turn_agg.sql
│   ├── stg_voice_ai_metrics.sql
│   ├── stg_applications.sql
│   ├── stg_applications_dedup.sql
│   └── fact_voice_ai_sessions.sql
├── analysis/
│   ├── 01_basic_health_check.sql
│   ├── 02_voice_vs_non_voice_completion.sql
│   ├── 03_first_time_user_analysis.sql
│   ├── 04_turn_category_analysis.sql
│   ├── 05_misunderstanding_impact.sql
│   ├── 06_error_impact.sql
│   ├── 07_escalation_analysis.sql
│   ├── 08_asr_confidence_analysis.sql
│   ├── 09_friction_severity_index.sql
│   └── 10_error_reduction_simulation.sql
└── metabase/
    ├── Irembo_VoiceAi_Dashboard.pdf
    ├── Irembo_VoiceAi_Report.pdf



flowchart TD
    %% Execution Layer
    subgraph "Execution Environment"
        direction TB
        README["README documentation"]:::doc
        SQL_EDITOR["Supabase SQL Editor"]:::exec
        PG["PostgreSQL / Supabase Engine"]:::db
        README --> SQL_EDITOR
        SQL_EDITOR --> PG
    end

    %% Source Layer
    subgraph "Tier 1 — Raw Source Tables"
        direction TB
        RAW_SESS[("Raw: Voice sessions")]:::raw
        RAW_TURNS[("Raw: Turn logs")]:::raw
        RAW_USERS[("Raw: Users")]:::raw
        RAW_APPS[("Raw: Applications")]:::raw
        RAW_METRICS[("Raw: AI Metrics")]:::raw
    end

    PG --> RAW_SESS
    PG --> RAW_TURNS
    PG --> RAW_USERS
    PG --> RAW_APPS
    PG --> RAW_METRICS

    %% Transformation Layer
    subgraph "Tier 2 — Transformation Layer (analytics/)"
        direction TB
        STG_SESS["stg_voice_sessions"]:::staging
        STG_TURNS["stg_turn_agg"]:::staging
        STG_APPS["stg_applications"]:::staging
        FACT[("fact_voice_ai_sessions")]:::fact
    end

    RAW_SESS --> STG_SESS
    RAW_TURNS --> STG_TURNS
    RAW_APPS --> STG_APPS
    STG_SESS & STG_TURNS & STG_APPS --> FACT

    %% Analysis Layer
    subgraph "Tier 3 — Analysis (analysis/*.sql)"
        direction TB
        A_KPI["Descriptive Analytics"]:::analysis
        A_SIM["Friction Simulation"]:::simulation
    end

    FACT --> A_KPI
    FACT --> A_SIM

    %% BI Layer
    subgraph "Tier 4 — BI / Consumption"
        direction TB
        MB["Metabase Dashboards"]:::bi
        PDF["PDF Reports"]:::artifact
    end

    A_KPI --> MB
    A_SIM --> MB
    MB --> PDF

    %% Styles
    classDef raw fill:#ECEFF1,stroke:#546E7A,color:#263238
    classDef staging fill:#E3F2FD,stroke:#1E88E5,color:#0D47A1
    classDef fact fill:#F3E5F5,stroke:#8E24AA,stroke-width:2px,color:#4A148C
    classDef analysis fill:#E8F5E9,stroke:#43A047,color:#1B5E20





-----

Data ModelPrimary fact table: analytics.fact_voice_ai_sessions.This table serves as the "Gold" layer, integrating:Voice session event dataUser demographic and cohort attributesASR (Automatic Speech Recognition) performance metricsApplication status outcomes (Success/Failure)How To Run The CodeThis project was developed using PostgreSQL (Supabase).Connect to your Supabase project.Open the SQL Editor.Staging: Run scripts in the analytics/ folder (e.g., stg_users.sql, stg_voice_sessions.sql).Modeling: Run fact_voice_ai_sessions.sql.Analysis: Execute specific queries within the analysis/ folder to generate insights.Visual Insights & DashboardsAnalysis ComponentPreviewChannel CompletionError ImpactFriction Severity IndexDetailed Documentation: Download Executive Summary PDFTools UsedPostgreSQL: Primary DatabaseMetabase: Business Intelligence & VisualizationMermaid.js: Architecture DocumentationAuthor: Ibrahim SaniData Analytics Engineer, Consultant – Irembo Voice AI



    classDef simulation fill:#DFF7E3,stroke:#2E7D32,stroke-width:2px,color:#1B5E20
    classDef bi fill:#FFE0B2,stroke:#EF6C00,color:#E65100
    classDef artifact fill:#FFCCBC,stroke:#D84315,color:#BF360C
    classDef exec fill:#E0F7FA,stroke:#00838F,color:#004D40
    classDef db fill:#E0E0E0,stroke:#424242,color:#212121
    classDef doc fill:#E1F5FE,stroke:#0277BD,color:#01579B
