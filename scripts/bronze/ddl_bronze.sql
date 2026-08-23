
/*
Create Database Retail_DataWareHouse;
Go;
Use Retail_DataWareHouse;
GO;
create SCHEMA bronze;
Go;
create SCHEMA silver;
Go
create SCHEMA gold;
Go*/

IF OBJECT_ID('Retail_DataWareHouse.bronze.crm_customer_info', 'U') IS NOT NULL
DROP TABLE Retail_DataWareHouse.bronze.crm_customer_info
GO
create table Retail_DataWareHouse.bronze.crm_customer_info(
cst_id VARCHAR(50),
cst_firstname VARCHAR(50),
cst_lastname VARCHAR(50),
cst_gender VARCHAR(50),
cst_city VARCHAR(50),
cst_region VARCHAR(50),
cst_email VARCHAR(50),
cst_create_date DATE );

IF OBJECT_ID('Retail_DataWareHouse.bronze.crm_customer_address', 'U') IS NOT NULL
DROP TABLE Retail_DataWareHouse.bronze.crm_customer_address
GO
Create table Retail_DataWareHouse.bronze.crm_customer_address(
cst_id VARCHAR(50),
address_type VARCHAR(50),
street VARCHAR(50),
postal_code INT);

IF OBJECT_ID('Retail_DataWareHouse.bronze.crm_sales_order_lines', 'U') IS NOT NULL
DROP TABLE Retail_DataWareHouse.bronze.crm_sales_order_lines
GO
Create table Retail_DataWareHouse.bronze.crm_sales_order_lines(
line_id VARCHAR(50),
order_id VARCHAR(50),
prd_id VARCHAR(50),
quantity INT,
unit_price decimal(10,2),
discount decimal(5,4));

IF OBJECT_ID('Retail_DataWareHouse.bronze.crm_sales_orders', 'U') IS NOT NULL
DROP TABLE Retail_DataWareHouse.bronze.crm_sales_orders
GO
Create table Retail_DataWareHouse.bronze.crm_sales_orders(
order_id VARCHAR(50),
cst_id VARCHAR(50),
order_date VARCHAR(50),
warehouse_id VARCHAR(50),
payment_method VARCHAR(50),
order_status VARCHAR(50));

-- ERP


IF OBJECT_ID('Retail_DataWareHouse.bronze.erp_inventory', 'U') IS NOT NULL
DROP TABLE Retail_DataWareHouse.bronze.erp_inventory
GO
CREATE TABLE Retail_DataWareHouse.bronze.erp_inventory(
warehouse_id VARCHAR(50),
prd_id VARCHAR(50),
stock_qty VARCHAR (50),
reorder_level VARCHAR(50),
last_stock_date VARCHAR(50));

IF OBJECT_ID('Retail_DataWareHouse.bronze.erp_product_category', 'U') IS NOT NULL
DROP TABLE Retail_DataWareHouse.bronze.erp_product_category
GO
CREATE TABLE Retail_DataWareHouse.bronze.erp_product_category(
category_id VARCHAR(50),
category_name VARCHAR(50),
department VARCHAR(50));

 IF OBJECT_ID('Retail_DataWareHouse.bronze.erp_product_info', 'U') IS NOT NULL
 DROP TABLE Retail_DataWareHouse.bronze.erp_product_info
 GO
 CREATE TABLE Retail_DataWareHouse.bronze.erp_product_info(
 prd_id VARCHAR(50),
 prd_name VARCHAR(50),
 prd_category VARCHAR(50),
 prd_brand VARCHAR(50),
 prd_cost decimal(10,2),
 prd_price decimal(10,2),
 prd_start_dt DATE);

 IF OBJECT_ID ('Retail_DataWareHouse.bronze.erp_supplier', 'U') IS NOT NULL
 DROP TABLE Retail_DataWareHouse.bronze.erp_supplier
 GO
 CREATE TABLE Retail_DataWareHouse.bronze.erp_supplier(
 supplier_id VARCHAR (50),
 supplier_name VARCHAR (50),
 supplier_city VARCHAR (50));

 IF OBJECT_ID ('Retail_DataWareHouse.bronze.erp_warehouse', 'U') IS NOT NULL
 DROP TABLE Retail_DataWareHouse.bronze.erp_warehouse
 CREATE TABLE Retail_DataWareHouse.bronze.erp_warehouse(
 warehouse_id VARCHAR(50),
 warehouse_name VARCHAR(50),
 city VARCHAR(50),
 capacity VARCHAR(50));