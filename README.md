# Operations Control Tower
### Transportation, SLA & Risk Investigation Analytics

An end-to-end operations analytics portfolio project built using **Microsoft SQL Server, Power BI, SQL, and DAX**.

The project simulates an operations control tower for monitoring transportation performance, delivery exceptions, SLA compliance, investigation workflows, risk levels, escalations, and operational performance.

> **Note:** All data used in this project is synthetic and was created solely for educational and portfolio purposes.

---

## 📊 Project Overview

The project contains two interactive Power BI dashboards:

### 1. Transportation Operations Control Tower
Monitors shipment and last-mile operational performance across carriers, routes, exceptions, and SLA metrics.

### 2. Investigation & Risk Operations Control Tower
Monitors investigation workload, case risk, escalations, SLA performance, and resolution efficiency.

---

## 🚚 Transportation Operations Dashboard

![Transportation Operations Dashboard](screenshots/transportation_dashboard.png)

### Key Analysis

- Total shipment volume
- On-time delivery percentage
- Delayed shipments
- SLA breaches
- Carrier performance
- Delivery exception root-cause analysis
- SLA priority distribution
- Shipment volume trends
- Carrier and origin-station filtering

---

## 🔎 Investigation & Risk Operations Dashboard

![Investigation & Risk Dashboard](screenshots/investigation_dashboard.png)

### Key Analysis

- Total investigation cases
- Open cases
- High-risk cases
- Escalated cases
- SLA compliance
- Risk-level distribution
- Investigation cases by type
- Investigation case status
- SLA compliance by investigation team
- Interactive risk and case-type filtering

---

## 🛠 Technology Stack

| Technology | Usage |
|---|---|
| Microsoft SQL Server | Database and analytical processing |
| SQL | KPI calculations, aggregations and root-cause analysis |
| Power BI | Interactive operations dashboards |
| DAX | Dynamic KPI measures and filtering |
| GitHub | Project documentation and version control |

---

## 🗄 Data Model

The project analyzes two synthetic operational datasets.

### Transportation Data

More than **5,000 synthetic shipment records** containing:

- Shipment ID
- Shipment date
- Origin and destination station
- Carrier
- Promised delivery date
- Actual delivery date
- Shipment status
- Exception type
- Distance

### Investigation Data

**3,000 synthetic investigation cases** containing:

- Case ID
- Case date
- Case type
- Risk level
- Investigation status
- Resolution
- SLA target
- Resolution time
- Investigation team
- Escalation status
- Transaction value

---

## 💻 SQL Analysis

SQL Server is used to perform:

- Operational KPI calculation
- Carrier performance analysis
- Delivery delay analysis
- Exception root-cause analysis
- Route performance analysis
- SLA classification
- Risk segmentation
- Investigation workload analysis
- Escalation analysis
- Investigation-team performance analysis

Reporting-ready SQL views were created to provide transformed datasets directly to Power BI.

---

## 📐 DAX Measures

Example Power BI measures include:

```DAX
Total Shipments =
DISTINCTCOUNT(
    vw_transportation_control_tower[shipment_id]
)
```

```DAX
On Time % =
DIVIDE(
    [On Time Shipments],
    [Total Shipments],
    0
)
```

```DAX
Total Cases =
DISTINCTCOUNT(
    vw_investigation_risk_operations[case_id]
)
```

```DAX
SLA Compliance % =
DIVIDE(
    [Cases Within SLA],
    [Total Cases],
    0
)
```

---

## 📁 Repository Structure

```text
operations-control-tower/
│
├── powerbi/
│   └── operations_control_tower.pbix
│
├── screenshots/
│   ├── transportation_dashboard.png
│   └── investigation_dashboard.png
│
├── sql/
│   ├── 01_database_schema.sql
│   ├── 02_transportation_analysis.sql
│   ├── 03_investigation_analysis.sql
│   └── 04_analytics_views.sql
│
└── README.md
```

---

## 🎯 Skills Demonstrated

- SQL
- Microsoft SQL Server
- Power BI
- DAX
- Data Analysis
- Data Visualization
- KPI Reporting
- Operations Analytics
- Transportation Analytics
- SLA Monitoring
- Exception Management
- Root Cause Analysis
- Risk Analysis
- Investigation Operations
- Operational Performance Reporting

---

## 💡 Project Workflow

```text
Synthetic Operational Data
          ↓
 Microsoft SQL Server
          ↓
 SQL Cleaning & Transformation
          ↓
 Analytical SQL Views
          ↓
       Power BI
          ↓
    DAX Measures
          ↓
Interactive Operations Dashboards
```

---

## 🔐 Data Disclaimer

This is an **independent portfolio project**.

All shipment and investigation records are **synthetically generated** and do not contain real customer, seller, employee, carrier, or company operational information.

This project is not affiliated with or endorsed by Amazon or any other company.

---

## 👤 Author

**Devendra Singh**

Operations Analytics | SQL | Power BI | Data Analysis
