# Irembo Voice AI Analytics Project

## Overview

This project evaluates whether Voice AI improves accessibility, efficiency, and adoption for public services.

The project includes:

- Data modeling (fact + staging)
- Behavioral analysis queries
- Friction simulation
- Success uplift projections
- Executive-ready analytical outputs

---

# Repository Structure

irembo-voice-ai-analytics/
│
├── README.md
│
├── analytics/
│   ├── stg_voice_sessions.sql
│   ├── stg_users.sql
│   ├── stg_turn_agg.sql
│   ├── stg_voice_ai_metrics.sql
│   ├── stg_applications.sql
│   ├── stg_applications_dedup.sql
│   └── fact_voice_ai_sessions.sql
│
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
│
└── dashboards/
    ├── channel_completion.png
    ├── first_time_users.png
    ├── error_impact.png
    ├── misunderstanding_impact.png
    └── friction_severity.png



---

# Data Model

Primary fact table:

analytics.fact_voice_ai_sessions

This fact table integrates:

- Voice session data
- User attributes
- AI performance metrics
- Application outcomes
- Turn-level aggregations

---

# How To Run The Code

This project was developed using PostgreSQL (Supabase).

 Supabase SQL Editor

1. Connect to your Supabase project
2. Open SQL Editor
3. Run staging scripts first:
   - stg_voice_sessions.sql
   - stg_users.sql
   - stg_turn_agg.sql
   - stg_voice_ai_metrics.sql
   - stg_applications.sql

4. Run fact model:
   - fact_voice_ai_sessions.sql

5. Run analysis queries inside the `analysis/` folder

---


## Assumptions
* Session-level aggregation used for modeling

* Misunderstanding threshold set at 0.33

* Error defined as total_error_turns > 0

* Completion defined as session_completed_flag = TRUE

Application success defined as application_success_flag = TRUE

## Tools Used
PostgreSQL (Supabase)

Metabase (Dashboard visualization)

SQL modeling

Friction simulation modeling

Author
Ibrahim Sani
Data Analytics Engineer, Consultant  – Irembo Voice AI
