Company Finance Database – SQL Mini Project
Project Overview

This project is a SQL-based company finance management system that tracks departments, revenue, expenses, and calculates profit using views and stored procedures.

Database Used

MySQL

Tables

departments – stores department and manager details

revenue – stores department-wise revenue

expenses – stores department-wise expenses

Foreign keys are used to maintain relationships between tables.

Key SQL Concepts Used

CREATE DATABASE & TABLE

PRIMARY KEY & FOREIGN KEY

INSERT & SELECT

JOINS

AGGREGATE FUNCTIONS (SUM)

VIEW

STORED PROCEDURE

View

vw_department_financials

Shows total revenue, total expenses, and profit for each department

Stored Procedure

get_department_profits()

Returns department-wise financial summary

Output

Department-wise Revenue

Department-wise Expenses

Profit Calculation
