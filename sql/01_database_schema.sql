/*
Operations Control Tower
Database Schema
Technology: Microsoft SQL Server

All data used in this project is synthetic
and created for portfolio/educational purposes.
*/

CREATE DATABASE amazon_operations;
GO

USE amazon_operations;
GO

CREATE TABLE shipments
(
    shipment_id INT PRIMARY KEY,
    shipment_date DATE,
    origin_station VARCHAR(50),
    destination_station VARCHAR(50),
    carrier VARCHAR(50),
    promised_delivery_date DATE,
    actual_delivery_date DATE,
    shipment_status VARCHAR(30),
    exception_type VARCHAR(100),
    distance_km INT
);
GO

CREATE TABLE investigation_cases
(
    case_id INT PRIMARY KEY,
    case_date DATE NOT NULL,
    case_type VARCHAR(50),
    risk_level VARCHAR(20),
    investigation_status VARCHAR(30),
    resolution VARCHAR(50),
    sla_hours INT,
    resolution_hours INT,
    investigator_team VARCHAR(30),
    escalation_status VARCHAR(20),
    transaction_value DECIMAL(10,2)
);
GO
