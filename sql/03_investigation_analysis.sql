/*
=========================================================
 Operations Control Tower
 Investigation & Risk Operations Analysis
 Microsoft SQL Server
=========================================================

Purpose:
Analyze investigation workload, risk levels,
SLA performance, escalations and resolution efficiency.

Dataset: Synthetic portfolio data
=========================================================
*/

USE amazon_operations;
GO


/* =====================================================
   1. OVERALL INVESTIGATION KPIs
   ===================================================== */

SELECT
    COUNT(*) AS total_cases,

    SUM(
        CASE
            WHEN investigation_status = 'Open'
            THEN 1 ELSE 0
        END
    ) AS open_cases,

    SUM(
        CASE
            WHEN risk_level = 'High'
            THEN 1 ELSE 0
        END
    ) AS high_risk_cases,

    SUM(
        CASE
            WHEN escalation_status = 'Escalated'
            THEN 1 ELSE 0
        END
    ) AS escalated_cases,

    SUM(
        CASE
            WHEN resolution_hours > sla_hours
            THEN 1 ELSE 0
        END
    ) AS sla_breached_cases,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN resolution_hours <= sla_hours
                THEN 1 ELSE 0
            END
        ) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS sla_compliance_percentage,

    CAST(
        AVG(resolution_hours * 1.0)
        AS DECIMAL(6,2)
    ) AS avg_resolution_hours

FROM investigation_cases;
GO


/* =====================================================
   2. CASE TYPE ANALYSIS
   ===================================================== */

SELECT
    case_type,
    COUNT(*) AS total_cases,

    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS percentage

FROM investigation_cases

GROUP BY case_type
ORDER BY total_cases DESC;
GO


/* =====================================================
   3. RISK LEVEL ANALYSIS
   ===================================================== */

SELECT
    risk_level,

    COUNT(*) AS total_cases,

    SUM(
        CASE
            WHEN escalation_status = 'Escalated'
            THEN 1 ELSE 0
        END
    ) AS escalated_cases,

    CAST(
        AVG(resolution_hours * 1.0)
        AS DECIMAL(6,2)
    ) AS avg_resolution_hours

FROM investigation_cases

GROUP BY risk_level
ORDER BY total_cases DESC;
GO


/* =====================================================
   4. SLA PERFORMANCE
   ===================================================== */

SELECT
    CASE
        WHEN resolution_hours <= sla_hours
        THEN 'Within SLA'
        ELSE 'SLA Breached'
    END AS sla_status,

    COUNT(*) AS total_cases

FROM investigation_cases

GROUP BY
    CASE
        WHEN resolution_hours <= sla_hours
        THEN 'Within SLA'
        ELSE 'SLA Breached'
    END;
GO


/* =====================================================
   5. INVESTIGATION TEAM PERFORMANCE
   ===================================================== */

SELECT
    investigator_team,

    COUNT(*) AS total_cases,

    SUM(
        CASE
            WHEN resolution_hours <= sla_hours
            THEN 1 ELSE 0
        END
    ) AS cases_within_sla,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN resolution_hours <= sla_hours
                THEN 1 ELSE 0
            END
        ) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS sla_compliance_percentage,

    CAST(
        AVG(resolution_hours * 1.0)
        AS DECIMAL(6,2)
    ) AS avg_resolution_hours

FROM investigation_cases

GROUP BY investigator_team
ORDER BY sla_compliance_percentage DESC;
GO


/* =====================================================
   6. ESCALATION ANALYSIS
   ===================================================== */

SELECT
    risk_level,
    escalation_status,
    COUNT(*) AS total_cases

FROM investigation_cases

GROUP BY
    risk_level,
    escalation_status

ORDER BY
    risk_level,
    total_cases DESC;
GO


/* =====================================================
   7. CASE STATUS ANALYSIS
   ===================================================== */

SELECT
    investigation_status,
    COUNT(*) AS total_cases

FROM investigation_cases

GROUP BY investigation_status
ORDER BY total_cases DESC;
GO
