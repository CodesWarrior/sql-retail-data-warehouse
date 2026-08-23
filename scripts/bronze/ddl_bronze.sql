/*-------------------------------------------------
    RETAIL DATA WAREHOUSE
    BRONZE LAYER - DDL

    Purpose:
    Create the Bronze layer tables used to store
    raw CRM and ERP data loaded from CSV files.

    Source Systems:
    - CRM: Customer and Sales data
    - ERP: Product, Inventory, Supplier, and Warehouse data

    Bronze Layer:
    - Stores raw data as received from source systems
    - Minimal transformations are applied
    - Data types are selected mainly to support raw ingestion
-------------------------------------------------*/


/*=================================================
    DATABASE AND SCHEMA SETUP
=================================================*/

/*
Create the Retail Data Warehouse database and
Medallion Architecture schemas.

Schemas:
- bronze: Raw source data
- silver: Cleaned and standardized data
- gold: Business-ready analytical data

These statements only need to be executed when
setting up the database for the first time.
*/

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

/*=================================================
    CRM SOURCE SYSTEM
=================================================*/

/*-------------------------------------------------
    CRM CUSTOMER INFORMATION

    Stores raw customer master data from the CRM system.

    Grain:
    One row per customer.

    Source:
    CRM customer information CSV file.
-------------------------------------------------*/
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
cst_create_date VARCHAR(50));

/*-------------------------------------------------
    CRM CUSTOMER ADDRESS

    Stores raw customer address information.

    Grain:
    One row per customer address.

    A customer may have multiple address types,
    such as billing or shipping.
-------------------------------------------------*/

IF OBJECT_ID('Retail_DataWareHouse.bronze.crm_customer_address', 'U') IS NOT NULL
DROP TABLE Retail_DataWareHouse.bronze.crm_customer_address
GO
Create table Retail_DataWareHouse.bronze.crm_customer_address(
cst_id VARCHAR(50),
address_type VARCHAR(50),
street VARCHAR(50),
postal_code INT);

/*-------------------------------------------------
    CRM SALES ORDER LINES

    Stores raw line-level transaction data.

    Grain:
    One row per product line within an order.

    Example:
    One order containing 3 different products
    will produce 3 rows in this table.
-------------------------------------------------*/

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

/*-------------------------------------------------
    CRM SALES ORDERS

    Stores raw order-level transaction information.

    Grain:
    One row per sales order.

    Order-level information is separated from
    line-level product details.
-------------------------------------------------*/

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



/*=================================================
    ERP SOURCE SYSTEM
=================================================*/

/*-------------------------------------------------
    ERP INVENTORY

    Stores raw inventory information from the ERP system.

    Grain:
    One row per product per warehouse.
-------------------------------------------------*/

IF OBJECT_ID('Retail_DataWareHouse.bronze.erp_inventory', 'U') IS NOT NULL
DROP TABLE Retail_DataWareHouse.bronze.erp_inventory

GO
CREATE TABLE Retail_DataWareHouse.bronze.erp_inventory(
warehouse_id VARCHAR(50),
prd_id VARCHAR(50),
stock_qty VARCHAR(50),
reorder_level VARCHAR(50),
last_stock_date VARCHAR(50));

/*-------------------------------------------------
    ERP PRODUCT CATEGORY

    Stores raw product category and department
    information from the ERP system.

    Grain:
    One row per product category.
-------------------------------------------------*/
IF OBJECT_ID('Retail_DataWareHouse.bronze.erp_product_category', 'U') IS NOT NULL
DROP TABLE Retail_DataWareHouse.bronze.erp_product_category
GO
CREATE TABLE Retail_DataWareHouse.bronze.erp_product_category(
category_id VARCHAR(50),
category_name VARCHAR(50),
department VARCHAR(50));

/*-------------------------------------------------
    ERP PRODUCT INFORMATION

    Stores raw product master data.

    Grain:
    One row per product.

    Contains product identification, category,
    brand, cost, selling price, and effective date.
-------------------------------------------------*/

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
 prd_start_dt varchar(50));

 /*-------------------------------------------------
    ERP SUPPLIER

    Stores raw supplier master data.

    Grain:
    One row per supplier.
-------------------------------------------------*/

 IF OBJECT_ID ('Retail_DataWareHouse.bronze.erp_supplier', 'U') IS NOT NULL
 DROP TABLE Retail_DataWareHouse.bronze.erp_supplier
 GO
 CREATE TABLE Retail_DataWareHouse.bronze.erp_supplier(
 supplier_id VARCHAR (50),
 supplier_name VARCHAR (50),
 supplier_city VARCHAR (50));

 /*-------------------------------------------------
    ERP WAREHOUSE

    Stores raw warehouse master data.

    Grain:
    One row per warehouse.

    Capacity is initially stored as VARCHAR because
    this is raw Bronze-layer data and may require
    validation and standardization during the Silver layer.
-------------------------------------------------*/

 IF OBJECT_ID ('Retail_DataWareHouse.bronze.erp_warehouse', 'U') IS NOT NULL
 DROP TABLE Retail_DataWareHouse.bronze.erp_warehouse
 CREATE TABLE Retail_DataWareHouse.bronze.erp_warehouse(
 warehouse_id VARCHAR(50),
 warehouse_name VARCHAR(50),
 city VARCHAR(50),
 capacity VARCHAR(50));

